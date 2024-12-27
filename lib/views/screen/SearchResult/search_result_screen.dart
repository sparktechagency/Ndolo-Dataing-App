import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/views/base/custom_network_image.dart';
import '../../../utils/app_colors.dart';
import '../../base/custom_app_bar.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final List<Member> members = List.generate(
    12,
    (index) => Member(
      name: 'Janet Doe',
      location: 'United States',
      imageUrl:
          'https://s3-alpha-sig.figma.com/img/a1c9/575c/4f24b44129bd1c1832d68d397b792497?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=HP~g2isaLmKYYEX7JW5pkf3BqASThNhk2qr9Lwm4n~hb3-MNOCkMkSKisOmJR1Ek1RbvHPJg0FR0JQMftfttFmCtbeAzM92m1pgnyTco2JJSLsO5FRaNeULov3LA1cjRd1PhnJptohNDdsWFaR2MD8KnrfxfxKZ3svY5SPrGvRQZVLJ44z0tGYwRxkd8PvJP0TTUdQZNodflp7pIQQZN3oVyanZ~68VCaFlQc6j8jzOSFYeYpSPk6CSs2R61QZhvdCJ1Ys1re~sL5TUgZmDIeBobPPnuYe~u36UYZf8yl4JRCfJO50xNVW7mD9Twq3HtYS8RHCqjoAYHrwt3Sbf8mg__',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Search Result'.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final profile = members[index];
                  return _memberTile(index + 1, profile);
                  /* ProfileCard(
                    name: profile["name"]!,
                    role: profile["contribution"]!,
                    imageUrl: profile["image"]!,
                  );*/
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

//==============================> Member Tile <============================
  _memberTile(int rank, Member member) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.profileDetailsScreen);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
            color: AppColors.fillColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.greyColor, width: 1.w)),
        child: Row(
          children: [
            Text(
              rank.toString(),
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.red),
            ),
            SizedBox(width: 12.w),
            CustomNetworkImage(
                imageUrl: member.imageUrl,
                height: 48.h,
                width: 48.w,
                boxShape: BoxShape.circle),
            /*  CircleAvatar(
              radius: 32.r,
              backgroundImage: AssetImage(member.imageUrl),
            ),*/
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Location: ${member.location}',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Member {
  final String name;
  final String location;
  final String imageUrl;

  Member({
    required this.name,
    required this.location,
    required this.imageUrl,
  });
}
