import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/app_style.dart';
import 'package:jobhub/views/common/drawer/drawer_widget.dart';
import 'package:jobhub/views/common/heading_widget.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/search.dart';
import 'package:jobhub/views/common/vertical_shimmer.dart';
import 'package:jobhub/views/common/vertical_tile.dart';
import 'package:jobhub/views/ui/jobs/job_page.dart';
import 'package:jobhub/views/ui/jobs/jobs_list.dart';
import 'package:jobhub/views/ui/jobs/widgets/horizontal_shimmer.dart';
import 'package:jobhub/views/ui/jobs/widgets/horizontal_tile.dart';
import 'package:jobhub/views/ui/search/searchpage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          actions: [
            Padding(
              padding: EdgeInsets.all(12.h),
              child: CircleAvatar(
                radius: 15.r,
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
            ),
          ],
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<JobsNotifier>(
        builder: (context, jobsNotifier, child) {
          jobsNotifier.getJobs();
          jobsNotifier.getRecentJob();
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeightSpacer(size: 10),
                    Text(
                      'Search\nFind & Apply',
                      style: appstyle(
                        40,
                        Color(kDark.value),
                        FontWeight.bold,
                      ),
                    ),
                    HeightSpacer(size: 40),
                    SearchWidget(
                      onTap: () {
                        Get.to(() => SearchPage());
                      },
                    ),
                    HeightSpacer(size: 30),
                    HeadingWidget(
                      text: 'Popular Jobs',
                      onTap: () {
                        Get.to(() => const JobListPage());
                      },
                    ),
                    HeightSpacer(size: 15),
                    SizedBox(
                      height: height * 0.28,
                      child: FutureBuilder(
                        future: jobsNotifier.jobsList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return HorizontalShimmer();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final Jobs = snapshot.data;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final job = Jobs[index];
                                return JobHorizontalTile(
                                  job: Jobs[index],
                                  onTap: () {
                                    Get.to(
                                      () => JobPage(
                                        id: job.id,
                                        title: job.title,
                                        location: job.location,
                                        company: job.company,
                                        hiring: job.hiring,
                                        description: job.description,
                                        salary: job.salary,
                                        period: job.period,
                                        contract: job.contract,
                                        requirements: job.requirements,
                                        imageUrl: job.imageUrl,
                                        agentId: job.agentId,
                                      ),
                                    );
                                  },
                                );
                              },
                              itemCount: Jobs!.length,
                            );
                          }
                        },
                      ),
                    ),
                    HeightSpacer(size: 20),
                    HeadingWidget(
                      text: 'Recently Posted',
                      onTap: () {},
                    ),
                    HeightSpacer(size: 20),
                    FutureBuilder(
                      future: jobsNotifier.recentJob,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return VerticalShimmer();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final job = snapshot.data!;

                          return VerticalTile(
                            onTap: () {
                              Get.to(() => JobPage(
                                    id: job.id,
                                    title: job.title,
                                    location: job.location,
                                    company: job.company,
                                    hiring: job.hiring,
                                    description: job.description,
                                    salary: job.salary,
                                    period: job.period,
                                    contract: job.contract,
                                    requirements: job.requirements,
                                    imageUrl: job.imageUrl,
                                    agentId: job.agentId,
                                  ));
                            },
                            recentJob: job,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
