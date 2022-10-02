import "dart:io" as io;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageService {
  static final _storage = FirebaseStorage.instance;

  static Future<String> uploadImage(io.File file, String fileName) async {
    debugPrint("Uploading image... $fileName");

    // try {
    final ref = _storage.ref();
    final refPath = ref.child("images/$fileName");
    final uploadTask = refPath.putFile(file);

    final snapshot = await uploadTask.whenComplete(() => {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    debugPrint("Download url: $downloadUrl");
    return downloadUrl;
    // } on FirebaseException catch (e) {
    //   debugPrint(e.code);
    //   debugPrint(e.message);
    //   return null;
    // }
  }
}
