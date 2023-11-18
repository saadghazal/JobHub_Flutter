import 'package:flutter/material.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/exports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.color,
    this.onTap,
  });
  final String text;
  final Color? color;
  final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Color(kOrange.value),
        width: width,
        height: height * 0.065,
        child: Center(
          child: ReusableText(
            text: text,
            style: appstyle(
              16,
              color ?? Color(kLight.value),
              FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
