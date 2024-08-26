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
    initalCameraPosition = const CameraPosition(target: LatLng(31.06859493521881, 30.432485901908848));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GoogleMap(initialCameraPosition: initalCameraPosition);
  }
}
