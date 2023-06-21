import 'package:location/location.dart';

Location location = Location();
late PermissionStatus permissionStatus;
bool serviceEnabled = false;
LocationData? locationData;

Future<bool> isPermissionGranted() async {
  permissionStatus = await location.hasPermission();
  if (permissionStatus == PermissionStatus.denied) {
    permissionStatus = await location.requestPermission();
  }
  return permissionStatus == PermissionStatus.granted;
}