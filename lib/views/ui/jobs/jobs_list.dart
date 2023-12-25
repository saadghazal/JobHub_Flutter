import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/vertical_tile.dart';
import 'package:jobhub/views/ui/jobs/widgets/job_tile.dart';
import 'package:provider/provider.dart';

class JobListPage extends StatelessWidget {
  const JobListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var jobList = Provider.of<JobsNotifier>(context);
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(CupertinoIcons.arrow_left),
          ),
          text: 'Jobs',
        ),
        preferredSize: Size.fromHeight(50.h),
      ),
      body: FutureBuilder<List<JobsResponse>>(
        future: jobList.jobsList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(kLightBlue.value),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final jobs = snapshot.data;
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              itemBuilder: (context, index) {
                return VerticalTileWidget(
                  job: jobs[index],
                );
              },
              itemCount: jobs!.length,
            );
          }
        },
      ),
    );
  }
}
