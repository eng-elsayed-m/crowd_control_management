import 'package:crowd_control_management/providers/auth.dart';
import 'package:crowd_control_management/providers/location.dart';
import 'package:crowd_control_management/providers/permission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_map/flutter_map.dart';
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
    final user = Provider.of<Auth>(context).user;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Card(
              elevation: 8,
              color: Colors.cyan[100],
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                              builder: (context, loca, child) => Text(
                                loca.address,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            )),
                      ),
                    ],
                  )),
            )),
        Consumer<Permission>(
          builder: (ctx, perm, child) => Expanded(
            child: FutureBuilder(
              future: perm.autoCheck(),
              builder: (context, AsyncSnapshot snapshot) {
                return perm.permission == null
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
                          Divider(
                            color: Colors.red,
                            thickness: 10,
                            height: 25,
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
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 50.0,
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.loose,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 10,
                                            color: Colors.lightBlueAccent)),
                                  ),
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20,
                                      left: 60,
                                      right: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(user.name),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Id number : " + user.pId),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                              "For : ${perm.permission.pNum} persons"
                                                  .toString()),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                              "Type : " + perm.permission.type),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: -45,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                      child: CountdownTimer(
                                          endTime: perm.permission.expiryTime
                                              .millisecondsSinceEpoch),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: FlutterMap(
                              mapController: MapController(),
                              options: MapOptions(
                                center: perm.permission.location,
                                zoom: 15,
                                allowPanning: true,
                              ),
                              layers: [
                                TileLayerOptions(
                                    urlTemplate:
                                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    subdomains: ['a', 'b', 'c']),
                                CircleLayerOptions(
                                  circles: [
                                    CircleMarker(
                                        point: perm.permission.location,
                                        color: Colors.blue.withOpacity(0.7),
                                        borderStrokeWidth: 2,
                                        useRadiusInMeter: true,
                                        radius: 500 // 2000 meters | 2 km
                                        )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      );
              },
            ),
          ),
        )
      ],
    );
  }
}
