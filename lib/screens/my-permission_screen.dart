import 'package:crowd_control_management/app_localizations.dart';
import 'package:crowd_control_management/models/permission_form.dart';
import 'package:crowd_control_management/providers/location.dart';
import 'package:crowd_control_management/providers/permission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class MyPermissionScreen extends StatefulWidget {
  static const navN = "mypermission-screen";
  @override
  _MyPermissionScreenState createState() => _MyPermissionScreenState();
}

class _MyPermissionScreenState extends State<MyPermissionScreen> {
  CircleMarker _zone = CircleMarker();
  MapController _mapController = MapController();
  bool _near = true;
  bool _loading = false;
  LatLng location;
  int pNum;

  void _handleTap(LatLng latlng) {
    location = latlng;
    print(location.longitudeInRad);
    setState(() {
      _zone = CircleMarker(
          point: latlng,
          color: Colors.blue.withOpacity(0.7),
          borderStrokeWidth: 2,
          useRadiusInMeter: true,
          radius: 500 // 2000 meters | 2 km
          );
    });
  }

  Future<void> requestPer() async {
    setState(() {
      _loading = true;
    });
    try {
      await Provider.of<Permission>(context, listen: false).createPermission(
        PermissionForm(
            location: location,
            pNum: pNum,
            expiryTime: DateTime.now().add(Duration(seconds: 50))),
      );
      setState(() {
        _loading = false;
      });
    } catch (e) {
      _showErrorDialog(e.toString());
      setState(() {
        _loading = false;
      });
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Some thing went wrong!"),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  child: Text("Try again"),
                  onPressed: () => Navigator.of(ctx).pop(),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final trans = AppLocalizations.of(context).translate;
    return Scaffold(
      appBar: AppBar(
        title: Text(trans("My permission")),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          width: deviceSize.width,
          height: deviceSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      constraints: BoxConstraints(
                          minWidth: deviceSize.width * 0.5,
                          minHeight: _near
                              ? deviceSize.height * 0.57
                              : deviceSize.height * 0.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).primaryColorLight,
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _near = true;
                                });
                              },
                              child: Text(trans("Request in permission"))),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _near = false;
                                });
                              },
                              child: Text(trans("Request out permission"))),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          constraints: BoxConstraints(
                              minWidth: deviceSize.width * 0.5,
                              minHeight: deviceSize.height * 0.4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white70,
                          ),
                          child: _near
                              ? Consumer<LocationP>(
                                  builder: (context, _loc, child) => Container(
                                    color: Colors.black,
                                    height: 320,
                                    child: _loc.location == null
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : FlutterMap(
                                            mapController: _mapController,
                                            options: MapOptions(
                                              center: LatLng(
                                                  _loc.location.latitude,
                                                  _loc.location.longitude),
                                              zoom: 15.0,
                                              onTap: _handleTap,
                                            ),
                                            layers: [
                                              TileLayerOptions(
                                                  urlTemplate:
                                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                  subdomains: ['a', 'b', 'c']),
                                              CircleLayerOptions(
                                                circles: [_zone],
                                              ),
                                              MarkerLayerOptions(markers: [
                                                Marker(
                                                  point: LatLng(
                                                      _loc.location.latitude,
                                                      _loc.location.longitude),
                                                  height: 120,
                                                  width: 120,
                                                  builder: (context) => Icon(
                                                    Icons.home,
                                                    color: Colors.green,
                                                  ),
                                                )
                                              ])
                                            ],
                                          ),
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.notification_important,
                                          size: 50,
                                          color: Colors.amber,
                                        ),
                                        Text(
                                          trans("Allowed Duration"),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                          softWrap: true,
                                          textWidthBasis: TextWidthBasis.parent,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                                onPressed: () {
                                                  if (pNum > 1) {
                                                    setState(() {
                                                      pNum--;
                                                    });
                                                  }
                                                }),
                                            Text(
                                              pNum.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.add_circle,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                                onPressed: () {
                                                  if (pNum < 3) {
                                                    setState(() {
                                                      pNum++;
                                                    });
                                                  }
                                                }),
                                          ],
                                        ),
                                        Text(
                                          trans("Three persons at max"),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      title: Text(trans("Destinaion")),
                                      trailing: TextButton(
                                        child: Text(
                                          trans("Select"),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                  color:
                                                      Colors.lightBlueAccent),
                                        ),
                                        onPressed: () {},
                                      ),
                                    )
                                  ],
                                )),
                      _loading
                          ? SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () async {
                                await requestPer();
                                Navigator.of(context).pop();
                              },
                              child: Text(trans("Request the permission")),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Colors.lightBlueAccent))),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(230, 30),
                                  )),
                            ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
