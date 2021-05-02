import 'package:flutter/material.dart';

class MedicalInfoScreen extends StatelessWidget {
  static const navN = "medical-info-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("معلومات طبيه"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "معلومات طبيه",
            textAlign: TextAlign.center,
          ),
          Text(
            " اتصل باقرب مستشفى اذا شعرت بعراض كورونا و اعزل نفسك حتى تصل المساعده",
            textAlign: TextAlign.center,
          ),
          Text(
            " ابتعد عن الاماكن المزدحمه و حافظ على التباعد الجسدى -",
            textAlign: TextAlign.right,
          ),
          Text(
            " استخدام الانترنت فى الحصول على الاشياء قدر الامكان -",
            textAlign: TextAlign.right,
          ),
          Text(
            " تجنب الاختلاط -",
            textAlign: TextAlign.right,
          ),
          Text(
            " نسال الله ان تمر هذه الازمه",
            textAlign: TextAlign.center,
          ),
          Center(
            child: Image.asset(
              "assets/images/ccm_logo.png",
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
