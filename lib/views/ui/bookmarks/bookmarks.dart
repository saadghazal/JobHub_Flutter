import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhub/views/ui/bookmarks/widgets/bookmark_widget.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';
import '../jobs/widgets/horizontal_shimmer.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            text: 'Bookmarks',
            child: Padding(
              padding: EdgeInsets.all(12.h),
              child: DrawerWidget(),
            ),
          ),
        ),
        body: Consumer<BookMarkNotifier>(builder: (
          context,
          bookmarkNotifier,
          child,
        ) {
          bookmarkNotifier.getBookmarks();
          return FutureBuilder<List<AllBookmark>>(
            future: bookmarkNotifier.bookmarks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final bookmarks = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return BookMarkWidget(job: bookmarks[index]);
                  },
                  itemCount: bookmarks!.length,
                );
              }
            },
          );
        }));
  }
}
