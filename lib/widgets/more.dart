import 'package:crowd_control_management/app_localizations.dart';
import 'package:flutter/material.dart';

class MoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trans = AppLocalizations.of(context).translate;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Card(
                    elevation: 8,
                    color: Colors.cyan[100],
                    child: ListTile(
                      leading: Text(
                        trans("Analysis lab"),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      trailing: ElevatedButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed("lab-screen"),
                          child: Text(trans("Reservation"))),
                    )),
                Card(
                    elevation: 8,
                    color: Colors.cyan[100],
                    child: ListTile(
                      leading: Text(
                        trans("Success Partners"),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      trailing: ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed("partners-screen"),
                          child: Text(trans("Read"))),
                    )),
                Card(
                    elevation: 8,
                    color: Colors.cyan[100],
                    child: ListTile(
                      leading: Text(
                        trans("Health information"),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      trailing: ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed("medical-info-screen"),
                          child: Text(trans("Read"))),
                    )),
                Card(
                    elevation: 8,
                    color: Colors.cyan[100],
                    child: ListTile(
                      leading: Text(
                        trans("Help"),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      trailing: ElevatedButton(
                          onPressed: () {}, child: Text(trans("Contact us"))),
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
            ),
          )
        ],
      ),
    );
  }
}
