import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_outline_btn.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';

class JobPage extends StatefulWidget {
  const JobPage({
    required this.job,
    super.key,
  });
  final JobsResponse job;

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: widget.job.title,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Icon(Entypo.bookmark),
            ),
          ],
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                HeightSpacer(size: 30),
                Container(
                  width: width,
                  height: height * 0.27,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Color(kLightGrey.value),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.job.imageUrl),
                      ),
                      HeightSpacer(size: 10),
                      ReusableText(
                        text: widget.job.title,
                        style: appstyle(
                          22,
                          Color(kDark.value),
                          FontWeight.w600,
                        ),
                      ),
                      HeightSpacer(size: 5),
                      ReusableText(
                        text: widget.job.location,
                        style: appstyle(
                          16,
                          Color(kDarkGrey.value),
                          FontWeight.normal,
                        ),
                      ),
                      HeightSpacer(size: 15),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomOutlineBtn(
                              width: width * 0.26,
                              height: height * 0.04,
                              color2: Color(kLight.value),
                              text: widget.job.period,
                              color: Color(kOrange.value),
                            ),
                            Row(
                              children: [
                                ReusableText(
                                  text: widget.job.salary,
                                  style: appstyle(
                                    22,
                                    Color(kDark.value),
                                    FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.2,
                                  child: ReusableText(
                                    text: '/${widget.job.contract}',
                                    style: appstyle(
                                      20,
                                      Color(kDarkGrey.value),
                                      FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                HeightSpacer(size: 20),
                ReusableText(
                  text: 'Job Description',
                  style: appstyle(
                    22,
                    Color(kDark.value),
                    FontWeight.w600,
                  ),
                ),
                HeightSpacer(size: 10),
                Text(
                  widget.job.description,
                  textAlign: TextAlign.justify,
                  maxLines: 8,
                  style: appstyle(
                    16,
                    Color(kDarkGrey.value),
                    FontWeight.normal,
                  ),
                ),
                HeightSpacer(size: 20),
                ReusableText(
                  text: 'Requirements',
                  style: appstyle(
                    22,
                    Color(kDark.value),
                    FontWeight.w600,
                  ),
                ),
                HeightSpacer(size: 10),
                SizedBox(
                  height: height * 0.6,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final req = widget.job.requirements[index];
                      String bullet = '\u2022';
                      return Text(
                        '$bullet $req\n',
                        maxLines: 4,
                        textAlign: TextAlign.justify,
                        style: appstyle(
                          16,
                          Color(kDarkGrey.value),
                          FontWeight.normal,
                        ),
                      );
                    },
                    itemCount: widget.job.requirements.length,
                  ),
                ),
                HeightSpacer(size: 20),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: CustomOutlineBtn(
                  width: width,
                  height: height * 0.06,
                  color2: Color(kOrange.value),
                  text: 'Apply Now',
                  color: Color(kLight.value),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
