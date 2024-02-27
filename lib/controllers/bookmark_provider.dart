import 'package:flutter/material.dart';
import 'package:jobhub/models/request/bookmarks/bookmarks_model.dart';
import 'package:jobhub/services/helpers/book_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import 'package:get/get.dart';

class BookMarkNotifier extends ChangeNotifier {
  List<String> _jobs = [];

  List<String> get jobs => _jobs;

  set jobs(List<String> newList) {
    _jobs = newList;
    notifyListeners();
  }

  Future<void> addJob(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_jobs.isNotEmpty) {
      _jobs.insert(0, jobId);
      prefs.setStringList('jobId', _jobs);
      notifyListeners();
    }
  }

  Future<void> loadJobs(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jobs = prefs.getStringList('jobId');

    if (jobs != null) {
      _jobs = jobs;
      notifyListeners();
    }
  }

  addBookmark(BookmarkRequest model, String jobId) {
    BookMarkHelper.addBookmark(model).then((response) {
      if (response[0]) {
        addJob(jobId);
        Get.snackbar(
          'Bookmark Successfully Added',
          'Please Check Your Bookmarks',
          colorText: Color(kLight.value),
          backgroundColor: Color(kLightBlue.value),
          icon: Icon(Icons.bookmark_add),
        );
      } else if (!response[0]) {
        Get.snackbar(
          'Failed To Add Bookmark',
          'Please Try Again',
          colorText: Color(kLight.value),
          backgroundColor: Color(kLightBlue.value),
          icon: Icon(Icons.bookmark_add),
        );
      }
    });
  }
}
