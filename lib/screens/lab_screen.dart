import 'package:flutter/material.dart';

class LabScreen extends StatelessWidget {
  static const navN = "lab-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("معمل التحاليل"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("عشان صحتك تحمنا خليك ف بيتك و احجز و استلم النتيجه"),
                Card(
                    elevation: 8,
                    color: Colors.cyan[100],
                    child: ListTile(
                      leading:
                          ElevatedButton(onPressed: () {}, child: Text("احجز")),
                      trailing: Text("لحجز موعد"),
                    )),
                Card(
                    elevation: 8,
                    color: Colors.cyan[100],
                    child: ListTile(
                      leading: ElevatedButton(
                          onPressed: () {}, child: Text("استلم")),
                      trailing: Text("استلام نتيجة تحليل"),
                    )),
              ],
            ),
          ),
          Expanded(
              child: Center(
            child: Image.asset(
              "assets/images/ccm_logo.png",
              fit: BoxFit.contain,
            ),
          ))
        ],
      ),
    );
  }
}
