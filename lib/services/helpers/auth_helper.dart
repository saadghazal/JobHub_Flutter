import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobhub/models/request/auth/login_model.dart';
import 'package:jobhub/models/response/auth/login_res_model.dart';
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
    if(response.statusCode == 200){
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = loginResponseModelFromJson(response.body).userToken;
      String userId = loginResponseModelFromJson(response.body).id;
      String profileImage = loginResponseModelFromJson(response.body).profileImage;


      await prefs.setString('token', token);
      await prefs.setString('user_id', userId);
      await prefs.setString('profile_image', profileImage);
      await prefs.setBool('logged_in', true);

      return true;
    }else{
      return false;
    }
  }
}
