// ignore_for_file: unnecessary_null_comparison

import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import 'map_location.dart';


void launchMapDirections(double destinationLatitude, double destinationLongitude) async {
  LocationData? currentLocation = await getCurrentLocation();
  if (currentLocation != null) {
    double userLatitude = currentLocation.latitude!;
    double userLongitude = currentLocation.longitude!;
    
    if (destinationLongitude != null) {
      String url = 'https://www.google.com/maps/dir/?api=1&origin=$userLatitude,$userLongitude&destination=$destinationLatitude,$destinationLongitude';
     
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } else {
      // Handle case when destination coordinates are not available
    }
  } else {
    // Handle case when user location is not available
  }
}


  