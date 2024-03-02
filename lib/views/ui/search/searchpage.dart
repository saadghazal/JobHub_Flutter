import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/services/helpers/jobs_helper.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/ui/jobs/widgets/job_tile.dart';
import 'package:jobhub/views/ui/search/widgets/custom_field.dart';

import '../../common/loader.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kOrange.value),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(kLight.value)),
        title: CustomField(
          hintText: 'Search for a job',
          controller: searchController,
          onEditingComplete: () {
            setState(() {});
          },
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Icon(AntDesign.search1),
          ),
        ),
      ),
      body: searchController.text.isEmpty
          ? SearchLoading(
              text: 'Start Searching For Job',
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: FutureBuilder<List<JobsResponse>>(
                future: JobsHelper.searchJobs(searchQuery: searchController.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color(kLightBlue.value),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.data!.isEmpty) {
                    return SearchLoading(text: 'Job Not Found');
                  } else {
                    final jobs = snapshot.data;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return VerticalTileWidget(job: jobs[index]);
                      },
                      itemCount: jobs!.length,
                    );
                  }
                },
              ),
            ),
    );
  }
}
