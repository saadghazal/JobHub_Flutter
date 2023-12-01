import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobhub/models/request/auth/login_model.dart';
import 'package:jobhub/services/config.dart';

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

      return true;
    }else{
      return false;
    }
  }
}
