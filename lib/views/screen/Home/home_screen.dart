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
    'https://s3-alpha-sig.figma.com/img/a1c9/575c/4f24b44129bd1c1832d68d397b792497?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=GwEsZ3WRA~UZBXPSyVn1~EP56OutWf9ks3Pp5SGI6MCjGGZAFlHEi2N4IlDVFviedcItZdtfZQtgWJHPudEZFWEcFDRzdXKF-VR8B1Sbr0xTBOs2pmjcEAJUy-mGNPoh0~QXEtajPrE9MKTiQrV2581Cm0gx8yNzIXLqrRy5xdqs6nyUprsgffdi~rkm3SylakKm40tW6mCca7fwwTduZ6hzxrjf1vsbiFdkl9ntcgMN89j3zasCaMxVOa9wueLCPiablbJiC1z5lO8nY5ensKpTa5AKMLg0pS6dIDBEst9u95IIhxLBaaheZC2JrOb6aAwBzMY2hq5R1IhXkaWpfg__',
    'https://s3-alpha-sig.figma.com/img/d11d/ebff/2758987d01bb00c7afbb5e74c73d4808?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=NNvCKlxW6oAOBhadua7uiKKhyr-FcnSBU-2upH5Hk9lOHnkdZAQ6Hj~kLkKPLyhC-zfK1WVmffrgadLxcowUtj8zCRAGebg1gyslqJ9w~89EaXIo6Ou7pnkPlanG1SMIgLGUtOjrhDE4zfQupfTDLZb2xutTEawa0TEYTYdxeV-2b2yhIJIvLt3Yixzsw-hCYiGlIphg3lwxIZ0vpJ4woFmSpsmgmh-S2BM54gwMuOLitzTlKlq2bkIhb8n2OY3TyFZuqZ7RDeLC~VcOFClhSTzH5MeWfwcsBAOmhiu99dl70vxC~1X~z5ai6Sw62XGKAo3jVfh0mseZR3Yyi1EDOA__',
    'https://s3-alpha-sig.figma.com/img/fcc1/2042/078a0dcc8085c1ceb176db56ab1fbc80?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=n5VSWsYsg~5e4iyvKz5-2hBtFGbPtt8j4e3fA9fx-kfD~vTDonC25vJlJguKpmmrsEEKUvmwUGbRXfmeWRFO8uGcL2JFNat5xRr7Nardp3ipc7-B5WEZ9rDHJ~9iIYceLkb847fwhMIF3d4eREBn75I9WGmlCvzXVyp0ryNe4KCa2qRreHXI1dREtANPzM8IusPDCw~X9ax5wo15mhpe2BGCnx927Ei8l5LImWSuAlWSNW3G0aS7A0pnqGowxCwzLw668HJmkoitsIQ~~fpT42w-o0siqeSh14Q4-vab74UNOrpkDLxoIaJWLTT4xXGZiE1W8RdPG3r5rm9O9FOofA__',
    'https://s3-alpha-sig.figma.com/img/2052/9a38/2fb230f545728379c6f60d80f137df06?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=N-clT1d5X~GISp4cONDqDLWWXVo827zOP0UEhZZMMO0kdeN7u9yn47jogRwuelR1dqoM6hb9D9nBOuM6JBiHMOCk5zHt0DC4GUixG5DJoA74sTiNMUE8KMh6jk72WayfoAHBhIglgBqIGUqFvvfVumdgJRew0hWJvL0LT7TRHnva9pbRFw8yuiEowyNAMUuONmwZNW3q2NvsibH~bLYGeAJV6oFZwV7s2eFTu5amqpeY~HAaI0J3uxYaJeBtFW9EYdKyPhXyPKdRRJ-hNx02kw3JycJKOy6jUBRUxYacLX12xR4GjMRRWU58cNTSLpkFEGYW~JzldyorXEMPDkbb-Q__',
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
