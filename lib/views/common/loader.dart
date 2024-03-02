import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/views/common/reusable_text.dart';

import '../../constants/app_constants.dart';
import 'app_style.dart';
import 'height_spacer.dart';

class SearchLoading extends StatelessWidget {
  const SearchLoading({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/optimized_search.png'),
            HeightSpacer(size: 20),
            ReusableText(
              text: text,
              style: appstyle(
                24,
                Color(kDark.value),
                FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
