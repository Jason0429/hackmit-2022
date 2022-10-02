import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraViewModel {
  Future<CameraDescription> getCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    final camera = cameras.first;
    return camera;
  }

  void closeCamera() {}
}
