import 'package:flutter/material.dart';
import 'package:google_maps_app/models/place_model.dart';
import 'package:google_maps_app/utils/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initalCameraPosition;
  late LocationService locationService;
  Set<Marker> markers = {};

  @override
  void initState() {
    initalCameraPosition = const CameraPosition(
      zoom: 12,
      target: LatLng(
        31.220114979528947,
        29.9469790891334,
      ),
    );
    locationService = LocationService();
    updateMyLocation();
    initMarkers();
    super.initState();
  }

  GoogleMapController? googleMapController;

  @override
  void dispose() {
    googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
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
              googleMapController!.animateCamera(
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
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night_map_style.json');
    googleMapController!.setMapStyle(nightMapStyle);
  }

  // Future<Uint8List> getImageFromRowData(String image, double width) async {
  //   var imageData = await rootBundle.load(image);
  //   var imageCodec = await ui.instantiateImageCodec(
  //       imageData.buffer.asUint8List(),
  //       targetWidth: width.round());
  //   var imageFrameInfo = await imageCodec.getNextFrame();
  //   var imageByteData =
  //       await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);
  //   return imageByteData!.buffer.asUint8List();
  // }

  void initMarkers() async {
    var customMarkerIcon = await BitmapDescriptor.asset(
        const ImageConfiguration(), 'assets/images/location2.png');
    var myMarkers = places
        .map(
          (placeModel) => Marker(
            icon: customMarkerIcon,
            infoWindow:
                InfoWindow(title: placeModel.name, snippet: placeModel.name),
            position: placeModel.latLng,
            markerId: MarkerId(
              placeModel.id.toString(),
            ),
          ),
        )
        .toSet();

    markers.addAll(myMarkers);
    setState(() {});
  }

  void updateMyLocation() async {
    await locationService.checkAndRequestLocationService();
    var hasPermission = await locationService.checkAndRequestLocationPermission();

    if (hasPermission) {
      locationService.getRealTimeLocationData((locationData) async {
        var myLatitudeData = locationData.latitude!;
        var myLongtitudeData = locationData.longitude!;
        var customMarkerIcon = await BitmapDescriptor.asset(
            const ImageConfiguration(), 'assets/images/location2.png');
        setMyLocationMarker(myLatitudeData, myLongtitudeData, customMarkerIcon);
        setMyCameraPosition(myLatitudeData, myLongtitudeData);
      });
    } else {}
  }

  void setMyCameraPosition(double myLatitudeData, double myLongtitudeData) {
    var cameraPosition = CameraPosition(
      zoom: 12,
      target: LatLng(myLatitudeData, myLongtitudeData),
    );
    googleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void setMyLocationMarker(double myLatitudeData, double myLongtitudeData, AssetMapBitmap customMarkerIcon) {
    var myLocationMarker = Marker(
      markerId: const MarkerId('my_location_marker'),
      position: LatLng(myLatitudeData, myLongtitudeData),
      icon: customMarkerIcon,
    );
    markers.add(myLocationMarker);
    setState(() {});
  }

// void initPolygons() {
//   Polygon polygon = Polygon(
//     strokeWidth: 2,
//     fillColor: Colors.black.withOpacity(0.5),
//     polygonId: const PolygonId('1'),
//     points: const [
//       LatLng(31.23979356459674, 29.96030947711117),
//       LatLng(31.188437653678555, 30.00781915870694),
//       LatLng(31.16926746229133, 29.93096930030577),
//     ],
//   );
//   polygons.add(polygon);
// }
}
