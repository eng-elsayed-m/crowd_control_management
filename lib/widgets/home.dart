import 'package:flutter/material.dart';
import '../app_localizations.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trans = AppLocalizations.of(context).translate;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Card(
              elevation: 8,
              color: Colors.cyan[100],
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  size: 40,
                ),
                title: FittedBox(
                    fit: BoxFit.contain, child: Text(trans("Home address"))),
                trailing: ElevatedButton(
                    onPressed: () {}, child: Text(trans("Show results"))),
              )),
        ),
        Material(
          borderRadius: BorderRadius.circular(80),
          elevation: 8,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 10, color: Colors.red),
                borderRadius: BorderRadius.circular(80)),
            padding: EdgeInsets.symmetric(horizontal: 30),
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.red,
                  size: 100,
                ),
                Text(
                  trans("Not allow to move around"),
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
                Text(
                  trans("Have to request a permit"),
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
