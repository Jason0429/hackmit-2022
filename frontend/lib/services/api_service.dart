import 'dart:convert';

import 'package:project/models/google_vision_response.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/recycle_response.dart';
import 'package:project/utils/constants.dart';

class ApiService {
  static Future<GoogleVisionResponse?> getGoogleVision(String imageUrl) async {
    try {
      final res = await http.post(
        Uri.parse("${ApiUrls.root}/gvs"),
        body: jsonEncode({"uri": imageUrl}),
      );

      print("Res: ${res.body}");
      return GoogleVisionResponse.fromJson(jsonDecode(res.body));
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<RecycleResponse?> getRecycleResponse(String item) async {
    try {
      final res = await http
          .get(Uri.parse("${ApiUrls.root}/recycle-instruction?item=$item"));
      print(res.body);
      return RecycleResponse.fromJson(jsonDecode(res.body));
    } catch (e) {
      print(e);
      return null;
    }
  }
}
