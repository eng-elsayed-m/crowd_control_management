import 'package:crowd_control_management/app_localizations.dart';
import 'package:flutter/material.dart';

class PartnersScreen extends StatelessWidget {
  static const navN = "partners-screen";
  @override
  Widget build(BuildContext context) {
    final trans = AppLocalizations.of(context).translate;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          trans("Success partners"),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 20,
          ),
          Card(
            elevation: 5,
            color: Theme.of(context).primaryColorLight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                trans("Thanks"),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  trans("MIA"),
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(trans("MH"), style: Theme.of(context).textTheme.headline5),
                Text(trans("CSA"),
                    style: Theme.of(context).textTheme.headline5),
                SizedBox(
                  height: 20,
                ),
                Text(
                  trans("Pray"),
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Flexible(
            child: Center(
              child: Image.asset(
                "assets/images/ccm_logo.png",
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
    );
  }
}
