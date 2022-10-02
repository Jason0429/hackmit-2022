import 'package:flutter/material.dart';
import 'package:project/models/activity.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class RecyclingSheetController {
  Future<void> handleAddActivity(
      {required String imageUrl,
      required String item,
      required String category}) async {
    try {
      await FirestoreService.addActivity(
        AuthService.currentUser!.uid,
        Activity(
          id: Uuid().v1(),
          imageUrl: imageUrl,
          itemName: item,
          category: category,
          recycled: false,
          createdOn: DateTime.now(),
        ),
      );
      debugPrint("Activity added");
    } catch (e) {
      debugPrint("Activity not added");
    }
  }
}
