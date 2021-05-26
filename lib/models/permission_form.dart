import 'package:latlong/latlong.dart';

class PermissionForm {
  final DateTime expiryTime;
  final LatLng location;
  final int pNum;
  final String type;
  PermissionForm({this.expiryTime, this.location, this.pNum = 1, this.type});
}
