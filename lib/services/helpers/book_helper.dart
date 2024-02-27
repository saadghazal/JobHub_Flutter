import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobhub/models/request/bookmarks/bookmarks_model.dart';
import 'package:jobhub/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhub/models/response/bookmarks/bookmark_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class BookMarkHelper {
  static var client = https.Client();

  /// Add BookMark
  static Future<List<dynamic>> addBookmark(BookmarkRequest model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(Config.apiUrl, Config.bookmarkUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      String bookmarkId = bookMarkReqResFromJson(response.body).id;
      return [true, bookmarkId];
    } else {
      return [false];
    }
  }
}
