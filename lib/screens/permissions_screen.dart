import 'package:crowd_control_management/app_localizations.dart';
import 'package:crowd_control_management/models/permission_form.dart';
import 'package:crowd_control_management/providers/location.dart';
import 'package:crowd_control_management/providers/permission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class PermissionScreen extends StatefulWidget {
  static const navN = "permission_screen";
  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool _away = false;
  bool _loading = false;
  double _zoom = 15;
  LatLng location;
  int pNum = 1;
  CircleMarker _zone = CircleMarker();
  MapController _mapController = MapController();

  void _handleTap(LatLng latlng) {
    location = latlng;

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
      final bool success = await Provider.of<Permission>(context, listen: false)
          .createPermission(
        PermissionForm(
            location: _away
                ? location
                : Provider.of<LocationP>(context, listen: false).location,
            pNum: pNum,
            expiryTime: DateTime.now().add(Duration(hours: 4)),
            type: _away ? "Away" : "Around"),
      );
      if (!success) await _showErrorDialog("It's Crowded");
    } catch (e) {
      await _showErrorDialog(e.toString());
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _showErrorDialog(String errorMessage) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("You can't get Permission"),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  child: Text("Try again"),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    final trans = AppLocalizations.of(context).translate;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: _deviceSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: _deviceSize.width,
                height: _deviceSize.height * 0.6,
                padding: EdgeInsets.symmetric(),
                child: Card(
                  child: Consumer<LocationP>(
                    builder: (context, _loc, child) => _loc == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : FlutterMap(
                            mapController: _mapController,
                            options: MapOptions(
                              center: LatLng(_loc.location.latitude,
                                  _loc.location.longitude),
                              zoom: _zoom,
                              onTap: _away ? _handleTap : null,
                            ),
                            layers: [
                              TileLayerOptions(
                                  urlTemplate:
                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  subdomains: ['a', 'b', 'c']),
                              CircleLayerOptions(
                                circles: [
                                  _away
                                      ? _zone
                                      : CircleMarker(
                                          point: _loc.location,
                                          color: Colors.blue.withOpacity(0.7),
                                          borderStrokeWidth: 2,
                                          useRadiusInMeter: true,
                                          radius: 500 // 2000 meters | 2 km
                                          )
                                ],
                              ),
                              MarkerLayerOptions(markers: [
                                Marker(
                                  point: LatLng(_loc.location.latitude,
                                      _loc.location.longitude),
                                  height: 120,
                                  width: 120,
                                  builder: (context) => Icon(
                                    Icons.home,
                                    color: Colors.purple,
                                  ),
                                )
                              ])
                            ],
                          ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notification_important,
                    size: 50,
                    color: Colors.amber,
                  ),
                  Text(
                    trans("Allowed Duration"),
                    style: Theme.of(context).textTheme.subtitle1,
                    softWrap: true,
                    textWidthBasis: TextWidthBasis.parent,
                  ),
                ],
              ),
              ListTile(
                title: Text(_away ? "Away" : "Around"),
                trailing: Switch(
                  value: _away,
                  onChanged: (value) {
                    if (value) {
                      _mapController.move(LatLng(30.000, 30.000), 5);

                      setState(() {
                        _away = !_away;
                      });
                    } else {
                      _mapController.move(
                          Provider.of<LocationP>(context, listen: false)
                              .location,
                          15);

                      setState(() {
                        _away = !_away;
                      });
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  Text(pNum.toString()),
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
                ],
              ),
              _loading
                  ? SizedBox(
                      width: 50, height: 50, child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () async {
                        await requestPer();
                        Navigator.of(context).pop();
                      },
                      child: Text(trans("Request the permission")),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.lightBlueAccent))),
                          minimumSize: MaterialStateProperty.all(
                            Size(230, 30),
                          )),
                    ),
              IconButton(
                  icon: Icon(Icons.arrow_downward_rounded),
                  onPressed: () => Navigator.of(context).pop())
            ],
          ),
        ),
      ),
    );
  }
}
