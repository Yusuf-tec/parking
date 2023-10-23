import 'package:location/location.dart';



Future<LocationData?> getCurrentLocation() async {
  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return null;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  locationData = await location.getLocation();
  print("MY LOCATIONNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");
  print("MY LOCATIONNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN2");
  print(locationData);
  print(locationData.latitude);
  print(locationData.longitude);
  print("MY LOCATIONNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN3");
  return locationData;
}
