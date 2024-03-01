import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobhub/models/request/chat/create_chat.dart';
import 'package:jobhub/models/response/chat/get_chat.dart';
import 'package:jobhub/models/response/chat/initial_chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class ChatHelper {
  static var client = http.Client();

  /// Apply for job
  static Future<List<dynamic>> apply(CreateChat createChat) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer ${prefs.getString('token')}'
    };
    var url = Uri.https(Config.apiUrl, Config.chats);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(createChat.toJson()),
    );
    if (response.statusCode == 200) {
      final first = initialChatFromJson(response.body).id;
      return [true, first];
    } else {
      return [false];
    }
  }

  static Future<List<GetChats>> getConversations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer ${prefs.getString('token')}'
    };
    var url = Uri.https(Config.apiUrl, Config.chats);
    var response = await client.post(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      final chats = getChatsFromJson(response.body);
      return chats;
    } else {
      throw Exception('could not load chats');
    }
  }
}
