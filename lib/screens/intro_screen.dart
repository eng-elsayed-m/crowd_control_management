import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/register_screen.dart';

class IntroScreen extends StatefulWidget {
  static const navN = "intro-screen";
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: deviceSize.width,
          height: deviceSize.height,
          color: Color(0xffffffff),
          child: Column(
            children: [
              Container(
                  width: deviceSize.width,
                  height: deviceSize.height * 0.40,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF77acf1), Color(0xFFc0fefc)],
                          stops: [0.1, 0.9],
                          begin: AlignmentDirectional.bottomStart,
                          end: AlignmentDirectional.topEnd),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(170))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 90),
                    child: Image.asset(
                      "assets/images/ccm_logo.png",
                      fit: BoxFit.contain,
                    ),
                  )
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       left: deviceSize.width * 0.52,
                  //       top: deviceSize.height * 0.31),
                  //   child: Text(
                  //     "تسجيل الدخول",
                  //     style: TextStyle(
                  //         fontSize: 25,
                  //         color: Colors.white60,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
                child: LoginForm(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _inputDeco = InputDecoration(
    fillColor: Colors.white,
    contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    filled: true,
  );
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
              style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20),
              decoration: _inputDeco.copyWith(
                  prefixIcon: Icon(Icons.email), labelText: "البريد")),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20),
            obscureText: true,
            decoration: _inputDeco.copyWith(
              prefixIcon: Icon(Icons.lock),
              labelText: "كلمة المرور",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            child: Text("نسيت كلمة المرور ؟"),
            onPressed: () {},
          ),
          Spacer(),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.lightBlueAccent))),
                  minimumSize: MaterialStateProperty.all(
                    Size(230, 25),
                  )),
              onPressed: () => Navigator.of(context).pushNamed(HomeScreen.navN),
              child: Text(
                "تسجيل الدخول",
              )),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ليس لديك حساب ؟"),
              TextButton(
                child: Text(
                  "انشاء حساب",
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(RegisterScreen.navN),
              )
            ],
          )
        ],
      ),
    );
  }
}
