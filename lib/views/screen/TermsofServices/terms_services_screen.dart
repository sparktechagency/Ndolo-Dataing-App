import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/controllers/settings_controller.dart';
import 'package:ndolo_dating/views/base/custom_page_loading.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';

class TermsServicesScreen extends StatelessWidget {
  TermsServicesScreen({super.key});
  final SettingController _settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    _settingController.getTermsCondition();
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.termsOfServices.tr),
      body: Obx(
        () => _settingController.termsConditionLoading.value
            ? const Center(
                child: CustomPageLoading(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: Column(
                    children: [
                      Obx(
                        () => Html(
                            shrinkWrap: true,
                            data: _settingController.termContent.value),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
