import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/controllers/chat_provider.dart';
import 'package:jobhub/models/response/chat/get_chat.dart';
import 'package:jobhub/views/common/exports.dart';
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
                itemBuilder: (context, index) {
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
