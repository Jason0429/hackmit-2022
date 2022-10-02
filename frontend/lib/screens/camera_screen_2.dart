import 'dart:convert';
import 'dart:io' as io;
import 'package:project/services/api_service.dart';
import 'package:project/widgets/recycling_sheet.dart';
import 'package:uuid/uuid.dart';

import 'package:project/services/storage_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/displaypicture_screen.dart';
import 'package:project/widgets/screen_starter.dart';
import 'package:path/path.dart' as path;

// A screen that allows users to take a picture using a given camera.
class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.cameras});
  final List<CameraDescription> cameras;
  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _showCameraButton = true;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      widget.cameras.first,
      // Define the resolution to use.
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  void _setShowCameraButton(bool value) {
    setState(() {
      _showCameraButton = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: ScreenStarter(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // final size = MediaQuery.of(context).size;
              // final deviceRatio = size.width / size.height;
              // // If the Future is complete, display the preview.
              return Transform.scale(
                scale: _controller.value.aspectRatio,
                child: CameraPreview(_controller),
              );
              // return CameraPreview(_controller);
            } else {
              // Otherwise, display a loading indicator.
              return const Center(
                  child: CircularProgressIndicator(
                // color: Colors.blueGrey,
                backgroundColor: Colors.blueGrey,
              ));
            }
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: _showCameraButton,
        child: FloatingActionButton(
          // Provide an onPressed callback.
          onPressed: () async {
            // Take the Picture in a try / catch block. If anything goes wrong,
            // catch the error.
            try {
              // Ensure that the camera is initialized.
              await _initializeControllerFuture;

              // Attempt to take a picture and get the file `image`
              // where it was saved.
              final image = await _controller.takePicture();
              await _controller.pausePreview();
              _setShowCameraButton(false);

              if (!mounted) return;

              // Upload image to storage
              const uuid = Uuid();
              final imagePath = image.path;
              final imageName = "${uuid.v1()}${path.extension(imagePath)}";
              final downloadUrl = await StorageService.uploadImage(
                  io.File(imagePath), imageName);

              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return RecyclingSheet();
                  });

              if (downloadUrl == null) {
                debugPrint("Cannot create download url for image");
              } else {
                debugPrint("Loading google vision...");
                final gvsRes = await ApiService.getGoogleVision(downloadUrl);

                // Check if gvsRes is null
                // If so, show no results
                // Else, load recycle res
                // Add to recents
                // then show drawer (NOT ABLE TO SWIPE DOWN)
                // Item name
                // Category
                // How to Recycle
                // Button: I recycled (exit)
                // Exit button (exit)
                // Resume camera

                if (gvsRes == null) {
                  debugPrint("Something went wrong");
                } else {
                  gvsRes.objects.forEach((element) {
                    print(json.encode(element.toJson()));
                  });

                  if (gvsRes.objects.isNotEmpty) {
                    print("SOMETHING IS HAPPENINIG>>>");
                    final recycleRes = await ApiService.getRecycleResponse(
                        gvsRes.objects.first.name);

                    if (recycleRes == null) {
                      print("Recycle null");
                    } else {
                      print("Recycle res: ${json.encode(recycleRes.toJson())}");
                    }
                  }
                }
              }

              // // If the picture was taken, display it on a new screen.
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => DisplayPictureScreen(
              //       // Pass the automatically generated path to
              //       // the DisplayPictureScreen widget.
              //       imagePath: image.path,
              //     ),
              //   ),
              // );
            } catch (e) {
              // If an error occurs, log the error to the console.
              print(e);
            }
          },
          child: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }
}
