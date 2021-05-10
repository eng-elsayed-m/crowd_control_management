import 'package:flutter/material.dart';

import '../app_localizations.dart';

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
    final trans = AppLocalizations.of(context).translate;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home,
            size: 150,
            color: Colors.cyan[200],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text(
              trans("Safety message"),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context).pushNamed("mypermission-screen"),
            child: Text(trans("Request a permit")),
            style: _buttonStyle,
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context).pushNamed("otherpermission-screen"),
            child: Text(trans("Request other permit")),
            style: _buttonStyle,
          )
        ],
      ),
    );
  }
}
