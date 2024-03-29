import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/request/auth/login_model.dart';
import 'package:jobhub/models/request/auth/profile_update_model.dart';
import 'package:jobhub/services/helpers/auth_helper.dart';
import 'package:jobhub/views/ui/auth/login.dart';
import 'package:jobhub/views/ui/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;
  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool? _entryPoint;

  bool get entryPoint => _entryPoint ?? false;
  set entryPoint(bool newState) {
    _entryPoint = newState;
    notifyListeners();
  }

  bool? _loggedIn;

  bool get loggedIn => _loggedIn ?? false;
  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    entryPoint = prefs.getBool('entry_point') ?? false;
    loggedIn = prefs.getBool('logged_in') ?? false;
  }

  final loginFormKey = GlobalKey<FormState>();
  final profileFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = loginFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  bool profileValidation() {
    final form = profileFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  userLogin({required LoginModel model}) {
    AuthHelper.login(model: model).then((response) {
      if (response) {
        Get.offAll(() => MainScreen());
      } else {
        Get.snackbar(
          'Sign in Failed',
          'Please Check Your Credentials',
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert),
        );
      }
    });
  }

  updateProfile({required ProfileUpdateReq profileReq}) async {
    AuthHelper.updateProfile(profileReq: profileReq).then(
      (response) {
        if (response) {
          Get.snackbar(
            'Profile Updated',
            'Enjoy your search for a job',
            colorText: Color(kLight.value),
            backgroundColor: Color(kLightBlue.value),
            icon: Icon(Icons.add_alert),
          );
          Future.delayed(Duration(seconds: 2), () {
            Get.offAll(() => MainScreen());
          });
        } else {
          Get.snackbar(
            'Updating Failed',
            'Please try again',
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: Icon(Icons.add_alert),
          );
        }
      },
    );
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logged_in', false);
    await prefs.remove('token');
    await prefs.remove('userId');
    Get.offAll(() => LoginPage());
  }
}
