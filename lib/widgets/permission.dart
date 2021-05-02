import 'package:flutter/material.dart';

class PermissionWidget extends StatelessWidget {
  final _buttonStyle = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.lightBlueAccent))),
      minimumSize: MaterialStateProperty.all(
        Size(230, 30),
      ));
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home,
            size: 150,
            color: Colors.cyan[200],
          ),
          Flexible(
              child: Text(
            "لان سلامتكم تهمنا لا ينصح بمغادرة المنزل الا للضروره القصوى خلال فترة الحظر",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )),
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context).pushNamed("mypermission-screen"),
            child: Text("طلب تصريح"),
            style: _buttonStyle,
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context).pushNamed("otherpermission-screen"),
            child: Text("طلب تصريح للغير"),
            style: _buttonStyle,
          )
        ],
      ),
    );
  }
}
