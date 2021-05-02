import 'package:crowd_control_management/widgets/report.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
  String _pageName = "الرئيسيه";
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_pageName),
          centerTitle: true,
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          color: Colors.blueGrey,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.transparent,
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
                    _pageName = "الرئيسيه";
                  });
                }
                break;

              case 3:
                {
                  setState(() {
                    _page = PermissionWidget();
                    _pageName = "طلب تصريح";
                  });
                }
                break;
              case 4:
                {
                  setState(() {
                    _page = ReportWidget();
                    _pageName = "ابلاغ";
                  });
                }
                break;
              case 1:
                {
                  setState(() {
                    _page = MoreWidget();
                    _pageName = "المزيد";
                  });
                }
                break;
              case 0:
                {
                  setState(() {
                    _page = ProfileWidget();
                    _pageName = "حسابى";
                  });
                }
                break;
            }
          },
        ),
        body: SafeArea(child: _page));
  }
}
