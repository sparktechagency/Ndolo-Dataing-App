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
    'https://s3-alpha-sig.figma.com/img/7d6b/ea28/b9dbd4b2bd6e566d7041c6a37b86a052?Expires=1735516800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ZhF5GUICF2VvX8thRnsxS713eszTBSM~9~tLmeD2~VLRppid4gQYw~Wl8eqkLgMHK-nky6bEJ1GtP-Ej0QbgVXcRsTxxX05e3MjTs6qpVsZl-5nspyxNYM2rlFv1P2WS5Z-WJbSI5OOGCnoukR9-aakMBJl36j6eD3RGia2GKgIjnNjvyYCjadMeqKgxz-t~u0y4NEbY8U~PZ82PEOP6aHCjWhu-lufNMD4qC8TW6dVcPLQ40W97c0~3t2YB~HLURZw5lLjsslAKk3nQwvc~52r0Cb4GSV02toXV8OptojLZv51g001YcUITZvMAZVgs-BgX3ERY2LH4osRzvN8Kiw__',
    'https://s3-alpha-sig.figma.com/img/a1c9/575c/4f24b44129bd1c1832d68d397b792497?Expires=1735516800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=gApV0GgAScr~HmAV30lTtGq6BCRcp7zXc4yxQ3KC4wfdZsWZ3jW4~e9az0FVvntpJnwhLbDi3LuFjoaVruQH2hGvaRs2P7-nqKgswWdSvUlnZ9~HTp~6AN11Z8O4KaVY5NUnTrPEJ7Qj6ywAfkHO6aB6LLjlbfNG7RuYLIEGUEBJ5mHVNfVpa9xwonMeMCAWv2tCQLqqFhFn4YqZqe4eNphtaZGWV3GwTPHfIimceEhMzZYAYSUAYXmkjPQks2qH59XsQ-yn40ag40WRGMZpMP~hKWR1moDqleylqfTM7oAU0MoEqiQGtssCfJEgN8vw4DHlC-CNhbwm~QXu-fXxaA__',
    'https://s3-alpha-sig.figma.com/img/7d6b/ea28/b9dbd4b2bd6e566d7041c6a37b86a052?Expires=1735516800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ZhF5GUICF2VvX8thRnsxS713eszTBSM~9~tLmeD2~VLRppid4gQYw~Wl8eqkLgMHK-nky6bEJ1GtP-Ej0QbgVXcRsTxxX05e3MjTs6qpVsZl-5nspyxNYM2rlFv1P2WS5Z-WJbSI5OOGCnoukR9-aakMBJl36j6eD3RGia2GKgIjnNjvyYCjadMeqKgxz-t~u0y4NEbY8U~PZ82PEOP6aHCjWhu-lufNMD4qC8TW6dVcPLQ40W97c0~3t2YB~HLURZw5lLjsslAKk3nQwvc~52r0Cb4GSV02toXV8OptojLZv51g001YcUITZvMAZVgs-BgX3ERY2LH4osRzvN8Kiw__',
    'https://s3-alpha-sig.figma.com/img/a1c9/575c/4f24b44129bd1c1832d68d397b792497?Expires=1735516800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=gApV0GgAScr~HmAV30lTtGq6BCRcp7zXc4yxQ3KC4wfdZsWZ3jW4~e9az0FVvntpJnwhLbDi3LuFjoaVruQH2hGvaRs2P7-nqKgswWdSvUlnZ9~HTp~6AN11Z8O4KaVY5NUnTrPEJ7Qj6ywAfkHO6aB6LLjlbfNG7RuYLIEGUEBJ5mHVNfVpa9xwonMeMCAWv2tCQLqqFhFn4YqZqe4eNphtaZGWV3GwTPHfIimceEhMzZYAYSUAYXmkjPQks2qH59XsQ-yn40ag40WRGMZpMP~hKWR1moDqleylqfTM7oAU0MoEqiQGtssCfJEgN8vw4DHlC-CNhbwm~QXu-fXxaA__',
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
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(AppImages.appLogo, width: 121.w, height: 32.h),
                const Spacer(),
                InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.filterScreen);
                    },
                    child: SvgPicture.asset(AppIcons.filter,
                        width: 24.w, height: 24.h)),
                SizedBox(width: 12.w),
                InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.notificationsScreen);
                    },
                    child: SvgPicture.asset(AppIcons.notification,
                        width: 32.w, height: 32.h)),
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
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r),
                                                            border: Border.all(
                                                                width: 1.w,
                                                                color: Colors
                                                                    .green)),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      8.w,
                                                                  vertical:
                                                                      4.h),
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons.circle,
                                                                  color: Colors
                                                                      .green,
                                                                  size: 12.w),
                                                              SizedBox(
                                                                  width: 4.w),
                                                              CustomText(
                                                                text:
                                                                    'Active New',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white,
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
                    _allSwiped
                        ? const SizedBox()
                        //===========================> Like Dislike Button Row <=============================
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //====================> Dislike Button <=================
                              GestureDetector(
                                onTap: () {},
                                child: _slideButton(
                                    SvgPicture.asset(AppIcons.dislike),
                                    Colors.red),
                              ),
                              SizedBox(width: 12.w),
                              //====================> Like Button <=================
                              GestureDetector(
                                onTap: () {},
                                child: _slideButton(
                                    SvgPicture.asset(AppIcons.like),
                                    const Color(0xffFF9D33)),
                              ),
                              SizedBox(width: 12.w),
                              //====================> Info Button <=================
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.profileDetailsScreen);
                                },
                                child: _slideButton(
                                    SvgPicture.asset(AppIcons.info),
                                    Colors.blue),
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
