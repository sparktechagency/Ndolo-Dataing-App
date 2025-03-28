import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../controllers/location_controller.dart';
import '../../base/custom_button.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();
  final LocationController _commonLocationController = Get.put(LocationController());

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(41.311158, 69.279737),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
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
                content: const Text('Please enable location services to use this feature.'),
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

        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        final newPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.4746,
        );
        if (mounted) {
          setState(() {
            cameraPosition = newPosition;
          });
        }

        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(newPosition));

        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (mounted) {
          setState(() {
            _commonLocationController.locationNameController.text = placemarks.isNotEmpty
                ? '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}'
                : 'Unknown Location';
          });
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
  }

  Future<void> _handleTapOnMap(LatLng tappedPosition) async {
    final GoogleMapController controller = await _controller.future;
    cameraPosition = CameraPosition(target: tappedPosition, zoom: 14.4746);
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    mapPickerController.mapMoving!();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      tappedPosition.latitude,
      tappedPosition.longitude,
    );
    final place = placemarks.isNotEmpty ? placemarks.first : null;
    final formattedAddress = place != null
        ? '${place.street}, ${place.locality}, ${place.subLocality}, ${place.administrativeArea}, ${place.country}'
        : 'Unknown Location';
    _commonLocationController.locationNameController.text = formattedAddress;
    mapPickerController.mapFinishedMoving!();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapPicker(
            iconWidget: SvgPicture.asset(
              "assets/icons/plus.svg",
              height: 60,
            ),
            mapPickerController: mapPickerController,
            child: GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: _handleTapOnMap,
              onCameraMoveStarted: () {
                mapPickerController.mapMoving!();
                _commonLocationController.locationNameController.text = "checking ...";
              },
              onCameraMove: (newCameraPosition) {
                cameraPosition = newCameraPosition;
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top + 20,
            width: MediaQuery.of(context).size.width - 50,
            height: 60,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                maxLines: 3,
                textAlign: TextAlign.center,
                readOnly: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  border: InputBorder.none,
                ),
                controller: _commonLocationController.locationNameController,
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: CustomButton(
              loading: _commonLocationController.setLocationLoading.value,
              onTap: () {
                _commonLocationController.submitPickedLocation(
                  lat: cameraPosition.target.latitude,
                  lng: cameraPosition.target.longitude,
                  locationName: _commonLocationController.locationNameController.text,
                );
              },
              text: "Submit",
            ),
          )
        ],
      ),
    );
  }
}
