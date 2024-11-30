import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_images.dart';
import '../../base/custom_loading.dart';
import '../../base/custom_network_image.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final StreamController _streamController = StreamController();
  final ScrollController _scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  Uint8List? _image;
  File? selectedIMage;

  List<Map<String, String>> messageList = [
    {
      "name": "Alice",
      "status": "sender",
      "message": "Hey there!",
      "image": AppImages.woman
    },
    {
      "name": "Bob",
      "status": "receiver",
      "message": "Hi, what's up?",
      "image": AppImages.woman
    },
    {
      "name": "Charlie",
      "status": "sender",
      "message": "Just checking in.",
      "image": AppImages.woman
    },
    {
      "name": "David",
      "status": "receiver",
      "message": "Everything's good here, thanks!",
      "image": AppImages.woman
    },
    {
      "name": "Eve",
      "status": "sender",
      "message": "Cool.",
      "image": AppImages.woman
    },
    {
      "name": "Frank",
      "status": "receiver",
      "message": "Did you see the latest update?",
      "image": AppImages.woman
    },
    {
      "name": "Alice",
      "status": "sender",
      "message": "Hey there!",
      "image": AppImages.woman
    },
    {
      "name": "Bob",
      "status": "receiver",
      "message": "Hi, what's up?",
      "image": AppImages.woman
    },
    {
      "name": "Charlie",
      "status": "sender",
      "message": "Just checking in.",
      "image": AppImages.woman
    },
    {
      "name": "David",
      "status": "receiver",
      "message": "Everything's good here, thanks!",
      "image": AppImages.woman
    },
    {
      "name": "Eve",
      "status": "sender",
      "message": "Cool.",
      "image": AppImages.woman
    },
    {
      "name": "Frank",
      "status": "receiver",
      "message": "Did you see the latest update?",
      "image": AppImages.woman
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      // If you want a smooth scroll animation instead of jumping directly, use animateTo:
      // _scrollController.animateTo(
      //   _scrollController.position.maxScrollExtent,
      //   duration: Duration(milliseconds: 300),
      //   curve: Curves.easeOut,
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      //========================================> AppBar Section <=======================================
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                //=====================> Image <=======================
                CustomNetworkImage(
                  imageUrl:
                      'https://s3-alpha-sig.figma.com/img/a1c9/575c/4f24b44129bd1c1832d68d397b792497?Expires=1733702400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=GwEsZ3WRA~UZBXPSyVn1~EP56OutWf9ks3Pp5SGI6MCjGGZAFlHEi2N4IlDVFviedcItZdtfZQtgWJHPudEZFWEcFDRzdXKF-VR8B1Sbr0xTBOs2pmjcEAJUy-mGNPoh0~QXEtajPrE9MKTiQrV2581Cm0gx8yNzIXLqrRy5xdqs6nyUprsgffdi~rkm3SylakKm40tW6mCca7fwwTduZ6hzxrjf1vsbiFdkl9ntcgMN89j3zasCaMxVOa9wueLCPiablbJiC1z5lO8nY5ensKpTa5AKMLg0pS6dIDBEst9u95IIhxLBaaheZC2JrOb6aAwBzMY2hq5R1IhXkaWpfg__',
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
                  CustomText(
                    text: 'Jane Cooper',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  CustomText(
                    text: 'Active 30 minutes ago',
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          //==============================> Audio Call Button <=======================
          InkWell(onTap: () {}, child: SvgPicture.asset(AppIcons.audio)),
          SizedBox(width: 16.w),
          //==============================> Video Call Button <=======================
          InkWell(onTap: () {}, child: SvgPicture.asset(AppIcons.video)),
          SizedBox(width: 24.w),
        ],
      ),
      //========================================> Body Section <=======================================
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      StreamBuilder(
                        stream: _streamController.stream,
                        builder: (context, snapshot) {
                          if (true) {
                            return ListView.builder(
                                controller: _scrollController,
                                dragStartBehavior: DragStartBehavior.down,
                                itemCount: messageList.length,
                                itemBuilder: (context, index) {
                                  var message = messageList[index];
                                  return message['status'] == "sender"
                                      ? senderBubble(context, message)
                                      : receiverBubble(context, message);
                                });
                          } else {
                            return const CustomLoading();
                          }
                        },
                      ),
                      //========================================> Show Select Image <============================
                      Positioned(
                          bottom: 0.h,
                          left: 0.w,
                          child: Column(
                            children: [
                              if (_image != null)
                                Stack(
                                  children: [
                                    Container(
                                      height: 120.h,
                                      width: 120.w,
                                      margin: EdgeInsets.only(bottom: 10.h),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: MemoryImage(_image!),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        //border: Border.all(color: AppColors.primaryColor),
                                      ),
                                    ),
                                    //========================================> Cancel Icon <============================
                                    Positioned(
                                        top: 0.h,
                                        left: 0.w,
                                        child: GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: const Icon(
                                                Icons.cancel_outlined)))
                                  ],
                                ),
                            ],
                          ))
                    ],
                  ),
                ),
                //===============================================> Write Sms Section <=============================
                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 295.w,
                child: CustomTextField(
                  controller: messageController,
                  hintText: "Type something…",
                  suffixIcons: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    child: GestureDetector(
                        onTap: () {
                          openGallery();
                        },
                        child: SvgPicture.asset(AppIcons.attach,
                            color: AppColors.greyColor)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Map<String, String> newMessage = {
                    "name": "John",
                    "status": "sender",
                    "message": messageController.text,
                    "image": AppImages.woman,
                  };
                  if (messageController.text.isNotEmpty) {
                    messageList.add(newMessage);
                    _streamController.sink.add(messageList);
                    print(messageList);
                    messageController.clear();
                    _image = null; // Clear the selected image after sending
                  }
                  setState(() {});
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor, shape: BoxShape.circle),
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: SvgPicture.asset(
                        AppIcons.sendIcon,
                        color: Colors.white,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  //=============================================> Receiver Bubble <=================================
  receiverBubble(BuildContext context, Map<String, String> message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 38.h,
          width: 38.w,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            message['image']!,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
            backGroundColor: AppColors.cardColor,
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message['message'] ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'time',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //=============================================> Sender Bubble <========================================
  senderBubble(BuildContext context, Map<String, String> message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(
              type: BubbleType.sendBubble,
            ),
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            backGroundColor: AppColors.primaryColor,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message['message'] ?? "",
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'time',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          height: 38.h,
          width: 38.w,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            message['image']!,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  //==================================> Gallery <===============================
  Future openGallery() async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedIMage = File(pickImage!.path);
      _image = File(pickImage.path).readAsBytesSync();
    });
  }
/*Future _pickImageFromGallery() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    // Get.back();
  }*/
}
