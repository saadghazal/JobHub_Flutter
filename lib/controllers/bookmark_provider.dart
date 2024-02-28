import 'package:flutter/material.dart';
import 'package:jobhub/models/request/bookmarks/bookmarks_model.dart';
import 'package:jobhub/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhub/services/helpers/book_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import 'package:get/get.dart';

class BookMarkNotifier extends ChangeNotifier {
  List<String> _jobs = [];
  Future<List<AllBookmark>>? bookmarks;

  List<String> get jobs => _jobs;

  set jobs(List<String> newList) {
    _jobs = newList;
    notifyListeners();
  }

  Future<void> addJob(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_jobs != null) {
      _jobs.insert(0, jobId);
      prefs.setStringList('jobId', _jobs);
      notifyListeners();
    }
  }

  Future<void> removeJob(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_jobs != null) {
      _jobs.remove(jobId);
      prefs.setStringList('jobId', _jobs);
      notifyListeners();
    }
  }

  Future<void> loadJobs() async {
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

  deleteBookmark(String jobId) {
    BookMarkHelper.deleteBookmark(jobId).then((response) {
      if (response) {
        removeJob(jobId);
        Get.snackbar(
          'Bookmark Deleted Successfully',
          'Please Check Your Bookmarks',
          colorText: Color(kLight.value),
          backgroundColor: Color(kOrange.value),
          icon: Icon(Icons.bookmark_remove),
        );
      } else if (!response) {
        Get.snackbar(
          'Failed To Delete Bookmark',
          'Please Try Again',
          colorText: Color(kLight.value),
          backgroundColor: Color(kOrange.value),
          icon: Icon(Icons.bookmark_remove),
        );
      }
    });
  }

  getBookmarks() {
    bookmarks = BookMarkHelper.getBookmarks();
  }
}
