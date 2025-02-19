/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/controllers/home_controller.dart';
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
  final HomeController _homeController = Get.put(HomeController());
  final TCardController _cardController = TCardController();
  bool _allSwiped = false;

  // Image list
  final List<String> _images = [
    'https://s3-alpha-sig.figma.com/img/01cd/62e1/b16e1145d535e3816e93a81f3a7100da?Expires=1740355200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=WGDKnqpEDPElv9GmYfRWBZCP67BpgFXsUE5iXCu9B3cFWv7MgZO4z-r-03Mtoq2M3F68gDlX0lGYUh2TErxJFR7ljzTnk705AF6dycYbtbzEuocvmNTcunS4oc3q9hJUa3~nIww9EIYC2vE55DoqmyqZ114AFDM~3NA9N919cyTU85iM11vA~dg0HqeSXIvIoQGcoH6nM~pfFCHbBpsPLT6oTNIQn0aXKg8E~9lom37Ndc34XoFvtUF414a2kR4NlvoSA6TGBm9ZN6wtbUXfUkCY1wpxA5irZyhEZjq1dlNNZsuawub3C8elq1lAjNLriBOkal86RYYfjfDS5w3bVg__',
    'https://s3-alpha-sig.figma.com/img/01cd/62e1/b16e1145d535e3816e93a81f3a7100da?Expires=1740355200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=WGDKnqpEDPElv9GmYfRWBZCP67BpgFXsUE5iXCu9B3cFWv7MgZO4z-r-03Mtoq2M3F68gDlX0lGYUh2TErxJFR7ljzTnk705AF6dycYbtbzEuocvmNTcunS4oc3q9hJUa3~nIww9EIYC2vE55DoqmyqZ114AFDM~3NA9N919cyTU85iM11vA~dg0HqeSXIvIoQGcoH6nM~pfFCHbBpsPLT6oTNIQn0aXKg8E~9lom37Ndc34XoFvtUF414a2kR4NlvoSA6TGBm9ZN6wtbUXfUkCY1wpxA5irZyhEZjq1dlNNZsuawub3C8elq1lAjNLriBOkal86RYYfjfDS5w3bVg__',
    'https://s3-alpha-sig.figma.com/img/01cd/62e1/b16e1145d535e3816e93a81f3a7100da?Expires=1740355200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=WGDKnqpEDPElv9GmYfRWBZCP67BpgFXsUE5iXCu9B3cFWv7MgZO4z-r-03Mtoq2M3F68gDlX0lGYUh2TErxJFR7ljzTnk705AF6dycYbtbzEuocvmNTcunS4oc3q9hJUa3~nIww9EIYC2vE55DoqmyqZ114AFDM~3NA9N919cyTU85iM11vA~dg0HqeSXIvIoQGcoH6nM~pfFCHbBpsPLT6oTNIQn0aXKg8E~9lom37Ndc34XoFvtUF414a2kR4NlvoSA6TGBm9ZN6wtbUXfUkCY1wpxA5irZyhEZjq1dlNNZsuawub3C8elq1lAjNLriBOkal86RYYfjfDS5w3bVg__',
    'https://s3-alpha-sig.figma.com/img/01cd/62e1/b16e1145d535e3816e93a81f3a7100da?Expires=1740355200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=WGDKnqpEDPElv9GmYfRWBZCP67BpgFXsUE5iXCu9B3cFWv7MgZO4z-r-03Mtoq2M3F68gDlX0lGYUh2TErxJFR7ljzTnk705AF6dycYbtbzEuocvmNTcunS4oc3q9hJUa3~nIww9EIYC2vE55DoqmyqZ114AFDM~3NA9N919cyTU85iM11vA~dg0HqeSXIvIoQGcoH6nM~pfFCHbBpsPLT6oTNIQn0aXKg8E~9lom37Ndc34XoFvtUF414a2kR4NlvoSA6TGBm9ZN6wtbUXfUkCY1wpxA5irZyhEZjq1dlNNZsuawub3C8elq1lAjNLriBOkal86RYYfjfDS5w3bVg__',
    'https://s3-alpha-sig.figma.com/img/01cd/62e1/b16e1145d535e3816e93a81f3a7100da?Expires=1740355200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=WGDKnqpEDPElv9GmYfRWBZCP67BpgFXsUE5iXCu9B3cFWv7MgZO4z-r-03Mtoq2M3F68gDlX0lGYUh2TErxJFR7ljzTnk705AF6dycYbtbzEuocvmNTcunS4oc3q9hJUa3~nIww9EIYC2vE55DoqmyqZ114AFDM~3NA9N919cyTU85iM11vA~dg0HqeSXIvIoQGcoH6nM~pfFCHbBpsPLT6oTNIQn0aXKg8E~9lom37Ndc34XoFvtUF414a2kR4NlvoSA6TGBm9ZN6wtbUXfUkCY1wpxA5irZyhEZjq1dlNNZsuawub3C8elq1lAjNLriBOkal86RYYfjfDS5w3bVg__',
  ];

  List<bool> _likedImages = [];
  List<bool> _dislikedImages = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _likedImages = List.filled(_homeController.homeUserModel.length, false);
    _dislikedImages = List.filled(_homeController.homeUserModel.length, false);
    _homeController.getUserData();
  }

  // Handle swipe actions for like/dislike
  void _onSwipe(SwipDirection direction, int index) {
    if (index >= 0 && index < _homeController.homeUserModel.length) {
      if (direction == SwipDirection.Left) {
        _handleDislike(index);
      } else if (direction == SwipDirection.Right) {
        _handleLike(index);
      }

      _moveToNextCard();
    }
  }

// Method to handle "Like" action
  void _handleLike(int index) {
    setState(() {
      _likedImages[index] = true;
      print('Liked image ${index + 1}');
    });
  }

// Method to handle "Dislike" action
  void _handleDislike(int index) {
    setState(() {
      _dislikedImages[index] = true;
      print('Disliked image ${index + 1}');
    });
  }

// Method to move to the next card after like/dislike
  void _moveToNextCard() {
    if (_currentIndex < _homeController.homeUserModel.length - 1) {
      setState(() {
        _currentIndex++;
        _cardController.forward();
      });
    } else {
      setState(() {
        _allSwiped = true;
      });
    }
  }

// Handle Like or Dislike when button is pressed
  void _handleLikeDislike(bool isLiked) {
    if (_currentIndex >= 0 && _currentIndex < _homeController.homeUserModel.length) {
      if (isLiked) {
        _handleLike(_currentIndex);
      } else {
        _handleDislike(_currentIndex);
      }

      _moveToNextCard();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(0),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Image.asset(AppImages.appLogo, width: 121.w, height: 32.h),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.filterScreen);
                    },
                    child: SvgPicture.asset(AppIcons.filter,
                        width: 24.w, height: 24.h),
                  ),
                  SizedBox(width: 12.w),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.notificationsScreen);
                    },
                    child: SvgPicture.asset(AppIcons.notification,
                        width: 32.w, height: 32.h),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Column(
                children: [
                  _currentIndex >= _homeController.homeUserModel.length
                      ? const SizedBox()
                      : CustomText(
                    text: AppStrings.findYourMatch,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff430750),
                  ),
                  _currentIndex >= _homeController.homeUserModel.length
                      ? Expanded(
                    child: Center(
                      child: CustomText(
                        text: "No One Available",
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                      ),
                    ),
                  )
                      : Expanded(
                    child: TCard(
                      controller: _cardController,
                      size: const Size(double.infinity,
                          double.infinity),
                      cards: _homeController.homeUserModel.asMap().entries.map((entry) {
                        int index = entry.key;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            CustomTinderCard(
                              imageUrl: '${_homeController.homeUserModel.value.profileImage}',
                              index: index, // Pass the index here
                            ),
                            Positioned(
                              bottom: 20.h,
                              left: 50.w,
                              right: 50.w,
                              child: Column(
                                children: [
                                  CustomText(
                                    text: '${_homeController.homeUserModel.value.fullName}, ${_homeController.homeUserModel.value.age}',
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.location_on,
                                            color: Colors.white,
                                            size: 20.h),
                                        SizedBox(width: 4.w),
                                        Expanded(
                                          child: CustomText(
                                            text: '${_homeController.homeUserModel.value.location}',
                                            color: Colors.white,
                                            maxLine: 2,
                                            textAlign: TextAlign.start,
                                            textOverflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: GestureDetector(
                                          onTap: () {
                                            _handleLikeDislike(false); // Dislike
                                          },
                                          child: _slideButton(
                                              SvgPicture.asset(
                                                  AppIcons.dislike),
                                              Colors.red),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Flexible(
                                        child: GestureDetector(
                                          onTap: () {
                                            _handleLikeDislike(true); // Like
                                          },
                                          child: _slideButton(
                                              SvgPicture.asset(
                                                  AppIcons.like),
                                              const Color(0xffFF9D33)),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Flexible(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed(AppRoutes.profileDetailsScreen);
                                          },
                                          child: _slideButton(
                                              SvgPicture.asset(
                                                  AppIcons.info),
                                              Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                      onForward: (index, info) {
                        // Handle swipe here
                        _onSwipe(info.direction, index);
                      },
                      onEnd: () {
                        setState(() {
                          _allSwiped = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _slideButton(Widget icon, Color borderColor) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1.w, color: borderColor),
          color: Colors.white),
      child: Padding(padding: EdgeInsets.all(8.w), child: icon),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/service/api_constants.dart';
import 'package:ndolo_dating/controllers/home_controller.dart';
import 'package:ndolo_dating/models/home_user_model.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/utils/app_images.dart';
import 'package:tcard/tcard.dart';
import '../../../helpers/route.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_text.dart';
import '../../base/custom_tinder_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.put(HomeController());
  final TCardController _cardController = TCardController();
  bool _allSwiped = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _homeController.getUserData();
  }

  void _onSwipe(SwipDirection direction, int index) {
    if (index >= 0 && index < _homeController.homeUserModel.length) {
      if (direction == SwipDirection.Left) {
        _handleDislike(index);
      } else if (direction == SwipDirection.Right) {
        _handleLike(index);
      }
    }
  }

  //==========================> Handle "Like" action (Right swipe) <====================
  void _handleLike(int index) {
    print('Liked image ${index + 1}');
    _homeController.postUserData(_homeController.homeUserModel.value[index].id ?? '');
  }

  //==========================> Handle "Dislike" action (Left swipe) <==========================
  void _handleDislike(int index) {
    print('Disliked image ${index + 1}');
  }

  //==========================> Handle Like or Dislike when button is pressed <=============================
  void _handleLikeDislike(bool isLiked) {
    if (_currentIndex >= 0 && _currentIndex < _homeController.homeUserModel.length) {
      if (isLiked) {
        _handleLike(_currentIndex);
      } else {
        _handleDislike(_currentIndex);
      }
      _moveToNextCard();
    }
  }
  //===========================> Move to the next card after like/dislike <=============================
  void _moveToNextCard() {
    if (_currentIndex < _homeController.homeUserModel.length - 1) {
      setState(() {
        _currentIndex++;
        _cardController.forward();
      });
    } else {
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
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Image.asset(AppImages.appLogo, width: 121.w, height: 32.h),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.filterScreen);
                    },
                    child: SvgPicture.asset(AppIcons.filter, width: 24.w, height: 24.h),
                  ),
                  SizedBox(width: 12.w),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.notificationsScreen);
                    },
                    child: SvgPicture.asset(AppIcons.notification, width: 32.w, height: 32.h),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Obx(() {
                if (_homeController.homeLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                final userList = _homeController.homeUserModel.value;
                if (userList.isEmpty) {
                  return Center(child: CustomText(text: "No Users Available"));
                }

                return Column(
                  children: [
                    CustomText(
                      text: "Find Your Match",
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff430750),
                    ),
                    Expanded(
                      child: TCard(
                        controller: _cardController,
                        size: const Size(double.infinity, double.infinity),
                        cards: List.generate(userList.length, (index) {
                          final HomeUserModel user = userList[index];
                          final String imageUrl = '${ApiConstants.imageBaseUrl}${user.gallery![0] ?? ""}';
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              CustomTinderCard(
                                imageUrl: imageUrl,
                                index: index,
                              ),
                              Positioned(
                                bottom: 30.h,
                                left: 50.w,
                                right: 50.w,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      text: '${user.firstName ?? "N/A"}, ${user.age ?? "N/A"}',
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 6.h),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.location_on, color: Colors.white, size: 20.h),
                                        SizedBox(width: 4.w),
                                        Flexible(
                                          child: CustomText(
                                            text: user.address ?? "N/A",
                                            color: Colors.white,
                                            maxLine: 2,
                                            textAlign: TextAlign.start,
                                            textOverflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () => _handleLikeDislike(false),
                                            child: _slideButton(SvgPicture.asset(AppIcons.dislike), Colors.red),
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () {
                                              _handleLikeDislike(true);
                                              _homeController.postUserData('$user.id');
                                            },
                                            child: _slideButton(SvgPicture.asset(AppIcons.like), const Color(0xffFF9D33)),
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.toNamed(AppRoutes.profileDetailsScreen, parameters: {
                                                'profileId': user.id ?? '',
                                                'age': '${user.age ?? ''}',
                                              });
                                            },
                                            child: _slideButton(SvgPicture.asset(AppIcons.info), Colors.blue),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                        onForward: (index, info) => _onSwipe(info.direction, index),
                        onEnd: () => setState(() => _allSwiped = true),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _slideButton(Widget icon, Color borderColor) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1.w, color: borderColor),
          color: Colors.white),
      child: Padding(padding: EdgeInsets.all(8.w), child: icon),
    );
  }
}
