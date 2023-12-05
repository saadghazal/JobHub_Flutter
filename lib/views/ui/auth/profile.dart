import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/response/auth/profile_model.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/width_spacer.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: 'Profile',
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<ProfileNotifier>(
        builder: (context, profileNotifier, child) {
          profileNotifier.getProfile();
          return FutureBuilder<ProfileRes>(
              future: profileNotifier.profile,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  final UserData = snapshot.data;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Container(
                          width: width,
                          height: height * 0.12,
                          color: Color(kLight.value),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.r),
                                    child: CachedNetworkImage(
                                      width: 80.w,
                                      height: 100.h,
                                      imageUrl: UserData!.profileImage,
                                    ),
                                  ),
                                  WidthSpacer(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                        text: UserData.username,
                                        style: appstyle(
                                          20,
                                          Color(kDark.value),
                                          FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            MaterialIcons.location_pin,
                                            color: Color(kDarkGrey.value),
                                          ),
                                          WidthSpacer(width: 5),
                                          ReusableText(
                                            text: UserData.location,
                                            style: appstyle(
                                              16,
                                              Color(kDarkGrey.value),
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Feather.edit,
                                  size: 18.sp,
                                ),
                              )
                            ],
                          ),
                        ),
                        HeightSpacer(size: 20),
                        Stack(
                          children: [
                            Container(
                              width: width,
                              height: height * 0.12,
                              color: Color(kLightGrey.value),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 12.w),
                                    height: 70.h,
                                    width: 60.w,
                                    color: Color(kLight.value),
                                    child: const Icon(
                                      FontAwesome5Regular.file_pdf,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ReusableText(
                                        text: 'Resume from JobHub',
                                        style: appstyle(
                                          18,
                                          Color(kDark.value),
                                          FontWeight.w500,
                                        ),
                                      ),
                                      ReusableText(
                                        text: 'JobHub Resume',
                                        style: appstyle(
                                          16,
                                          Color(kDarkGrey.value),
                                          FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  WidthSpacer(width: 1),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 2.h,
                              right: 5.w,
                              child: GestureDetector(
                                onTap: () {},
                                child: ReusableText(
                                  text: 'Edit',
                                  style: appstyle(
                                    16,
                                    Color(kOrange.value),
                                    FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        HeightSpacer(size: 20),
                        Container(
                          padding: EdgeInsets.only(left: 8.w),
                          width: width,
                          height: height * 0.06,
                          color: Color(kLightGrey.value),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ReusableText(
                              text: UserData.email,
                              style: appstyle(
                                16,
                                Color(kDark.value),
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        HeightSpacer(size: 20),
                        Container(
                          padding: EdgeInsets.only(left: 8.w),
                          width: width,
                          height: height * 0.06,
                          color: Color(kLightGrey.value),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/jo.svg",
                                  width: 20.w,
                                  height: 20.h,
                                ),
                                WidthSpacer(width: 15.w),
                                ReusableText(
                                  text: '+962${UserData.phone}',
                                  style: appstyle(
                                    16,
                                    Color(kDark.value),
                                    FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        HeightSpacer(size: 20),
                        Container(
                          color: Color(kLightGrey.value),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.h),
                                child: ReusableText(
                                  text: "Skills",
                                  style: appstyle(
                                    16,
                                    Color(kDark.value),
                                    FontWeight.w600,
                                  ),
                                ),
                              ),
                              HeightSpacer(size: 3),
                              SizedBox(
                                height: height * 0.5,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                                          width: width,
                                          height: height * 0.06,
                                          color: Color(kLight.value),
                                          alignment: Alignment.centerLeft,
                                          child: ReusableText(
                                            text: UserData.skills[index],
                                            style: appstyle(
                                              16,
                                              Color(kDark.value),
                                              FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: UserData.skills.length,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              });
        },
      ),
    );
  }
}
