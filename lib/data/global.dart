import 'package:latlong2/latlong.dart';

Map<String, LatLng> busStops = {
  'ENT': LatLng(1.332959, 103.777306),
  'B23': LatLng(1.333801, 103.775738),
  'SPH': LatLng(1.335110, 103.775464),
  'SIT': LatLng(1.334510, 103.774504),
  'B44': LatLng(1.3329522845882348, 103.77145520892851),
  'B37': LatLng(1.332797, 103.773304),
  'MAP': LatLng(1.332473, 103.774377),
  'HSC': LatLng(1.330028, 103.774623),
  'LCT': LatLng(1.330895, 103.774870),
  'B72': LatLng(1.3314596165361228, 103.7761976140868),
};

DateTime? time_now;
int startEveningService = 12;
int startAfternoonService = 9;//
int selectedMRT = 0;
int busIndex = 0;
