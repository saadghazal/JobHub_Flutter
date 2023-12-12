import 'package:flutter/foundation.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/services/helpers/jobs_helper.dart';

class JobsNotifier extends ChangeNotifier {
  late Future<List<JobsResponse>> jobsList;
  late Future<JobsResponse> recentJob;
  getJobs() {
    jobsList = JobsHelper.getJobs();
  }

  getRecentJob() {
    recentJob = JobsHelper.getRecentJob();
  }
}
