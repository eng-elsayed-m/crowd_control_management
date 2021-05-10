import 'package:crowd_control_management/app_localizations.dart';
import 'package:flutter/material.dart';

class ReportWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trans = AppLocalizations.of(context).translate;

    return Center(
      child: Column(
        children: [
          Center(
            child: Image.asset(
              "assets/images/ccm_logo.png",
              fit: BoxFit.contain,
            ),
          ),
          Text(
            trans("We are with u"),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: ListTile(
              minLeadingWidth: 100,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              tileColor: Colors.cyan[100],
              leading: Icon(
                Icons.medical_services,
                color: Colors.red,
                size: 40,
              ),
              title: Text(trans("Report case")),
              trailing: ElevatedButton(
                child: Text(trans("Report emergency")),
                onPressed: () {},
              ),
              subtitle: Text(trans("Will sent a message")),
            ),
          ),
        ],
      ),
    );
  }
}
