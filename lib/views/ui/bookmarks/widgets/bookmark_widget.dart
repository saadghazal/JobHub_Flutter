import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/width_spacer.dart';
import 'package:jobhub/views/ui/jobs/job_page.dart';

class BookMarkWidget extends StatelessWidget {
  const BookMarkWidget({
    super.key,
    required this.job,
  });
  final AllBookmark job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () {
          Get.to(() => JobPage(
                id: job.job.id,
                title: job.job.title,
                location: job.job.location,
                company: job.job.company,
                description: job.job.description,
                salary: job.job.salary,
                period: job.job.period,
                contract: job.job.contract,
                requirements: job.job.requirements,
                imageUrl: job.job.imageUrl,
                agentId: job.job.agentId,
              ));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          height: height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Color(kLightGrey.value),
          ),
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundImage: NetworkImage(job.job.imageUrl),
                      ),
                      WidthSpacer(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: job.job.company,
                            style: appstyle(
                              20,
                              Color(kDark.value),
                              FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            child: ReusableText(
                              text: job.job.title,
                              style: appstyle(
                                20,
                                Color(kDark.value),
                                FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 18.r,
                    backgroundColor: Color(kLight.value),
                    child: Icon(
                      Ionicons.chevron_forward,
                      color: Color(kOrange.value),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 65.w),
                child: Row(
                  children: [
                    ReusableText(
                      text: job.job.salary,
                      style: appstyle(
                        20,
                        Color(kDark.value),
                        FontWeight.w600,
                      ),
                    ),
                    ReusableText(
                      text: "/${job.job.period.capitalizeFirst}",
                      style: appstyle(
                        20,
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
      ),
    );
  }
}
