import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/login_provider.dart';
import '../../common/app_bar.dart';
import '../../common/app_style.dart';
import '../../common/custom_btn.dart';
import '../../common/custom_textfield.dart';
import '../../common/height_spacer.dart';
import '../../common/reusable_text.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
 
 final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

 @override
 Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
   return Consumer<SignUpNotifier>(
     builder: (context, signupNotifier, child) {
       return Scaffold(
         appBar: PreferredSize(
           preferredSize: Size.fromHeight(50),
           child: CustomAppBar(
             text: 'Sign Up',
             child: GestureDetector(
               onTap: () {
                 Get.back();
               },
               child: const Icon(CupertinoIcons.arrow_left),
             ),
           ),
         ),
         body: Padding(
           padding: EdgeInsets.symmetric(horizontal: 20.w),
           child: ListView(
             padding: EdgeInsets.zero,
             children: [
               HeightSpacer(size: 50),
               ReusableText(
                 text: 'Hello Welcome!',
                 style: appstyle(
                   30,
                   Color(kDark.value),
                   FontWeight.w600,
                 ),
               ),
               ReusableText(
                 text: 'Fill the details to signup for an account',
                 style: appstyle(
                   16,
                   Color(kDarkGrey.value),
                   FontWeight.w500,
                 ),
               ),
               const HeightSpacer(size: 50),
               CustomTextField(
                 controller: name,
                 keyboardType: TextInputType.emailAddress,
                 hintText: 'Full Name',
                 validator: (value) {
                   if (value!.isEmpty) {
                     return "Please enter your name.";
                   } else {
                     return null;
                   }
                 },
               ),
               const HeightSpacer(size: 20),

               CustomTextField(
                 controller: email,
                 keyboardType: TextInputType.emailAddress,
                 hintText: 'Email',
                 validator: (value) {
                   if (value!.isEmpty || !value.isEmail) {
                     return "Please enter valid email.";
                   } else {
                     return null;
                   }
                 },
               ),
               const HeightSpacer(size: 20),
               CustomTextField(
                 controller: password,
                 keyboardType: TextInputType.text,
                 hintText: 'Password',
                 obscureText: signupNotifier.isObsecure,
                 validator: (value) {
                   if (!signupNotifier.passwordValidator(value ?? '')) {
                     return "Please enter valid password with at least one uppercase,one lowercase,one digit,a special character and length of 8 characters.";
                   } else {
                     return null;
                   }
                 },
                 suffixIcon: GestureDetector(
                   onTap: () {
                     signupNotifier.isObsecure = !signupNotifier.isObsecure;
                   },
                   child: Icon(
                     signupNotifier.isObsecure
                         ? Icons.visibility
                         : Icons.visibility_off_rounded,
                     color: Color(kDark.value),
                   ),
                 ),
               ),

               HeightSpacer(size: 50),
               CustomButton(
                 onTap: () {
                   loginNotifier.firstTime = !loginNotifier.firstTime;
                 },
                 text: "Sign Up",
               ),
             ],
           ),
         ),
       );
     },
   );
 }
}