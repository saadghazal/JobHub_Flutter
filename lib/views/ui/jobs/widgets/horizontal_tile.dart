import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/width_spacer.dart';

class JobHorizontalTile extends StatelessWidget {
  const JobHorizontalTile({super.key, required this.job, this.onTap});
  final void Function()? onTap;
  final JobsResponse job;

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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Color(kLightGrey.value),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(job.imageUrl),
                  ),
                  const WidthSpacer(width: 15),
                  ReusableText(
                    text: job.company,
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
                text: job.title,
                style: appstyle(
                  20,
                  Color(kDark.value),
                  FontWeight.w600,
                ),
              ),
              ReusableText(
                text: job.location,
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
                        text: '${job.salary}',
                        style: appstyle(
                          20,
                          Color(kDark.value),
                          FontWeight.w600,
                        ),
                      ),
                      ReusableText(
                        text: '/${job.contract}',
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
