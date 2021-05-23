import 'package:crowd_control_management/providers/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  CircleMarker _zone = CircleMarker();
  MapController _mapController = MapController();

  void _handleTap(LatLng latlng) {
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

  // bool arePointsNear(checkPoint, centerPoint, km) {
  //   num ky = 40000 / 360;
  //   num kx = cos(pi * centerPoint.lat / 180.0) * ky;
  //   num dx = (centerPoint.lng - checkPoint.lng).abs() * kx;
  //   num dy = (centerPoint.lat - checkPoint.lat).abs() * ky;
  //   return sqrt(dx * dx + dy * dy) <= km;
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationP>(
      builder: (context, _loc, child) => FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(_loc.location.latitude, _loc.location.longitude),
          zoom: 15.0,
          onTap: _handleTap,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          CircleLayerOptions(
            circles: [_zone],
          ),
          MarkerLayerOptions(markers: [
            Marker(
              point: LatLng(_loc.location.latitude, _loc.location.longitude),
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
    );
  }
}
