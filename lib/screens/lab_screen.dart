import '../app_localizations.dart';
import 'package:flutter/material.dart';

class LabScreen extends StatelessWidget {
  static const navN = "lab-screen";

  @override
  Widget build(BuildContext context) {
    final trans = AppLocalizations.of(context).translate;
    return Scaffold(
      appBar: AppBar(
        title: Text(trans("Analytics Lab")),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  color: Theme.of(context).primaryColorLight,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      trans("Note"),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                    elevation: 8,
                    color: Colors.cyan[100],
                    child: ListTile(
                      leading: ElevatedButton(
                          onPressed: () {}, child: Text(trans("Book"))),
                      trailing: Text("Request examination"),
                    )),
                Card(
                    elevation: 8,
                    color: Colors.cyan[100],
                    child: ListTile(
                      leading: ElevatedButton(
                          onPressed: () {}, child: Text(trans("Get"))),
                      trailing: Text(trans("Receive analysis result")),
                    )),
              ],
            ),
          ),
          Expanded(
              child: Center(
            child: Image.asset(
              "assets/images/ccm_logo.png",
              fit: BoxFit.contain,
            ),
          ))
        ],
      ),
    );
  }
}
