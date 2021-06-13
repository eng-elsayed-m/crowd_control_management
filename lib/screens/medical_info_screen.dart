import 'package:crowd_control_management/app_localizations.dart';
import 'package:flutter/material.dart';

class MedicalInfoScreen extends StatelessWidget {
  static const navN = "medical-info-screen";
  @override
  Widget build(BuildContext context) {
    final trans = AppLocalizations.of(context).translate;
    return Scaffold(
      appBar: AppBar(
        title: Text(trans("Medical info")),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  trans("Advice1"),
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(trans("Advice2"),
                    style: Theme.of(context).textTheme.headline5),
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(trans("Advice3"),
                    style: Theme.of(context).textTheme.headline5),
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(trans("Advice4"),
                    style: Theme.of(context).textTheme.headline5),
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(trans("Advice5"),
                    style: Theme.of(context).textTheme.headline5),
              ),
            ),
            Flexible(
              child: Center(
                child: Image.asset(
                  "assets/images/ccm_logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
