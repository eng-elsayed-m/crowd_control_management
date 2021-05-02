import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(": الاسم"),
                  Text(": اسم العائله"),
                  Text(": رقم البطاقة الشخصيه"),
                  Text(": تاريخ الميلاد"),
                ],
              ),
            ),
          ),
          Center(
              child: ElevatedButton(
                  child: Text("تسجيل جديد"),
                  onPressed: () =>
                      Navigator.of(context).pushNamed("register-screen"))),
          Expanded(
            child: Center(
              child: Image.asset(
                "assets/images/ccm_logo.png",
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
    );
  }
}
