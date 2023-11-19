import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: 'Chats',
          child: Padding(
            padding:  EdgeInsets.all(12.h),
            child: DrawerWidget(),
          ),
        ),
      ),
    );
  }
}