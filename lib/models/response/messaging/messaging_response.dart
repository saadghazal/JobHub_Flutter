import 'dart:convert';

List<ReceivedMessages> receivedMessagesFromJson(String str) =>
    List<ReceivedMessages>.from(json.decode(str).map((x) => ReceivedMessages.fromJson(x)));

class ReceivedMessages {
  final String id;
  final Sender sender;
  final String content;
  final String receiver;
  final Chat chat;
  final List<dynamic> readBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ReceivedMessages({
    required this.id,
    required this.sender,
    required this.content,
    required this.receiver,
    required this.chat,
    required this.readBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ReceivedMessages.fromJson(Map<String, dynamic> json) => ReceivedMessages(
        id: json["_id"],
        sender: Sender.fromJson(json["sender"]),
        content: json["content"],
        receiver: json["receiver"],
        chat: Chat.fromJson(json["chat"]),
        readBy: List<dynamic>.from(json["readBy"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

class Chat {
  final String id;
  final String chatName;
  final bool isGroupChat;
  final List<Sender> users;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String latestMessage;

  Chat({
    required this.id,
    required this.chatName,
    required this.isGroupChat,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.latestMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        chatName: json["chatName"],
        isGroupChat: json["isGroupChat"],
        users: List<Sender>.from(json["users"].map((x) => Sender.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestMessage: json["latestMessage"],
      );
}

class Sender {
  final String id;
  final String username;
  final String email;

  Sender({
    required this.id,
    required this.username,
    required this.email,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
      );
}
