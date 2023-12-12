import 'package:http/http.dart' as https;
import 'package:jobhub/models/response/jobs/jobs_response.dart';

import '../config.dart';

class JobsHelper {
  static var client = https.Client();

  static Future<List<JobsResponse>> getJobs() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.https(Config.apiUrl, Config.jobs);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      var jobs = jobsResponseFromJson(response.body);
      return jobs;
    } else {
      throw Exception("Failed To Get The Jobs");
    }
  }
}
