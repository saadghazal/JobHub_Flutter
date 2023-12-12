import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/width_spacer.dart';

class VerticalTile extends StatelessWidget {
  const VerticalTile({super.key, required this.recentJob, this.onTap});

  final void Function()? onTap;
  final JobsResponse recentJob;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        height: height * 0.15,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Color(kLightGrey.value),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(kLightGrey.value),
                      radius: 30,
                      backgroundImage: NetworkImage(recentJob.imageUrl),
                    ),
                    const WidthSpacer(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: recentJob.company,
                          style: appstyle(
                            20,
                            Color(kDark.value),
                            FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.5,
                          child: ReusableText(
                            text: recentJob.title,
                            style: appstyle(
                              18,
                              Color(kDarkGrey.value),
                              FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(kLight.value),
                      child: Icon(Ionicons.chevron_forward),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Row(
                children: [
                  ReusableText(
                    text: recentJob.salary,
                    style: appstyle(
                      23,
                      Color(kDark.value),
                      FontWeight.w600,
                    ),
                  ),
                  ReusableText(
                    text: '/${recentJob.contract}',
                    style: appstyle(
                      23,
                      Color(kDarkGrey.value),
                      FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
