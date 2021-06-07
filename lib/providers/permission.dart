import 'dart:async';
import 'dart:convert';
import 'package:crowd_control_management/models/permission_form.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;

class Permission with ChangeNotifier {
  final authToken;
  final String userId;
  Permission(this.authToken, this.userId);
  PermissionForm _permission;
  Timer _permissionTimer;
  PermissionForm get permission {
    return _permission;
  }

  Future<bool> createPermission(PermissionForm perData) async {
    final url = Uri.parse(
        "https://crowd-control-management-default-rtdb.firebaseio.com//permissions/$userId.json?auth=$authToken");
    bool _crowd = await checkPermissionsAround(perData.location);
    if (!_crowd) return false;
    try {
      await http.put(url,
          body: json.encode({
            "lati": perData.location.latitude,
            "long": perData.location.longitude,
            "pnum": perData.pNum,
            "expiryTime": perData.expiryTime.toIso8601String(),
            "type": perData.type
          }));
      _permission = perData;
      autoTiming();
      notifyListeners();
    } catch (e) {
      throw e;
    }
    return true;
  }

  Future<void> autoCheck() async {
    final url = Uri.parse(
        "https://crowd-control-management-default-rtdb.firebaseio.com//permissions/$userId.json?auth=$authToken");

    final res = await http.get(url);
    if (res.statusCode >= 400) return;
    final perData = json.decode(res.body) as Map<String, dynamic>;
    final expiryTime = DateTime.parse(perData["expiryTime"]);
    if (expiryTime.isBefore(DateTime.now())) return;
    final newPerm = PermissionForm(
        location: LatLng(perData["lati"], perData["long"]),
        expiryTime: expiryTime,
        pNum: perData["pnum"],
        type: perData["type"]);
    _permission = newPerm;
    autoTiming();
    notifyListeners();
  }

  Future<void> endPermission() async {
    print("end Permission");
    _permission = null;
    final url = Uri.parse(
        "https://crowd-control-management-default-rtdb.firebaseio.com//permissions/$userId.json?auth=$authToken");
    await http.delete(url);
    if (_permissionTimer != null) {
      _permissionTimer.cancel();
      _permissionTimer = null;
    }
    notifyListeners();
  }

  Future<void> autoTiming() async {
    if (_permissionTimer != null) {
      _permissionTimer.cancel();
    }
    final timeToExpire =
        _permission.expiryTime.difference(DateTime.now()).inSeconds;
    _permissionTimer = Timer(Duration(seconds: timeToExpire), endPermission);
  }

  Future<bool> checkPermissionsAround(LatLng center) async {
    final url = Uri.parse(
        "https://crowd-control-management-default-rtdb.firebaseio.com//permissions.json?auth=$authToken");
    final res = await http.get(url);
    if (res.statusCode >= 400) return false;
    final perData = json.decode(res.body) as Map<String, dynamic>;
    final List<LatLng> allPermissions = [];
    perData.forEach((key, value) {
      final _d = Geolocator.distanceBetween(
          center.latitude, center.longitude, value["lati"], value["long"]);
      if (_d < 500) {
        allPermissions.add(LatLng(value["lati"], value["long"]));
      }
    });
    return allPermissions.length < 7;
  }
}
