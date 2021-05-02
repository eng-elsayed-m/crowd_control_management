import 'package:flutter/material.dart';

class PartnersScreen extends StatelessWidget {
  static const navN = "partners-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "شركاء النجاح",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "نتقدم بالشكر الى كل من ساهم و شارك فى نجاح هذا التطبيق الذى يهتم بصحة المواطن اولا ثم نظام ناجح يؤدى الى توخى الحذر",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "وزارة الداخليه -",
                  textAlign: TextAlign.right,
                ),
                Text(
                  "وزارة الصحه -",
                  textAlign: TextAlign.right,
                ),
                Text(
                  " هيئة الاحوال المدنيه -",
                  textAlign: TextAlign.right,
                ),
                Text(
                  "نسال الله ان تمر هذه الازمه",
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/ccm_logo.png",
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}
