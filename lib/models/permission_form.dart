import 'package:latlong/latlong.dart';

class PermissionForm {
  final DateTime expiryTime;
  final LatLng location;
  final int pNum;
  PermissionForm({this.expiryTime, this.location, this.pNum = 1});
}
