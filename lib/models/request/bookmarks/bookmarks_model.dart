// To parse this JSON data, do
//
//     final bookmarkRequest = bookmarkRequestFromJson(jsonString);

import 'dart:convert';

BookmarkRequest bookmarkRequestFromJson(String str) => BookmarkRequest.fromJson(json.decode(str));

String bookmarkRequestToJson(BookmarkRequest data) => json.encode(data.toJson());

class BookmarkRequest {
  final String job;

  BookmarkRequest({
    required this.job,
  });

  factory BookmarkRequest.fromJson(Map<String, dynamic> json) => BookmarkRequest(
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
        "job": job,
      };
}
