import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhub/models/request/auth/signup_model.dart';
import 'package:jobhub/services/helpers/auth_helper.dart';
import 'package:jobhub/views/ui/auth/update_user.dart';

import '../constants/app_constants.dart';

class SignUpNotifier extends ChangeNotifier {
// trigger to hide and unhide the password
  bool _isObsecure = true;

  bool get isObsecure => _isObsecure;

  set isObsecure(bool obsecure) {
    _isObsecure = obsecure;
    notifyListeners();
  }

// triggered when the login button is clicked to show the loading widget
  bool _processing = false;

  bool get processing => _processing;

  set processing(bool newValue) {
    _processing = newValue;
    notifyListeners();
  }

  final signupFormKey = GlobalKey<FormState>();

  bool passwordValidator(String password) {
    if (password.isEmpty) return false;
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  bool validateAndSave() {
    final form = signupFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  signUp({required SignupModel model}) {
    AuthHelper.signUp(model: model).then(
      (response) {
        if (response) {
          Get.offAll(
            () => PersonalDetails(),
            transition: Transition.fade,
            duration: Duration(seconds: 2),
          );
        } else {
          Get.snackbar(
            'Sign up Failed',
            'Please check your credentials',
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: Icon(Icons.add_alert),
          );
        }
      },
    );
  }
}
