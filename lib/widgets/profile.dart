import 'package:crowd_control_management/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<Auth>(context).user;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Card(
              elevation: 8,
              child: _user == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${_user.name} : الاسم",
                            textAlign: TextAlign.right,
                          ),
                          Text(
                            "${_user.blood} : فصيلة الدم",
                            textAlign: TextAlign.right,
                          ),
                          Text(
                            "${_user.pId} : رقم البطاقة الشخصيه",
                            textAlign: TextAlign.right,
                          ),
                          Text(
                            "${_user.bDate.toString()} : تاريخ الميلاد",
                            textAlign: TextAlign.right,
                          ),
                          Text(
                            "${_user.phone} : الموبايل",
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          Center(
              child: ElevatedButton(
                  child: Text("تسجيل الخروج"),
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false).logout();
                  })),
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
