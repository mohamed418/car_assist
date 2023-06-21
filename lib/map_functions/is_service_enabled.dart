import 'package:location/location.dart';

import '../constants/components.dart';

Location location = Location();
late PermissionStatus permissionStatus;
bool serviceEnabled = false;
LocationData? locationData;

Future<bool> isServiceEnabled(context) async {
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    buildSnackBar('قم بتشغيل  اللوكيشن', context, 3);
  }
  return serviceEnabled;
}