import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../helpers/route.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';

class BottomMenu extends StatelessWidget {
  final int menuIndex;

  const BottomMenu(this.menuIndex, {super.key});

  Color colorByIndex(ThemeData theme, int index) {
    return index == menuIndex ? AppColors.primaryColor : AppColors.primaryColor;
  }

  BottomNavigationBarItem getItem(
      String image, String title, ThemeData theme, int index) {
    return BottomNavigationBarItem(
        label: title,
        icon: Padding(
          padding: EdgeInsets.only(top:4.w),
          child: SvgPicture.asset(
            image,
            height: 24.h,
            width: 24.w,
            color: colorByIndex(theme, index),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<BottomNavigationBarItem> menuItems = [
      getItem(menuIndex == 0 ? AppIcons.homeOut: AppIcons.home, 'Home', theme, 0),
      getItem(menuIndex == 1 ? AppIcons.matchOut :  AppIcons.match, 'Matches', theme, 1),
      getItem(menuIndex == 2 ? AppIcons.messageOut: AppIcons.message, 'Message', theme, 2),
      getItem(menuIndex == 3 ? AppIcons.profileOut: AppIcons.profile, 'Profile', theme, 3),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      child: Container(

        decoration: BoxDecoration(
           // borderRadius: BorderRadius.only(topRight: Radius.circular(20.r),topLeft: Radius.circular(20.r)),
          borderRadius: BorderRadius.circular(44.r),
            border: Border.all(width: 1.w, color: AppColors.primaryColor),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color:Colors.black38,spreadRadius:0,blurRadius: 10)
            ]
        ),
        child: ClipRRect(
         // borderRadius: BorderRadius.only(topRight: Radius.circular(20.r),topLeft: Radius.circular(20.r)),
          borderRadius: BorderRadius.circular(44.r),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primaryColor,
            currentIndex: menuIndex,
            onTap: (value) {
              switch (value) {
                case 0:
                  Get.offAndToNamed(AppRoutes.homeScreen);
                  break;
                  case 1:
                  Get.offAndToNamed(AppRoutes.matchesScreen);
                  break;
                  case 2:
                  Get.offAndToNamed(AppRoutes.messageScreen);
                  break;
                  case 3:
                  Get.offAndToNamed(AppRoutes.profileScreen);
                  break;
              }
            },
            items: menuItems,
          ),
        ),
      ),
    );
  }
}