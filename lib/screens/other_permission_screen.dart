import 'package:flutter/material.dart';

class OtherPermissionScreen extends StatefulWidget {
  static const navN = "otherpermission-screen";
  @override
  _OtherPermissionScreenState createState() => _OtherPermissionScreenState();
}

class _OtherPermissionScreenState extends State<OtherPermissionScreen> {
  bool _near = true;
  int _perNum = 1;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
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
                          minHeight: _near
                              ? deviceSize.height * 0.66
                              : deviceSize.height * 0.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.shade400,
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _near = false;
                                });
                              },
                              child: Text("طلب تصريح خارجى")),
                          SizedBox(
                            width: 50,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _near = true;
                                });
                              },
                              child: Text("طلب تصريح داخلى")),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          constraints: BoxConstraints(
                              minWidth: deviceSize.width * 0.5,
                              minHeight: deviceSize.height * 0.4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white70,
                          ),
                          child: _near
                              ? Column(
                                  children: [
                                    Text("ثلاثة اشخاص كحد اقصى"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.remove_circle,
                                              color: Colors.lightBlueAccent,
                                            ),
                                            onPressed: () {
                                              if (_perNum > 1) {
                                                setState(() {
                                                  _perNum--;
                                                });
                                              }
                                            }),
                                        Text(
                                          _perNum.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.add_circle,
                                              color: Colors.lightBlueAccent,
                                            ),
                                            onPressed: () {
                                              if (_perNum < 3) {
                                                setState(() {
                                                  _perNum++;
                                                });
                                              }
                                            }),
                                      ],
                                    ),
                                    Image.asset(
                                      "assets/images/google-map.jpg",
                                      fit: BoxFit.fitWidth,
                                    )
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.notification_important,
                                          size: 50,
                                          color: Colors.amber,
                                        ),
                                        Text(
                                          "عدد ساعات تجولك الشخصى 4 ساعات",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                                onPressed: () {
                                                  if (_perNum > 1) {
                                                    setState(() {
                                                      _perNum--;
                                                    });
                                                  }
                                                }),
                                            Text(
                                              _perNum.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.add_circle,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                                onPressed: () {
                                                  if (_perNum < 3) {
                                                    setState(() {
                                                      _perNum++;
                                                    });
                                                  }
                                                }),
                                          ],
                                        ),
                                        Text(
                                          "ثلاثة اشخاص حد اقصى",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      title: Text("المكان المراد التوجه اليه"),
                                      trailing: TextButton(
                                        child: Text(
                                          "تحديد",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                  color:
                                                      Colors.lightBlueAccent),
                                        ),
                                        onPressed: () {},
                                      ),
                                    )
                                  ],
                                )),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("طلب التصريح"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: Colors.lightBlueAccent))),
                            minimumSize: MaterialStateProperty.all(
                              Size(230, 30),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
