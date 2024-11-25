import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';
import 'package:tcard/tcard.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_images.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_tinder_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TCardController _cardController = TCardController();
  bool _allSwiped = false;

  final List<String> _images = [
    AppImages.man,
    AppImages.woman,
    AppImages.woman1,
    AppImages.woman2,
  ];

  void _onSwipe(SwipDirection direction, int index) {
    if (direction == SwipDirection.Left) {
      setState(() {});
      print('Disliked image ${index + 1}');
    } else if (direction == SwipDirection.Right) {
      setState(() {});
      print('Liked image ${index + 1}');
    }

    if (index == _images.length - 0) {
      setState(() {
        _allSwiped = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(0),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            //===========================> Logo And Notification Row <=============================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(AppImages.appLogo, width: 121.w, height: 32.h),
                InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(AppIcons.notification,
                        width: 32.w, height: 32.h))
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomText(
                      text: AppStrings.findYourMatch,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff430750),
                    ),
                    _allSwiped
                        ? Center(
                            child: CustomText(
                              text: "No One Available",
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                            ),
                          )
                        : Column(
                            children: [
                              //==============================> Tinder Swipe Section <=================
                              Center(
                                child: Container(
                                  width: 345.w,
                                  height: 495.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: TCard(
                                          controller: _cardController,
                                          cards: _images
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            return Stack(
                                              children: [
                                                CustomTinderCard(
                                                    imageUrl: entry.value,
                                                    index: entry.key),
                                                //===========================> Name and Role Positioned <===================
                                                Positioned(
                                                  bottom: 20.h,
                                                  left: 20.w,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      //==================> Name <===================
                                                      CustomText(
                                                        text: 'Kalvin, 23',
                                                        fontSize: 32.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                      ),
                                                      //==================> Location Row <===================
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons.location_on,
                                                              color:
                                                                  Colors.white,
                                                              size: 14.h),
                                                          SizedBox(width: 4.w),
                                                          CustomText(
                                                            text:
                                                                'LOS Angeles • 20 kms away',
                                                            color: Colors.white,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 6.h),
                                                      //==================> Active Now Container <===================
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8.r),
                                                            border: Border.all(
                                                                width: 1.w,
                                                                color: Colors.green)),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons.circle, color: Colors.green, size: 12.w),
                                                              SizedBox(width: 4.w),
                                                              CustomText(
                                                                text: 'Active New',
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.white,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                          onForward: (index, info) {
                                            _onSwipe(info.direction, index);
                                          },
                                          onEnd: () {
                                            setState(() {
                                              _allSwiped = true;
                                            });
                                            print(
                                                '====================> All cards swiped!');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: 16.h),
                    //===========================> Like Dislike Button Row <=============================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //====================> Dislike Button <=================
                        GestureDetector(
                          onTap: () {},
                          child: _slideButton(
                              SvgPicture.asset(AppIcons.dislike), Colors.red),
                        ),
                        SizedBox(width: 12.w),
                        //====================> Like Button <=================
                        GestureDetector(
                          onTap: () {},
                          child: _slideButton(SvgPicture.asset(AppIcons.like),
                              const Color(0xffFF9D33)),
                        ),
                        SizedBox(width: 12.w),
                        //====================> Info Button <=================
                        GestureDetector(
                          onTap: () {},
                          child: _slideButton(
                              SvgPicture.asset(AppIcons.info), Colors.blue),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

//================================> Slide Button <=========================
  _slideButton(Widget icon, Color borderColor) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1.w, color: borderColor),
      ),
      child: Padding(padding: EdgeInsets.all(20.w), child: icon),
    );
  }
}
