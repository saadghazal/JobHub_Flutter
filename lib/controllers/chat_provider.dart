import 'package:flutter/material.dart';
import 'package:jobhub/models/response/chat/get_chat.dart';
import 'package:jobhub/services/helpers/chat_helper.dart';

class ChatNotifier extends ChangeNotifier {
  late Future<List<GetChats>> chats;
  getChats() {
    chats = ChatHelper.getConversations();
  }
}
