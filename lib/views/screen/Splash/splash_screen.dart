import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/utils/app_icons.dart';

import '../../../helpers/route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
/*  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),(){
      Get.offAllNamed(AppRoutes.homeScreen);
    });
    // TODO: implement initState
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(AppIcons.appLogo),
      ),
    );
  }
}
