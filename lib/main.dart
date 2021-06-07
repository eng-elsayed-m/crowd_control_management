import 'app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth.dart';
import 'providers/location.dart';
import 'providers/permission.dart';
import 'screens/home_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/register_screen.dart';
import 'screens/Permissions_screen.dart';
import 'screens/lab_screen.dart';
import 'screens/medical_info_screen.dart';
import 'screens/partners_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => LocationP()),
        ChangeNotifierProxyProvider<Auth, Permission>(
          update: (ctx, auth, previousProducts) =>
              Permission(auth.token, auth.userId),
          create: null,
        ),
      ],
      builder: (context, child) => Consumer<Auth>(
        builder: (context, _auth, child) => MaterialApp(
          supportedLocales: [Locale("en", "US"), Locale("ar", "EG")],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.countryCode == locale.countryCode &&
                  supportedLocale.languageCode == locale.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          color: Colors.white,
          title: 'CC-Management',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            accentColor: Colors.lightBlueAccent,
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
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/ccm_logo.png",
                                  fit: BoxFit.contain,
                                ),
                                CircularProgressIndicator(),
                              ],
                            )
                          : IntroScreen()),
          routes: {
            IntroScreen.navN: (ctx) => IntroScreen(),
            RegisterScreen.navN: (ctx) => RegisterScreen(),
            HomeScreen.navN: (ctx) => HomeScreen(),
            LabScreen.navN: (ctx) => LabScreen(),
            PartnersScreen.navN: (ctx) => PartnersScreen(),
            MedicalInfoScreen.navN: (ctx) => MedicalInfoScreen(),
            PermissionScreen.navN: (ctx) => PermissionScreen(),
          },
        ),
      ),
    );
  }
}
