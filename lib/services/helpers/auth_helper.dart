import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobhub/models/request/auth/login_model.dart';
import 'package:jobhub/models/request/auth/profile_update_model.dart';
import 'package:jobhub/models/request/auth/signup_model.dart';
import 'package:jobhub/models/response/auth/login_res_model.dart';
import 'package:jobhub/models/response/auth/sign_up_res_model.dart';
import 'package:jobhub/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = https.Client();

  static Future<bool> login({required LoginModel model}) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.https(Config.apiUrl, Config.loginUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = loginResponseModelFromJson(response.body).userToken;
      String userId = loginResponseModelFromJson(response.body).id;
      String profileImage = loginResponseModelFromJson(response.body).profileImage;

      await prefs.setString('token', token);
      await prefs.setString('user_id', userId);
      await prefs.setString('profile_image', profileImage);
      await prefs.setBool('logged_in', true);

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateProfile({
    required ProfileUpdateReq profileReq,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(Config.apiUrl, Config.profileUrl);
    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(profileReq),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> signUp({required SignupModel model}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.https(Config.apiUrl, Config.signupUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    print(response.body);
    if (response.statusCode == 201) {
      String token = signUpResponseModelFromJson(response.body).userToken;
      String userId = signUpResponseModelFromJson(response.body).id;
      await prefs.setString('token', token);
      await prefs.setString('user_id', userId);
      return true;
    } else {
      return false;
    }
  }
}
