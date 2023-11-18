import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/views/common/exports.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.child,
    this.actions,
    this.text,
  });

  final Widget child;
  final List<Widget>? actions;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(),
      backgroundColor: Color(kLight.value),
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: child,
      leadingWidth: 70.w,
      actions: actions,
      centerTitle: true,
      title: ReusableText(
        text: text ?? "",
        style: appstyle(
          16,
          Color(kDark.value),
          FontWeight.w500,
        ),
      ),
    );
  }
}
