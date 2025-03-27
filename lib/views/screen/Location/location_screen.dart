import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/utils/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../controllers/location_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../../helpers/prefs_helpers.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final LocationController _commonLocationController = Get.put(LocationController());

  var currentLat = 0.0;
  var currentLong = 0.0;

  @override
  void initState() {
    //_getCurrentLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.location.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Set Location'.tr,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              bottom: 141.h,
            ),
            //==========================> Location Image <=========================
            Center(
                child: Image.asset(AppImages.map, width: 165.w, height: 165.h)),
            const Spacer(),
            //==========================> User Current Location Button <=========================
            CustomButton(
                loading: _commonLocationController.setLocationLoading.value,
                onTap: () {
                  _commonLocationController.setLocation();
                   /* latitude: currentLat.toString(),
                    longitude: currentLong.toString());*/
                },
                text: 'User Current Location'.tr),
            SizedBox(height: 16.h),
            //==========================> Set From Map Button <=========================
            CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.locationPickerScreen);
              },
              color: Colors.transparent,
              text: 'Set From Map'.tr,
              textColor: AppColors.primaryColor,
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  /*Future<void> _getCurrentLocation() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      try {
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          if (mounted) {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Location Services Disabled'),
                content: const Text(
                    'Please enable location services to use this feature.'),
                actions: [
                  TextButton(
                    child: const Text('Open Settings'),
                    onPressed: () {
                      Geolocator.openLocationSettings();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          }
          return;
        }

        // Get current position
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          currentLat = position.latitude;
          currentLong = position.longitude;
        });

        // Get address details
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          String locationCountry = place.country ?? "";
          String locationState = place.administrativeArea ?? "";
          String locationCity = place.locality ?? "";
          String locationAddress = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
          if (mounted) {
            setState(() {
              _commonLocationController.locationNameController.text =
                  locationAddress;
            });
            await PrefsHelper.setString(AppConstants.userCountry, locationCountry);
            await PrefsHelper.setString(AppConstants.userState, locationState);
            await PrefsHelper.setString(AppConstants.userCity, locationCity);
            await PrefsHelper.setString(AppConstants.userAddress, locationAddress);
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error getting location: $e')),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied')),
        );
      }
    }
  }*/

}
