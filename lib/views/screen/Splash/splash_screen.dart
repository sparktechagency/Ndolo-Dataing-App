import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/utils/app_icons.dart';
import '../../../helpers/prefs_helpers.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () async {
      var isLogged = await PrefsHelper.getBool(AppConstants.isLogged);
      if (isLogged == true) {
        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        Get.offAllNamed(AppRoutes.onboardingScreen);
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(AppIcons.appLogo),
      ),
    );
  }
}
