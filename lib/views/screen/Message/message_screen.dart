import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/service/api_constants.dart';
import 'package:ndolo_dating/utils/app_constants.dart';
import 'package:ndolo_dating/views/base/custom_network_image.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import '../../../controllers/messages/message_controller.dart';
import '../../../service/socket_services.dart';
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
  final SocketServices _socket = SocketServices();
  var currentUserId ='';

  @override
  void initState() {
    super.initState();
    controller.getConversation();
    _socket.init();
  }

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
        child: Obx(() {
          if (controller.conversationLoading.value) {
            return const Center(child: CustomPageLoading());
          }
          if (controller.conversationModel.isEmpty) {
            return Center(child: CustomText(text: 'No conversations found'.tr));
          }
          return ListView.builder(
            itemCount: controller.conversationModel.length,
            itemBuilder: (context, index) {
              final conversation = controller.conversationModel[index];
              String conversationId = conversation.id ?? '';
          //    bool isCurrentUser = conversation.resiver!.id == currentUserId;
              String displayName = conversation.resiver?.fullName ?? 'Unknown';
              String displayImage = conversation.resiver?.profileImage ?? '';
              String receiverId =  conversation.resiver!.id!;

              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.chatScreen, parameters: {
                      "conversationId": conversationId,
                      "currentUserId": currentUserId,
                      "receiverId": receiverId,
                      "receiverImage": displayImage,
                      "receiverName": displayName,
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
                                  text:  displayName,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  bottom: 6.h,
                                  maxLine: 2,
                                  textAlign: TextAlign.start,
                                ),
                                //=====================> Last Message <=======================
                                CustomText(
                                  text: (conversation.lastMessage?.type == 'image')
                                      ? 'An image'
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

