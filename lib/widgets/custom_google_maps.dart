import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initalCameraPosition;
  Set<Marker> markers = {};

  @override
  void initState() {
    initalCameraPosition = const CameraPosition(
      zoom: 10,
      target: LatLng(
        31.220114979528947,
        29.9469790891334,
      ),
    );
    initMarkers();
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
    return Stack(
      children: [
        GoogleMap(
          markers: markers,
          onMapCreated: (controller) {
            googleMapController = controller;
            initMapStyle();
          },
          // cameraTargetBounds: CameraTargetBounds(
          //   LatLngBounds(
          //     southwest: const LatLng(31.105385543562797, 29.757157660194444),
          //     northeast: const LatLng(31.30889527805763, 30.079535442825954),
          //   ),
          // ),
          initialCameraPosition: initalCameraPosition,
        ),
        Positioned(
          bottom: 100,
          right: 8,
          child: IconButton(
            onPressed: () {
              googleMapController.animateCamera(
                CameraUpdate.newLatLngZoom(
                    const LatLng(30.702901685192735, 30.171399543883684), 10),
              );
            },
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white),
            ),
            icon: const Icon(
              Icons.my_location,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context).loadString('assets/map_styles/night_map_style.json');
    googleMapController.setMapStyle(nightMapStyle);
  }

  void initMarkers() {
    var myMarker = Marker(markerId: MarkerId('1'), position: LatLng(30.702901685192735, 30.171399543883684));
    markers.add(myMarker);
  }
}
