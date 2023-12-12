import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../models/request/auth/profile_update_model.dart';
import '../../common/app_style.dart';
import '../../common/custom_btn.dart';
import '../../common/custom_textfield.dart';
import '../../common/height_spacer.dart';
import '../../common/reusable_text.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({required this.profileData, super.key});

  final List<String> profileData;

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController skill0 = TextEditingController();
  TextEditingController skill1 = TextEditingController();
  TextEditingController skill2 = TextEditingController();
  TextEditingController skill3 = TextEditingController();
  TextEditingController skill4 = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    skill0.text = widget.profileData[0];
    skill1.text = widget.profileData[1];
    skill2.text = widget.profileData[2];
    skill3.text = widget.profileData[3];
    skill4.text = widget.profileData[4];
  }

  @override
  void dispose() {
    phone.dispose();
    location.dispose();
    skill0.dispose();
    skill1.dispose();
    skill2.dispose();
    skill3.dispose();
    skill4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: 'Update Profile',
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: Consumer<LoginNotifier>(
        builder: (context, loginNotifier, child) {
          return Form(
            key: loginNotifier.profileFormKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: 'Personal Details',
                      style: appstyle(
                        35,
                        Color(kDark.value),
                        FontWeight.bold,
                      ),
                    ),
                    Consumer<ImageUploader>(
                      builder: (context, imageUploader, child) {
                        return imageUploader.imageFil.isEmpty
                            ? GestureDetector(
                                onTap: () {
                                  imageUploader.pickImage();
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(kLightBlue.value),
                                  child: Center(
                                    child: Icon(Icons.photo_filter_rounded),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  imageUploader.imageFil.clear();
                                  setState(() {});
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(kLightBlue.value),
                                  backgroundImage: FileImage(File(imageUploader.imageFil[0])),
                                ),
                              );
                      },
                    ),
                  ],
                ),
                HeightSpacer(size: 20),
                CustomTextField(
                  controller: location,
                  hintText: 'Location',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a valid location";
                    }
                    return null;
                  },
                ),
                HeightSpacer(size: 10),
                CustomTextField(
                  controller: phone,
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a valid phone number";
                    }
                    return null;
                  },
                ),
                HeightSpacer(size: 10),
                ReusableText(
                  text: 'Professional Skills',
                  style: appstyle(30, Color(kDark.value), FontWeight.bold),
                ),
                HeightSpacer(size: 10),
                CustomTextField(
                  controller: skill0,
                  hintText: 'Professional Skills',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a valid skill";
                    }
                    return null;
                  },
                ),
                HeightSpacer(size: 10),
                CustomTextField(
                  controller: skill1,
                  hintText: 'Professional Skills',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a valid skill";
                    }
                    return null;
                  },
                ),
                HeightSpacer(size: 10),
                CustomTextField(
                  controller: skill2,
                  hintText: 'Professional Skills',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a valid skill";
                    }
                    return null;
                  },
                ),
                HeightSpacer(size: 10),
                CustomTextField(
                  controller: skill3,
                  hintText: 'Professional Skills',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a valid skill";
                    }
                    return null;
                  },
                ),
                HeightSpacer(size: 10),
                CustomTextField(
                  controller: skill4,
                  hintText: 'Professional Skills',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a valid skill";
                    }
                    return null;
                  },
                ),
                HeightSpacer(size: 20),
                Consumer<ImageUploader>(
                  builder: (context, imageUploader, child) {
                    return CustomButton(
                      onTap: () {
                        if (loginNotifier.profileValidation()) {
                          if (imageUploader.imageFil.isEmpty && imageUploader.imageUrl == null) {
                            Get.snackbar(
                              'Image Missing',
                              'Please upload an image to proceed',
                              colorText: Color(kLight.value),
                              backgroundColor: Color(kLightBlue.value),
                              icon: Icon(Icons.add_alert),
                            );
                          } else {
                            ProfileUpdateReq profile = ProfileUpdateReq(
                              location: location.text,
                              phone: phone.text,
                              profile: imageUploader.imageUrl!,
                              skills: [
                                skill0.text,
                                skill1.text,
                                skill2.text,
                                skill3.text,
                                skill4.text
                              ],
                            );
                            print(profile.profile);
                            loginNotifier.updateProfile(profileReq: profile);
                          }
                        } else {
                          return;
                        }
                      },
                      text: 'Update Profile',
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
