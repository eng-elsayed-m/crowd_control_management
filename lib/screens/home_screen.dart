import 'package:crowd_control_management/app_localizations.dart';
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
  GlobalKey _bottomNavigationKey = GlobalKey();
  String _pageName = "";
  Function trans;

  @override
  void didChangeDependencies() {
    _pageName = AppLocalizations.of(context).translate("Main");
    trans = AppLocalizations.of(context).translate;
    super.didChangeDependencies();
  }

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
                    _pageName = trans("Main");
                  });
                }
                break;

              case 3:
                {
                  setState(() {
                    _page = PermissionWidget();
                    _pageName = trans("Request permit");
                  });
                }
                break;
              case 4:
                {
                  setState(() {
                    _page = ReportWidget();
                    _pageName = trans("Report");
                  });
                }
                break;
              case 1:
                {
                  setState(() {
                    _page = MoreWidget();
                    _pageName = trans("More");
                  });
                }
                break;
              case 0:
                {
                  setState(() {
                    _page = ProfileWidget();
                    _pageName = trans("Profile");
                  });
                }
                break;
            }
          },
        ),
        body: SafeArea(child: _page));
  }
}
