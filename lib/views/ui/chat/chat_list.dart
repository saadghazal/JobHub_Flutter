import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhub/controllers/chat_provider.dart';
import 'package:jobhub/models/response/chat/get_chat.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/loader.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: 'Chats',
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<ChatNotifier>(builder: (context, chatNotifier, child) {
        chatNotifier.getChats();
        chatNotifier.getPrefs();
        print(chatNotifier.userId);
        return FutureBuilder<List<GetChats>>(
          future: chatNotifier.chats,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
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
              return const SearchLoading(text: 'No Chats Available');
            } else {
              final chats = snapshot.data;
              return ListView.builder(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  final user = chat.users.where((user) => user.id != chatNotifier.userId);
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 80,
                        width: width,
                        decoration: BoxDecoration(
                          color: Color(kLightGrey.value),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                          minLeadingWidth: 0,
                          minVerticalPadding: 0,
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(user.first.profileImage),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                text: user.first.username,
                                style: appstyle(
                                  16,
                                  Color(kDark.value),
                                  FontWeight.w600,
                                ),
                              ),
                              const HeightSpacer(size: 5),
                              ReusableText(
                                text: chat.latestMessage.content,
                                style: appstyle(
                                  14,
                                  Color(kDarkGrey.value),
                                  FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          trailing: Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ReusableText(
                                  text: chatNotifier.msgTime(chat.updatedAt.toString()),
                                  style: appstyle(12, Color(kDark.value), FontWeight.normal),
                                ),
                                Icon(
                                  chat.chatName == chatNotifier.userId
                                      ? Ionicons.arrow_forward_circle_outline
                                      : Ionicons.arrow_back_circle_outline,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: chats!.length,
              );
            }
          },
        );
      }),
    );
  }
}
