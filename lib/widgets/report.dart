import 'package:flutter/material.dart';

class ReportWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListTile(
              minLeadingWidth: 100,
              contentPadding: EdgeInsets.all(5),
              tileColor: Colors.cyan[100],
              leading: ElevatedButton(
                child: Text("ابلاغ"),
                onPressed: () {},
              ),
              title: Text("تقديم بلاغ عن حالة اختناق"),
              trailing: Icon(
                Icons.medical_services,
                color: Colors.red,
                size: 40,
              ),
              subtitle: Text(" بارسال رساله لاقرب مستشفى"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "نحن معك لمواجهة فيروس كورونا , والمحافظة على صحتك و صحة من تحب",
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                "assets/images/ccm_logo.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
