import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/ui/auth/signup.dart';
import 'package:provider/provider.dart';

import '../../../models/request/auth/login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, loginProvider, child) {
        loginProvider.getPrefs();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(
              text: 'Login',
              child: loginProvider.entryPoint && !loginProvider.loggedIn
                  ? SizedBox.shrink()
                  : GestureDetector(
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
                  text: 'Welcome Back!',
                  style: appstyle(
                    30,
                    Color(kDark.value),
                    FontWeight.w600,
                  ),
                ),
                ReusableText(
                  text: 'Fill the details to login to your account',
                  style: appstyle(
                    16,
                    Color(kDarkGrey.value),
                    FontWeight.w500,
                  ),
                ),
                const HeightSpacer(size: 50),
                Form(
                  key: loginProvider.loginFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Email',
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
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
                        obscureText: loginProvider.obscureText,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 7) {
                            return "Please enter valid password.";
                          } else {
                            return null;
                          }
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            loginProvider.obscureText = !loginProvider.obscureText;
                          },
                          child: Icon(
                            loginProvider.obscureText
                                ? Icons.visibility
                                : Icons.visibility_off_rounded,
                            color: Color(kDark.value),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                HeightSpacer(size: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        () => const RegistrationPage(),
                      );
                    },
                    child: ReusableText(
                      text: "Register",
                      style: appstyle(
                        14,
                        Color(kDark.value),
                        FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                HeightSpacer(size: 50),
                CustomButton(
                  onTap: () {
                    if (loginProvider.validateAndSave()) {
                      LoginModel model = LoginModel(email: email.text, password: password.text);
                      loginProvider.userLogin(model: model);
                    } else {
                      Get.snackbar(
                        'Sign in Failed',
                        'Please Check Your Credentials',
                        colorText: Color(kLight.value),
                        backgroundColor: Colors.red,
                        icon: Icon(Icons.add_alert),
                      );
                    }
                  },
                  text: "Login",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
