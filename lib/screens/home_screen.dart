import 'package:crowd_control_management/providers/location.dart';
import 'package:crowd_control_management/widgets/report.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import '../widgets/home.dart';
import '../widgets/more.dart';
import '../widgets/permission.dart';
import '../widgets/profile.dart';

class HomeScreen extends StatefulWidget {
  static const navN = "home-screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _page = HomeWidget();
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: Colors.blueGrey,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.white,
        key: _bottomNavigationKey,
        index: 2,
        items: <Widget>[
          Icon(Icons.person, size: 30),
          Icon(Icons.more, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.post_add_rounded, size: 30),
          Icon(Icons.report_problem, size: 30),
        ],
        onTap: (index) {
          switch (index) {
            case 2:
              {
                setState(() {
                  _page = HomeWidget();
                });
              }
              break;

            case 3:
              {
                setState(() {
                  _page = PermissionWidget();
                });
              }
              break;
            case 4:
              {
                setState(() {
                  _page = ReportWidget();
                });
              }
              break;
            case 1:
              {
                setState(() {
                  _page = MoreWidget();
                });
              }
              break;
            case 0:
              {
                setState(() {
                  _page = ProfileWidget();
                });
              }
              break;
          }
        },
      ),
      body: FutureBuilder(
        future:
            Provider.of<LocationP>(context, listen: false).getCurrentLocation(),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return SafeArea(child: _page);
        },
      ),
    );
  }
}
