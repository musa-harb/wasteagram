import 'package:location/location.dart';
import 'package:flutter/services.dart';

var locationService = Location();

Future retrievePostLocation() async {
  try {
    var _serviceEnabled = await locationService.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationService.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    
    var _permissionGranted = await locationService.hasPermission();   
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    return await locationService.getLocation();
  } on PlatformException catch (e) {
    print('Error: ${e.toString()}, code: ${e.code}');
    return null;
  }
}
