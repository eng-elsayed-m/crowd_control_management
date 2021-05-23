import 'package:crowd_control_management/providers/location.dart';
import 'package:crowd_control_management/providers/permission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:provider/provider.dart';
import '../app_localizations.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    final trans = AppLocalizations.of(context).translate;

    return Consumer<Permission>(
      builder: (ctx, perm, child) => FutureBuilder(
        future: perm.autoCheck(),
        builder: (ctx, AsyncSnapshot snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    height: 50,
                    width: 50,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 10,
                        color: perm.isPermoted ? Colors.green : Colors.red),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            children: [
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Icon(
                              //       Icons.home,
                              //       size: 40,
                              //     ),
                              //     ElevatedButton(
                              //         onPressed: () {},
                              //         child: Text(trans("Show results"))),
                              //   ],
                              // ),
                              Card(
                                elevation: 8,
                                color: Colors.cyan[100],
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_pin,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        Flexible(
                                          child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Consumer<LocationP>(
                                                builder:
                                                    (context, loca, child) =>
                                                        Text(
                                                  loca.address,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4,
                                                ),
                                              )),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          )),
                      Expanded(
                          child: !perm.isPermoted
                              ? Column(
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
                                )
                              : Card(
                                  child: Column(
                                    children: [
                                      CountdownTimer(
                                          endTime: perm.permission.expiryTime
                                              .millisecondsSinceEpoch),
                                      Divider(),
                                      ListTile(
                                        leading: Text("Number :"),
                                        trailing:
                                            Text("${perm.permission.pNum}"),
                                      ),
                                    ],
                                  ),
                                ))
                    ],
                  ),
                );
        },
      ),
    );
  }
}
