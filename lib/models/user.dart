import 'package:flutter/cupertino.dart';

class User {
  final String name;
  final String phone;
  final String pId;
  final DateTime bDate;
  final String blood;

  User(
      {@required this.name,
      @required this.phone,
      @required this.pId,
      @required this.bDate,
      @required this.blood});
}
