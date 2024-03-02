import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/chat_provider.dart';
import 'package:jobhub/models/request/messaging/send_message.dart';
import 'package:jobhub/models/response/messaging/messaging_response.dart';
import 'package:jobhub/services/config.dart';
import 'package:jobhub/services/helpers/messaging_helper.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/ui/chat/widgets/messaging_text_field.dart';
import 'package:jobhub/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../models/response/chat/get_chat.dart';
import '../../common/app_style.dart';
import '../../common/height_spacer.dart';
import '../../common/loader.dart';
import '../../common/reusable_text.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ConversationPage extends StatefulWidget {
  const ConversationPage({
    required this.id,
    required this.profileImage,
    required this.users,
    required this.title,
    super.key,
  });
  final String title;
  final String id;
  final String profileImage;
  final List<String> users;
  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  IO.Socket? socket;
  int offset = 1;
  final ScrollController _scrollController = ScrollController();
  late Future<List<ReceivedMessages>> msgList;
  List<ReceivedMessages> messages = [];
  TextEditingController messageController = TextEditingController();
  String receiverId = '';

  getMessages(int offset) {
    msgList = MessagingHelper.getMessages(widget.id, offset);
  }

  void connect() {
    ChatNotifier chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
    socket = IO.io('http://${Config.apiUrl}', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
    socket!.emit('setup', chatNotifier.userId);
    socket!.onConnect((_) {
      print('Connected front end');
      socket!.on('online-user', (userId) {
        print('user id ' + userId + ' is online!');
        chatNotifier.onlineUsers.replaceRange(0, chatNotifier.onlineUsers.length, [userId]);
      });
      socket!.on('typing', (status) {
        chatNotifier.typingStatus = true;
      });
      socket!.on('stop typing', (status) {
        chatNotifier.typingStatus = false;
      });
      socket!.on('message received', (newMessageReceived) {
        sendStopTypingEvent(widget.id);
        ReceivedMessages receivedMessage = ReceivedMessages.fromJson(newMessageReceived);
        print(receivedMessage);
        if (receivedMessage.sender.id != chatNotifier.userId) {
          setState(() {
            messages.insert(0, receivedMessage);
          });
        }
        setState(() {});
      });
    });
  }

  void sendTypingEvent(String status) {
    socket!.emit('typing', status);
  }

  void sendStopTypingEvent(String status) {
    socket!.emit('stop typing', status);
  }

  void joinChat() {
    socket!.emit('join chat', widget.id);
  }

  void sendMessage(String content, String chatId, String receiverId) {
    SendMessage model = SendMessage(content: content, chatId: chatId, receiver: receiverId);
    MessagingHelper.sendMessage(model).then((response) {
      var emission = response[2];
      socket!.emit('new message', emission);
      sendStopTypingEvent(widget.id);
      setState(() {
        messageController.clear();
        messages.insert(0, response[1]);
      });
    });
  }

  void handleNext() {
    _scrollController.addListener(() async {
      if (_scrollController.hasClients) {
        if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
          print('<><><><><>Loading...<><><><><>');
          if (messages.length >= 12) {
            getMessages(offset++);
            setState(() {});
          }
        }
      }
    });
  }

  @override
  void initState() {
    getMessages(offset);
    connect();
    joinChat();
    handleNext();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    socket!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatNotifier>(
      builder: (context, chatNotifier, child) {
        receiverId = widget.users.firstWhere((id) => id != chatNotifier.userId);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
              text: chatNotifier.isTyping ? 'Typing...' : widget.title,
              actions: [
                Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.profileImage),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircleAvatar(
                          radius: 5.r,
                          backgroundColor: chatNotifier.onlineUsers.contains(receiverId)
                              ? Colors.green
                              : Colors.grey,
                        ),
                      )
                    ],
                  ),
                )
              ],
              child: Padding(
                padding: EdgeInsets.all(12.h),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(MaterialCommunityIcons.arrow_left),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<List<ReceivedMessages>>(
                      future: msgList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: ReusableText(
                              text: "Error ${snapshot.error}",
                              style: appstyle(
                                20,
                                Color(kOrange.value),
                                FontWeight.bold,
                              ),
                            ),
                          );
                        } else if (snapshot.data!.isEmpty) {
                          return const SearchLoading(text: 'You do not have messages');
                        } else {
                          final msgList = snapshot.data;
                          messages = messages + msgList!;
                          return ListView.builder(
                            controller: _scrollController,
                            reverse: true,
                            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              return Padding(
                                padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
                                child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReusableText(
                                      text: chatNotifier.msgTime(message.updatedAt.toString()),
                                      style: appstyle(16, Color(kDark.value), FontWeight.normal),
                                    ),
                                    const HeightSpacer(size: 15),
                                    ChatBubble(
                                      alignment: message.sender.id == chatNotifier.userId
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      backGroundColor: message.sender.id == chatNotifier.userId
                                          ? Color(kOrange.value)
                                          : Color(kLightGrey.value),
                                      elevation: 0,
                                      clipper: ChatBubbleClipper4(
                                        radius: 8,
                                        type: message.sender.id == chatNotifier.userId
                                            ? BubbleType.sendBubble
                                            : BubbleType.receiverBubble,
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: width * 0.8,
                                        ),
                                        child: ReusableText(
                                          text: message.content,
                                          style: appstyle(
                                            14,
                                            Color(kLight.value),
                                            FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: messages!.length,
                          );
                        }
                      },
                    ),
                  ),
                  MessagingTextField(
                    messageController: messageController,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        sendMessage(
                          messageController.text,
                          widget.id,
                          receiverId,
                        );
                      },
                      child: Icon(
                        MaterialCommunityIcons.send,
                        size: 24.sp,
                        color: Color(kLightBlue.value),
                      ),
                    ),
                    onSubmitted: (_) {
                      sendMessage(
                        messageController.text,
                        widget.id,
                        receiverId,
                      );
                    },
                    onChanged: (_) {
                      sendTypingEvent(widget.id);
                    },
                    onEditingComplete: () {
                      sendMessage(
                        messageController.text,
                        widget.id,
                        receiverId,
                      );
                    },
                    onTapOutside: (_) {
                      sendStopTypingEvent(widget.id);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
