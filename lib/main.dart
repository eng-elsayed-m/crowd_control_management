import 'package:crowd_control_management/providers/auth.dart';
import 'package:crowd_control_management/screens/lab_screen.dart';
import 'package:crowd_control_management/screens/medical_info_screen.dart';
import 'package:crowd_control_management/screens/partners_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/home_screen.dart';
import './screens/intro_screen.dart';
import './screens/my-permission_screen.dart';
import './screens/other_permission_screen.dart';
import './screens/register_screen.dart';
// import 'package:twaklna/screens/intro_screen.dart';
// import 'package:twaklna/screens/navigation_home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Auth(),
      builder: (context, child) => Consumer<Auth>(
        builder: (context, _auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Twaklna',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder()
            }),
          ),
          home: _auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: _auth.autoLogin(),
                  builder: (ctx, AsyncSnapshot snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? CircularProgressIndicator()
                          : IntroScreen()),
          routes: {
            IntroScreen.navN: (ctx) => IntroScreen(),
            RegisterScreen.navN: (ctx) => RegisterScreen(),
            HomeScreen.navN: (ctx) => HomeScreen(),
            MyPermissionScreen.navN: (ctx) => MyPermissionScreen(),
            OtherPermissionScreen.navN: (ctx) => OtherPermissionScreen(),
            LabScreen.navN: (ctx) => LabScreen(),
            PartnersScreen.navN: (ctx) => PartnersScreen(),
            MedicalInfoScreen.navN: (ctx) => MedicalInfoScreen(),
          },
        ),
      ),
    );
  }
}
