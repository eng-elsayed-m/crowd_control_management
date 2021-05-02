import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const navN = "register-screen";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _inputDeco = InputDecoration(
    hintStyle: TextStyle(fontSize: 15),
    hintTextDirection: TextDirection.rtl,
    contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
  );
  final _textFieldStyle =
      TextStyle(color: Colors.lightBlueAccent, fontSize: 18);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
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
                          minHeight: deviceSize.height * 0.57),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blueGrey,
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "انشاء حساب",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        constraints: BoxConstraints(
                            minWidth: deviceSize.width * 0.5,
                            minHeight: deviceSize.height * 0.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextFormField(
                                style: _textFieldStyle,
                                decoration: _inputDeco.copyWith(
                                    hintText: "الاسم",
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.lightBlueAccent,
                                    ))),
                            TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: _textFieldStyle,
                                decoration: _inputDeco.copyWith(
                                  hintText: "البريد",
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.lightBlueAccent,
                                  ),
                                )),
                            TextFormField(
                                keyboardType: TextInputType.number,
                                style: _textFieldStyle,
                                decoration: _inputDeco.copyWith(
                                    hintText: "رقم الموبايل",
                                    prefixIcon: Icon(
                                      Icons.mobile_friendly,
                                      color: Colors.lightBlueAccent,
                                    ))),
                            TextFormField(
                                obscureText: true,
                                style: _textFieldStyle,
                                decoration: _inputDeco.copyWith(
                                    hintText: "كلمة السر ",
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.lightBlueAccent,
                                    ))),
                            TextFormField(
                                keyboardType: TextInputType.number,
                                style: _textFieldStyle,
                                decoration: _inputDeco.copyWith(
                                    hintText: "رقم البطاقه الشخصيه ",
                                    prefixIcon: Icon(
                                      Icons.badge,
                                      color: Colors.lightBlueAccent,
                                    ))),
                            TextFormField(
                                keyboardType: TextInputType.datetime,
                                style: _textFieldStyle,
                                decoration: _inputDeco.copyWith(
                                    hintText: "تاريخ الميلاد",
                                    prefixIcon: Icon(
                                      Icons.calendar_today,
                                      color: Colors.lightBlueAccent,
                                    ))),
                            TextFormField(
                                style: _textFieldStyle,
                                decoration: _inputDeco.copyWith(
                                    hintText: "فصيلة الدم",
                                    prefixIcon: Icon(
                                      Icons.filter_vintage_outlined,
                                      color: Colors.lightBlueAccent,
                                    ))),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("تسجيل"),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.lightBlueAccent))),
                    minimumSize: MaterialStateProperty.all(
                      Size(230, 30),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
