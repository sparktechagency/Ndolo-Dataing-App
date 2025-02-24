/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/views/base/custom_network_image.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_text.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(2),
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.message.tr,
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.chatScreen);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            //=====================> Image <=======================
                            CustomNetworkImage(
                              imageUrl:
                              'https://s3-alpha-sig.figma.com/img/a1c9/575c/4f24b44129bd1c1832d68d397b792497?Expires=1735516800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=gApV0GgAScr~HmAV30lTtGq6BCRcp7zXc4yxQ3KC4wfdZsWZ3jW4~e9az0FVvntpJnwhLbDi3LuFjoaVruQH2hGvaRs2P7-nqKgswWdSvUlnZ9~HTp~6AN11Z8O4KaVY5NUnTrPEJ7Qj6ywAfkHO6aB6LLjlbfNG7RuYLIEGUEBJ5mHVNfVpa9xwonMeMCAWv2tCQLqqFhFn4YqZqe4eNphtaZGWV3GwTPHfIimceEhMzZYAYSUAYXmkjPQks2qH59XsQ-yn40ag40WRGMZpMP~hKWR1moDqleylqfTM7oAU0MoEqiQGtssCfJEgN8vw4DHlC-CNhbwm~QXu-fXxaA__',
                              height: 45.h,
                              width: 45.w,
                              boxShape: BoxShape.circle,
                            ),
                            //=====================> Active Green Icon <=======================
                            Positioned(
                              right: 0.w,
                              bottom: 4.h,
                              child: Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 10.w,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //=====================> Name <=======================
                              CustomText(
                                text: 'Rida Anam',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                bottom: 6.h,
                                maxLine: 2,
                                textAlign: TextAlign.start,
                              ),
                              //=====================> Last Message <=======================
                              CustomText(
                                text: 'Hello, are you here?',
                                fontWeight: FontWeight.w500,
                                maxLine: 2,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/service/api_constants.dart';
import 'package:ndolo_dating/utils/app_constants.dart';
import 'package:ndolo_dating/views/base/custom_network_image.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import '../../../controllers/messages/message_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_text.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final MessageController controller = Get.put(MessageController());
  var currentUserId='';

  @override
  Widget build(BuildContext context) {
    controller.getConversation();
    return Scaffold(
      bottomNavigationBar: const BottomMenu(2),
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.message.tr,
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Obx(() {
          if (controller.conversationLoading.value) {
            return const Center(child: CustomPageLoading());
          }
          if (controller.conversationModel.isEmpty) {
            return Center(child: CustomText(text: 'No conversations available.'));
          }
          return ListView.builder(
            itemCount: controller.conversationModel.length,
            itemBuilder: (context, index) {
              final conversation = controller.conversationModel[index];
              bool isCurrentUserSender = conversation.sender!.id == currentUserId;
              String displayName = isCurrentUserSender
                  ? conversation.receiver!.fullName!
                  : conversation.sender!.fullName!;
              String displayImage = isCurrentUserSender
                  ? conversation.receiver!.profileImage!
                  : conversation.sender!.profileImage!;
              String conversationId = conversation.id!;
              String receiverId = isCurrentUserSender
                  ? conversation.receiver!.id!
                  : conversation.sender!.id!;
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.chatScreen, parameters: {
                      'conversationId': conversation.id ?? '',
                      'currentUserId': currentUserId ?? '',
                      'receiverId': receiverId ?? '',
                      'currentUserImage': isCurrentUserSender ? conversation.sender!.profileImage! : conversation.receiver!.profileImage!,
                      'receiverImage': displayImage ?? '',
                      'receiverName': displayName ?? '',
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                      child: Row(
                        children: [
                          CustomNetworkImage(
                            imageUrl: '${ApiConstants.imageBaseUrl}$displayImage',
                            height: 45.h,
                            width: 45.w,
                            boxShape: BoxShape.circle,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //=====================> Name <=======================
                                CustomText(
                                  text: displayName,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  bottom: 6.h,
                                  maxLine: 2,
                                  textAlign: TextAlign.start,
                                ),
                                //=====================> Last Message <=======================
                                CustomText(
                                  text: conversation.lastMessage is Map<String, dynamic>
                                      ? (conversation.lastMessage['text'] ?? 'No message available')
                                      : (conversation.lastMessage?.text ?? 'No message available'),
                                  fontWeight: FontWeight.w500,
                                  maxLine: 2,
                                  textAlign: TextAlign.start,
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

