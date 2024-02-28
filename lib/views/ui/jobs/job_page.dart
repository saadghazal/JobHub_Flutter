import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/bookmarks/bookmarks_model.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/services/helpers/book_helper.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_outline_btn.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:provider/provider.dart';

class JobPage extends StatefulWidget {
  const JobPage({
    required this.id,
    required this.title,
    required this.location,
    required this.company,
    this.hiring = true,
    required this.description,
    required this.salary,
    required this.period,
    required this.contract,
    required this.requirements,
    required this.imageUrl,
    required this.agentId,
    super.key,
  });
  final String id;
  final String title;
  final String location;
  final String company;
  final bool hiring;
  final String description;
  final String salary;
  final String period;
  final String contract;
  final List<String> requirements;
  final String imageUrl;
  final String agentId;

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
          text: widget.company,
          actions: [
            Consumer<BookMarkNotifier>(
              builder: (context, bookmarkNotifier, child) {
                bookmarkNotifier.loadJobs();

                return GestureDetector(
                  onTap: () {
                    if (bookmarkNotifier.jobs.contains(widget.id)) {
                      // delete
                      bookmarkNotifier.deleteBookmark(widget.id);
                    } else {
                      // add
                      BookmarkRequest model = BookmarkRequest(job: widget.id);
                      bookmarkNotifier.addBookmark(model, widget.id);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: !bookmarkNotifier.jobs.contains(widget.id)
                        ? Icon(Fontisto.bookmark)
                        : Icon(Fontisto.bookmark_alt),
                  ),
                );
              },
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
                        backgroundImage: NetworkImage(widget.imageUrl),
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
                        text: widget.location,
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
                              text: widget.period.capitalizeFirst!,
                              color: Color(kOrange.value),
                            ),
                            Row(
                              children: [
                                ReusableText(
                                  text: widget.salary,
                                  style: appstyle(
                                    22,
                                    Color(kDark.value),
                                    FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.2,
                                  child: ReusableText(
                                    text: '/${widget.contract.toUpperCase()}',
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
                  widget.description,
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
                      final req = widget.requirements[index];
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
                    itemCount: widget.requirements.length,
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
