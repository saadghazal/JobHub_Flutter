import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobhub/models/request/messaging/send_message.dart';
import 'package:jobhub/models/response/messaging/messaging_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class MessagingHelper {
  static var client = http.Client();

  static Future<List<dynamic>> sendMessage(SendMessage sendMessage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer ${prefs.getString('token')}'
    };
    var url = Uri.https(Config.apiUrl, Config.messaging);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(sendMessage.toJson()),
    );
    if (response.statusCode == 200) {
      ReceivedMessages message = ReceivedMessages.fromJson(jsonDecode(response.body));
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      return [
        true,
        message,
        responseMap,
      ];
    } else {
      return [false];
    }
  }

  static Future<List<ReceivedMessages>> getMessages(String chatId, int offset) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer ${prefs.getString('token')}'
    };
    var url = Uri.https(
      Config.apiUrl,
      '${Config.messaging}/$chatId',
      {"page": offset.toString()},
    );
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final messages = receivedMessagesFromJson(response.body);
      print(messages[0].content);
      return messages;
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
