import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({required this.id, required this.name, required this.latLng});
}

List<PlaceModel> places = [
  PlaceModel(id: 1, name: 'Green Plaza Inn', latLng: LatLng(31.20647392379963, 29.963803849449537)),
  PlaceModel(id: 2, name: 'المركز الأوليمبي للقوات المسلحة', latLng: LatLng(31.206672360334696, 29.952781277132555)),
  PlaceModel(id: 3, name: 'Hospital', latLng: LatLng(31.200712813189746, 29.95115495554996)),
  PlaceModel(id: 4, name: 'Ras Soda Temple', latLng: LatLng(31.203374298672102, 29.918813312437376)),
  PlaceModel(id: 5, name: 'صيدلية حليم', latLng: LatLng(31.167367264699273, 29.87792712905318)),
];