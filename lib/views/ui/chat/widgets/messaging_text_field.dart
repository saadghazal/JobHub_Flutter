import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../../constants/app_constants.dart';
import '../../../common/app_style.dart';

class MessagingTextField extends StatelessWidget {
  const MessagingTextField({
    super.key,
    required this.suffixIcon,
    required this.onSubmitted,
    required this.onChanged,
    required this.onEditingComplete,
    required this.messageController,
    required this.onTapOutside,
  });

  final TextEditingController messageController;
  final Widget suffixIcon;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent)? onTapOutside;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      alignment: Alignment.bottomCenter,
      child: TextField(
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onTapOutside: onTapOutside,
        onSubmitted: onSubmitted,
        cursorColor: Color(kDarkGrey.value),
        keyboardType: TextInputType.multiline,
        controller: messageController,
        style: appstyle(
          16,
          Color(kDark.value),
          FontWeight.w500,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(6.sp),
          filled: true,
          fillColor: Color(kLight.value),
          suffixIcon: suffixIcon,
          hintText: 'Type your message',
          hintStyle: appstyle(
            14,
            Color(kDarkGrey.value),
            FontWeight.normal,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: Color(kDarkGrey.value),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: Color(kDarkGrey.value),
            ),
          ),
        ),
      ),
    );
  }
}
