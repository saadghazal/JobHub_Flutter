import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/width_spacer.dart';

class JobHorizontalTile extends StatelessWidget {
  const JobHorizontalTile({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          width: width * 0.7,
          height: height * 0.27,
          color: Color(kLightGrey.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/Facebook.png'),
                  ),
                  const WidthSpacer(width: 15),
                  ReusableText(
                    text: 'Facebook',
                    style: appstyle(
                      20,
                      Color(kDark.value),
                      FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const HeightSpacer(size: 15),
              ReusableText(
                text: 'Senior Flutter Developer',
                style: appstyle(
                  20,
                  Color(kDark.value),
                  FontWeight.w600,
                ),
              ),
              ReusableText(
                text: 'Amman',
                style: appstyle(
                  16,
                  Color(kDarkGrey.value),
                  FontWeight.w600,
                ),
              ),
              HeightSpacer(size: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ReusableText(
                        text: '15k',
                        style: appstyle(
                          20,
                          Color(kDark.value),
                          FontWeight.w600,
                        ),
                      ),
                      ReusableText(
                        text: '/Monthly',
                        style: appstyle(
                          20,
                          Color(kDarkGrey.value),
                          FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(kLight.value),
                    child: const Center(child: Icon(Ionicons.chevron_forward)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
