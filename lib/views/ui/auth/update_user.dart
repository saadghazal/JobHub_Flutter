import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController skill0 = TextEditingController();
  TextEditingController skill1 = TextEditingController();
  TextEditingController skill2 = TextEditingController();
  TextEditingController skill3 = TextEditingController();
  TextEditingController skill4 = TextEditingController();

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
      body: Consumer<LoginNotifier>(
        builder: (context, loginProvider, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
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
                  GestureDetector(
                    onTap: null,
                    child: CircleAvatar(
                      backgroundColor: Color(kLightBlue.value),
                      child: Center(
                        child: Icon(Icons.photo_filter_rounded),
                      ),
                    ),
                  ),
                ],
              ),
              HeightSpacer(size: 20),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          return "Please enter a valid phone number";
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
                          return "Please enter a valid phone number";
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
                          return "Please enter a valid phone number";
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
                          return "Please enter a valid phone number";
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
                          return "Please enter a valid phone number";
                        }
                        return null;
                      },
                    ),
                    HeightSpacer(size: 20),
                    CustomButton(
                      onTap: () {},
                      text: 'Update Profile',
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
