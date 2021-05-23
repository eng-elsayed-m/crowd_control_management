import 'dart:async';
import 'dart:convert';
import 'package:crowd_control_management/models/permission_form.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  bool get isPermoted {
    return _permission != null;
  }

  Future<void> createPermission(PermissionForm perData) async {
    final url = Uri.parse(
        "https://crowd-control-management-default-rtdb.firebaseio.com//permissions/$userId.json?auth=$authToken");
    try {
      await http.put(url,
          body: json.encode({
            "lati": perData.location.latitude,
            "long": perData.location.longitude,
            "pnum": perData.pNum,
            "expiryTime": perData.expiryTime.toIso8601String(),
            // DateTime.now().add(Duration(hours: 4)).toIso8601String(),
          }));
      _permission = perData;
      autoTiming();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final permData = json.encode({
        "lati": perData.location.latitude,
        "long": perData.location.longitude,
        "pnum": perData.pNum,
        "expiryTime": perData.expiryTime.toIso8601String(),
      });
      prefs.setString("permission", permData);
    } catch (e) {
      throw e;
    }
  }

  Future<bool> autoCheck() async {
    print("auto check");
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("permission")) {
      print("404");
      return false;
    }
    final extractedData =
        json.decode(prefs.getString("permission")) as Map<String, Object>;
    final expiryTime = DateTime.parse(extractedData["expiryTime"]);
    if (expiryTime.isBefore(DateTime.now())) {
      print("cancelled");
      return false;
    }

    final newPer = PermissionForm(
        location: LatLng(double.parse(extractedData["lati"]),
            double.parse(extractedData["long"])),
        expiryTime: expiryTime,
        pNum: int.parse(extractedData["pnum"]));
    _permission = newPer;
    notifyListeners();
    autoTiming();
    return true;
  }

  Future<void> endPermission() async {
    print("end Permission");
    _permission = null;
    final url = Uri.parse(
        "https://crowd-control-management-default-rtdb.firebaseio.com//permissions/$userId.json?auth=$authToken");
    http.delete(url);
    if (_permissionTimer != null) {
      _permissionTimer.cancel();
      _permissionTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> autoTiming() async {
    if (_permissionTimer != null) {
      _permissionTimer.cancel();
    }
    final timeToExpire =
        _permission.expiryTime.difference(DateTime.now()).inSeconds;
    _permissionTimer = Timer(Duration(seconds: timeToExpire), endPermission);
  }
}
