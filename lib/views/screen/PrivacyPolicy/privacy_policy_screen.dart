import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/controllers/settings_controller.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});
  final SettingController _settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    _settingController.getPrivacy();
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.privacyPolicy.tr),
      body: Obx(
        () => _settingController.getPrivacyLoading.value
            ? const Center(child: CustomPageLoading())
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: Column(
                    children: [
                      Obx(
                        () => Html(
                            shrinkWrap: true,
                            data: _settingController.privacyContent.value),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
