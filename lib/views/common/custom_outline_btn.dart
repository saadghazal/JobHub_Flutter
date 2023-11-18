import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/views/common/exports.dart';

class CustomOutlineBtn extends StatelessWidget {
  const CustomOutlineBtn({
    super.key,
    this.width,
    this.height,
    required this.text,
    this.onTap,
    required this.color,
    this.color2,
  });

  final double? width;
  final double? height;
  final String text;
  final void Function()? onTap;
  final Color color;
  final Color? color2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color2,
          border: Border.all(color: color, width: 1.w),
        ),
        child: Center(
          child: ReusableText(
            text: text,
            style: appstyle(
              16,
              color,
              FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
