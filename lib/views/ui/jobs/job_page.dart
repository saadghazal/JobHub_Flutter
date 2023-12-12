import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_outline_btn.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';

class JobPage extends StatefulWidget {
  const JobPage({
    required this.title,
    required this.id,
    super.key,
  });
  final String title;
  final String id;

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
          text: widget.title,
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
                  color: Color(kLightGrey.value),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/${widget.title}.png'),
                      ),
                      HeightSpacer(size: 10),
                      ReusableText(
                        text: widget.title,
                        style: appstyle(
                          22,
                          Color(kDark.value),
                          FontWeight.w600,
                        ),
                      ),
                      HeightSpacer(size: 5),
                      ReusableText(
                        text: 'New York',
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
                              text: 'Full-Time',
                              color: Color(kOrange.value),
                            ),
                            Row(
                              children: [
                                ReusableText(
                                  text: '15k',
                                  style: appstyle(
                                    22,
                                    Color(kDark.value),
                                    FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.2,
                                  child: ReusableText(
                                    text: '/Monthly',
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
                  desc,
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
                      final req = requirements[index];
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
                    itemCount: requirements.length,
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
