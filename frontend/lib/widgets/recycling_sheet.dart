import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/models/activity.dart';
import 'package:project/services/api_service.dart';
import 'package:project/view_models/recycling_sheet_controller.dart';
import 'package:project/widgets/screen_starter.dart';

class RecyclingSheet extends StatefulWidget {
  final Function onClose;
  final String imageUrl;

  const RecyclingSheet({
    super.key,
    required this.onClose,
    required this.imageUrl,
  });

  @override
  State<RecyclingSheet> createState() => _RecyclingSheetState();
}

class _RecyclingSheetState extends State<RecyclingSheet> {
  bool _showRecycling = false;
  late String _itemToRecycle;

  @override
  Widget build(BuildContext context) {
    return ScreenStarter(
      child: FutureBuilder(
        future: ApiService.getGoogleVision(widget.imageUrl),
        builder: (_, res) {
          final data = res.data;

          if (data == null) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.blueGrey,
            ));
          }

          if (data.objects.isEmpty && !_showRecycling) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: _ExitButton(onPressed: widget.onClose),
                ),
                Center(
                  child: Text("Cannot identify object"),
                ),
              ],
            );
          }

          data.objects.forEach((element) {
            print(element.name);
          });

          if (!_showRecycling) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: _ExitButton(onPressed: widget.onClose),
                ),
                Text("Please select the correct item"),
                ...data.objects
                    .map(
                      (gvo) => ElevatedButton(
                        child: Text(gvo.name),
                        onPressed: () {
                          setState(() {
                            _itemToRecycle = gvo.name;
                            _showRecycling = true;
                          });
                        },
                      ),
                    )
                    .toList()
              ],
            );
          }

          return RecycleInfo(
            item: _itemToRecycle,
            onClose: widget.onClose,
            imageUrl: widget.imageUrl,
          );
        },
      ),
    );
  }
}

class _ExitButton extends StatelessWidget {
  final Function onPressed;

  const _ExitButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.exit_to_app),
      onPressed: () => onPressed(),
    );
  }
}

class RecycleInfo extends StatelessWidget {
  final String item;
  final Function onClose;
  final String imageUrl;

  const RecycleInfo({
    super.key,
    required this.item,
    required this.onClose,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final controller = RecyclingSheetController();

    return FutureBuilder(
        future: ApiService.getRecycleResponse(item),
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (data == null) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.blueGrey,
            ));
          }

          // Once response is loaded, add activity to recents
          controller.handleAddActivity(
            imageUrl: imageUrl,
            item: data.item,
            category: data.category,
          );

          return Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: _ExitButton(onPressed: onClose),
              ),
              const SizedBox(height: 20),
              Text(
                data.item,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Text(data.category),
              const SizedBox(height: 20),
              Text(data.instruction),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => onClose(),
                child: Text("I recycled"),
              ),
            ],
          );
        });
  }
}
