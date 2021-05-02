import 'package:flutter/material.dart';

class MoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Card(
                    elevation: 8,
                    color: Colors.cyan[100],
                    child: ListTile(
                      leading: ElevatedButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed("lab-screen"),
                          child: Text("الحجز")),
                      trailing: Text("معمل التحاليل"),
                    )),
                Card(
                    elevation: 8,
                    color: Colors.cyan[100],
                    child: ListTile(
                      leading: ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed("partners-screen"),
                          child: Text("القراءه")),
                      trailing: Text("شركاء النجاح"),
                    )),
                Card(
                    elevation: 8,
                    color: Colors.cyan[100],
                    child: ListTile(
                      leading: ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed("medical-info-screen"),
                          child: Text("القراءه")),
                      trailing: Text("معلومات صحيه"),
                    )),
                Card(
                    elevation: 8,
                    color: Colors.cyan[100],
                    child: ListTile(
                      leading: ElevatedButton(
                          onPressed: () {}, child: Text("الاتصال بنا")),
                      trailing: Text("المساعده"),
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
            ),
          )
        ],
      ),
    );
  }
}
