import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/width_spacer.dart';
import 'package:provider/provider.dart';

import '../../ui/mainscreen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({required this.indexSetter, super.key});
  final ValueSetter indexSetter;

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(builder: (context, zoomNotifier, child) {
      return GestureDetector(
        onTap: () {
          ZoomDrawer.of(context)!.toggle();
        },
        child: Scaffold(
          backgroundColor: Color(kLightBlue.value),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              drawerItem(
                AntDesign.home,
                "Home",
                0,
                zoomNotifier.currentIndex == 0 ? Color(kLight.value) : Color(kLightGrey.value),
              ),
              drawerItem(
                Ionicons.chatbubble_outline,
                "Chat",
                1,
                zoomNotifier.currentIndex == 1 ? Color(kLight.value) : Color(kLightGrey.value),
              ),
              drawerItem(
                Fontisto.bookmark,
                "Bookmarks",
                2,
                zoomNotifier.currentIndex == 2 ? Color(kLight.value) : Color(kLightGrey.value),
              ),
              drawerItem(
                MaterialCommunityIcons.devices,
                "Device Management",
                3,
                zoomNotifier.currentIndex == 3 ? Color(kLight.value) : Color(kLightGrey.value),
              ),
              drawerItem(
                FontAwesome5Regular.user_circle,
                "Profile",
                4,
                zoomNotifier.currentIndex == 4 ? Color(kLight.value) : Color(kLightGrey.value),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget drawerItem(IconData icon, String label, index, Color color) {
    return GestureDetector(
      onTap: () {
        widget.indexSetter(index);
        ZoomDrawer.of(context)!.toggle();
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.w, bottom: 20.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            const WidthSpacer(
              width: 12,
            ),
            Expanded(
              child: ReusableText(
                text: label,
                style: appstyle(
                  12,
                  color,
                  FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
