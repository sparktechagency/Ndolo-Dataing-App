import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ndolo_dating/utils/app_icons.dart';

import '../../../utils/app_images.dart';
import '../../base/bottom_menu..dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(0),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                //===========================> Logo And Notification Row <=============================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(AppImages.appLogo, width: 121.w, height: 32.h),
                    InkWell(
                      onTap: (){},
                        child: SvgPicture.asset(AppIcons.notification, width: 32.w,height: 32.h))
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}
