import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initalCameraPosition;

  @override
  void initState() {
    initalCameraPosition = const CameraPosition(
      zoom: 11,
      target: LatLng(
        31.220114979528947,
        29.9469790891334,
      ),
    );
    super.initState();
  }
  late GoogleMapController googleMapController;

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
        googleMapController = controller;
      },
      // cameraTargetBounds: CameraTargetBounds(
      //   LatLngBounds(
      //     southwest: const LatLng(31.105385543562797, 29.757157660194444),
      //     northeast: const LatLng(31.30889527805763, 30.079535442825954),
      //   ),
      // ),
      initialCameraPosition: initalCameraPosition,
    );
  }
}
