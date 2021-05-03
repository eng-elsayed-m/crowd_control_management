import 'dart:async';
import 'dart:convert';
import 'package:crowd_control_management/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  User _user;

  String get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate.isAfter(DateTime.now())) return _token;
    return null;
  }

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  User get user {
    return _user;
  }

  Future<void> _authentication(
      String email, String password, String urlSeg) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSeg?key=AIzaSyB1CeEEtPuZ2NoieT8vC7TZ7tMGJ1HJefc");
    try {
      final response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData["error"]["message"]);
      }
      _token = responseData["idToken"];
      _userId = responseData["localId"];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData["expiresIn"])));
      autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        "token": _token,
        "userId": _userId,
        "expiryDate": _expiryDate.toIso8601String(),
      });
      prefs.setString("userData", userData);
    } catch (e) {
      throw e;
    }
  }

  Future<void> _getUserData() async {
    final url = Uri.parse(
        "https://crowd-control-management-default-rtdb.firebaseio.com//users/$_userId.json?auth=$_token");
    try {
      final userRes = await http.get(url);
      final userResData = json.decode(userRes.body) as Map<String, dynamic>;
      if (userResData == null) {
        return;
      }
      final newUser = User(
        name: userResData["name"],
        phone: userResData["phone"],
        pId: userResData["pId"],
        bDate: DateTime.parse(userResData["bDate"]),
        blood: userResData["blood"],
      );
      _user = newUser;
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> _createUser(String name, String phone, String pId,
      DateTime bDate, String blood) async {
    final url = Uri.parse(
        "https://crowd-control-management-default-rtdb.firebaseio.com//users/$_userId.json?auth=$_token");
    try {
      await http.put(url,
          body: json.encode({
            "name": name,
            "phone": phone,
            "pId": pId,
            "bDate": bDate.toIso8601String().split(" ").first,
            "blood": blood,
          }));
      final newUser =
          User(bDate: bDate, blood: blood, name: name, pId: pId, phone: phone);
      _user = newUser;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUp(String email, String password, String name, String phone,
      String pId, DateTime bDate, String blood) async {
    await _authentication(email, password, "signUp");
    return _createUser(name, phone, pId, bDate, blood);
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    await _authentication(email, password, "signInWithPassword");
    return _getUserData();
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) return false;
    final extractedData =
        json.decode(prefs.getString("userData")) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedData["expiryDate"]);
    if (expiryDate.isBefore(DateTime.now())) return false;
    _token = extractedData["token"];
    _userId = extractedData["userId"];
    _expiryDate = expiryDate;
    _getUserData();
    notifyListeners();
    autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    _user = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> autoLogout() async {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpire = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpire), logout);
  }
}
