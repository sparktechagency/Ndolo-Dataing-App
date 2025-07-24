import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/controllers/messages/message_controller.dart';
import 'package:ndolo_dating/service/api_constants.dart';
import 'package:ndolo_dating/controllers/home_controller.dart';
import 'package:ndolo_dating/models/home_user_model.dart';
import 'package:ndolo_dating/service/socket_services.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import 'package:ndolo_dating/utils/app_images.dart';
import 'package:tcard/tcard.dart';
import '../../../helpers/route.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_page_loading.dart';
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
  final MessageController messageController = Get.put(MessageController());
  final SocketServices _socket = SocketServices();

  bool _allSwiped = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _homeController.getUserData();
    _socket.init();
  }

  void _onSwipe(SwipDirection direction, int index) {
    if (index < 0 || index >= _homeController.homeUserModel.length) return;

    if (direction == SwipDirection.Left) {
      _handleDislike(index);
    } else if (direction == SwipDirection.Right) {
      _handleLike(index);
    }
    //_moveToNextCard();
  }

//==========================> Handle "Like" action (Right swipe) <====================
  void _handleLike(int index) {
    final user = _homeController.homeUserModel.value[index];
    if (user.id != null) {
      print('Liked: ${user.firstName} (${user.id})');
      _homeController.postUserData(user.id!);
    }
  }

  //==========================> Handle "DisLike" action (Right swipe) <====================
  void _handleDislike(int index) {
    final user = _homeController.homeUserModel.value[index];
    print('Disliked: ${user.firstName} (${user.id})');
  }

//==========================> Handle Like or Dislike when button is pressed <==========================
  /* void _handleLikeDislike(bool isLiked) {
    if (_currentIndex >= _homeController.homeUserModel.length) return;
    if (isLiked) {
      _handleLike(_currentIndex);
    } else {
      _handleDislike(_currentIndex);
    }
  }*/

//==========================> Handle Like or Dislike when button is pressed <=============================
  void _handleLikeDislike(bool isLiked) {
    if (_currentIndex >= _homeController.homeUserModel.length) return;

    if (isLiked) {
      _handleLike(_currentIndex);
      _cardController.forward(
          direction: SwipDirection.Right);
    } else {
      _handleDislike(_currentIndex);
      _cardController.forward(
          direction: SwipDirection.Left);
    }
    //_moveToNextCard();
  }

//===========================> Move to the next card smoothly <=============================
  void _moveToNextCard() {
    if (_currentIndex < _homeController.homeUserModel.length - 1) {
      setState(() {
        _currentIndex++;
      });
      Future.delayed(const Duration(milliseconds: 300), () {
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
              child: Obx(() {
                if (_homeController.homeLoading.value) {
                  return const Center(child: CustomPageLoading());
                }
                final userList = _homeController.homeUserModel.value;
                if (userList.isEmpty) {
                  return Center(child: CustomText(text: "No users found".tr));
                }
                return Column(
                  children: [
                    Expanded(
                      child: TCard(
                        controller: _cardController,
                        size: const Size(double.infinity, double.infinity),
                        cards: List.generate(userList.length, (index) {
                          final HomeUserModel user = userList[index];
                          final String imageUrl = (user.gallery?.isNotEmpty ??
                                  false)
                              ? '${ApiConstants.imageBaseUrl}${user.gallery![0]}'
                              : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: CustomText(
                                            text: user.firstName ?? "N/A",
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w700,
                                            maxLine: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Flexible(
                                          child: CustomText(
                                            text: ', ${user.age ?? "N/A"}',
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.h),
                                    //========================> Location Row <=======================
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.location_on,
                                            color: Colors.white, size: 20.h),
                                        SizedBox(width: 4.w),
                                        Flexible(
                                          child: CustomText(
                                            text: '${user.city}, ' ?? "N/A",
                                            color: Colors.white,
                                            maxLine: 2,
                                            textAlign: TextAlign.start,
                                            textOverflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Flexible(
                                          child: CustomText(
                                            text: user.country ?? "N/A",
                                            color: Colors.white,
                                            maxLine: 2,
                                            textAlign: TextAlign.start,
                                            textOverflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.h),
                                    //========================> Friend Love Info Button Row <=======================
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //========================> Add Friend Button  <=======================
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () {
                                              if(user.id != null){
                                                messageController.createConversation(user.id!, isAddFriend: true);
                                              }
                                              else{
                                                Fluttertoast.showToast(msg: "Something went wrong!");
                                              }
                                            },
                                            child: _slideButton(
                                                SvgPicture.asset(
                                                    AppIcons.friendsAdd),
                                                Colors.red),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        //========================> Love Button <=======================
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () {
                                              _handleLikeDislike(true);
                                              _homeController
                                                  .postUserData('$user.id');
                                            },
                                            child: _slideButton(
                                                SvgPicture.asset(
                                                    AppIcons.loves),
                                                const Color(0xffFF9D33)),
                                          ),
                                        ),
                                        /*SizedBox(width: 8.w),
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () {
                                              if(user.id != null){
                                                messageController.createConversation(user.id!);
                                              }
                                              else{
                                                Fluttertoast.showToast(msg: "Something went wrong!");
                                              }
                                            },
                                            child: _slideButton(
                                                SvgPicture.asset(AppIcons.sms),
                                                Colors.red),
                                          ),
                                        ),*/
                                        SizedBox(width: 8.w),
                                        //========================>  Info Button <=======================
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  AppRoutes
                                                      .profileDetailsScreen,
                                                  parameters: {
                                                    'profileId': user.id ?? '',
                                                    'age': '${user.age ?? ''}',
                                                  });
                                            },
                                            child: _slideButton(
                                                SvgPicture.asset(AppIcons.info),
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
                        }),
                        onForward: (index, info) =>
                            _onSwipe(info.direction, index),
                        onEnd: () => setState(() => _allSwiped = false),
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

//==========================> Slide Button <==================
  _slideButton(Widget icon, Color borderColor) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1.w, color: borderColor),
          color: Colors.white),
      child: Padding(padding: EdgeInsets.all(8.w), child: icon),
    );
  }
}
