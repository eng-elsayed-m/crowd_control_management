import 'package:crowd_control_management/app_localizations.dart';
import 'package:crowd_control_management/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<Auth>(context).user;
    final trans = AppLocalizations.of(context).translate;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Card(
              color: Theme.of(context).primaryColorLight,
              elevation: 8,
              child: _user == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                trans("Name"),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${_user.name}",
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                trans("Blood type"),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${_user.blood}",
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                trans("Identity number"),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${_user.pId}",
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                trans("Birth date"),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${_user.bDate.toString().split(" ").first}",
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                trans("Mobile"),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${_user.phone}",
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          Center(
              child: ElevatedButton(
                  child: Text(trans("Signout")),
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false).logout();
                  })),
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
