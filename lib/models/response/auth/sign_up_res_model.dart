// To parse this JSON data, do
//
//     final signUpResponseModel = signUpResponseModelFromJson(jsonString);

import 'dart:convert';

SignUpResponseModel signUpResponseModelFromJson(String str) =>
    SignUpResponseModel.fromJson(json.decode(str));

String signUpResponseModelToJson(SignUpResponseModel data) => json.encode(data.toJson());

class SignUpResponseModel {
  String id;
  String userToken;

  SignUpResponseModel({
    required this.id,
    required this.userToken,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) => SignUpResponseModel(
        id: json["_id"],
        userToken: json["userToken"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userToken": userToken,
      };
}
