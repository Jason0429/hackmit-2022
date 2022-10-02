import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/camera_screen_2.dart';

class CameraPromptScreen extends StatefulWidget {
  const CameraPromptScreen({Key? key}) : super(key: key);

  @override
  State<CameraPromptScreen> createState() => _CameraPromptScreenState();
}

class _CameraPromptScreenState extends State<CameraPromptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Home Page")),
      body: SafeArea(
        child: Center(
            child: ElevatedButton(
          onPressed: () async {
            await availableCameras().then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => CameraScreen(cameras: value))));
          },
          child: const Text("Take a Picture"),
        )),
      ),
    );
  }
}
