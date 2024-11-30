import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ndolo_dating/views/base/custom_network_image.dart';

class CustomTinderCard extends StatelessWidget {
  final String imageUrl;
  final int index;

  const CustomTinderCard({
    super.key,
    required this.imageUrl,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 465.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: CustomNetworkImage(
            imageUrl: imageUrl,
            height: 465.h,
            width: double.infinity)
        ),
      ),
    );
  }
}
