import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationP with ChangeNotifier {
  LatLng _location;
  String _address = "Your current location , Loading ...";
  LatLng get location {
    return _location;
  }

  String get address {
    return _address;
  }

  Future<void> getCurrentLocation() async {
    if (!(_location == null)) return null;
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    Location loc = Location();
    _serviceEnabled = await loc.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await loc.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }
    _permissionGranted = await loc.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await loc.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    final userlocation = await loc.getLocation();
    _location = LatLng(userlocation.latitude, userlocation.longitude);
    notifyListeners();
    getAddress();
  }

  Future<void> getAddress() async {
    final url = Uri.parse(
        "https://nominatim.openstreetmap.org/reverse.php?lat=${_location.latitude}&lon=${_location.longitude}&zoom=10&format=jsonv2");

    final res = await http.get(url);
    if (res.statusCode >= 400) {
      return;
    }
    final extractedData = json.decode(res.body) as Map<String, dynamic>;
    _address = extractedData["display_name"].toString();
    notifyListeners();
    print(_address);
  }
}
