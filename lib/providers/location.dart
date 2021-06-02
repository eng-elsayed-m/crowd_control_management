import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationP with ChangeNotifier {
  LatLng _location;
  String _address = "Your current location ,is loading...";
  LatLng get location {
    return _location;
  }

  String get address {
    return _address;
  }

  Future<void> getCurrentLocation() async {
    if (!(_location == null)) return null;
    bool _serviceEnabled;
    LocationPermission _permissionGranted;

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!_serviceEnabled) {
        return null;
      }
    }
    _permissionGranted = await Geolocator.checkPermission();
    if (_permissionGranted == LocationPermission.denied) {
      _permissionGranted = await Geolocator.requestPermission();
      if (_permissionGranted != LocationPermission.whileInUse) {
        return null;
      }
    }
    final userlocation = await Geolocator.getCurrentPosition();
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
