import 'package:crowd_control_management/models/http_exception.dart';
import 'package:crowd_control_management/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    "email": "",
    "password": "",
    "name": "",
    "phone": "",
    "pId": "",
    "bDate": "${DateTime.now().toString()}",
    "blood": ""
  };
  bool _loading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState.save();
    setState(() {
      _loading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).signUp(
        _authData['email'],
        _authData["password"],
        _authData["name"],
        _authData["phone"],
        _authData["pId"],
        DateTime.parse(_authData["bDate"]),
        _authData["blood"],
      );
    } on HttpException catch (error) {
      var errorMessage = "Authentication faild";
      if (error.toString().contains("EMAIL_EXISTS")) {
        errorMessage = "This email address is already in use.";
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errorMessage = "This email is not valid.";
      } else if (error.toString().contains("WEAK_PASSWORD")) {
        errorMessage = "This password is too weak.";
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "Couldn't find a user with that email.";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "Invalid password.";
      }
      _showErrorDialog(errorMessage);
    } catch (e) {
      const errorMessage = "Check your internet connection . then try again";
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _loading = false;
    });
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Some thing !"),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  child: Text("Try again"),
                  onPressed: () => Navigator.of(ctx).pop(),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 15),
          child: Column(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        constraints: BoxConstraints(
                            minWidth: deviceSize.width * 0.5,
                            minHeight: deviceSize.height * 0.7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Form(
                          key: _formKey,
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
                                    )),
                                validator: (name) {
                                  if (name.isEmpty) {
                                    return "لا يمكن ترك الاسم خاليا";
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  _authData['name'] = val;
                                },
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: _textFieldStyle,
                                decoration: _inputDeco.copyWith(
                                  hintText: "البريد",
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ),
                                validator: (email) {
                                  if (email.isEmpty || !email.contains("@")) {
                                    return "البريد خاطئ";
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  _authData['email'] = val;
                                },
                              ),
                              TextFormField(
                                obscureText: true,
                                style: _textFieldStyle,
                                decoration: _inputDeco.copyWith(
                                    hintText: "كلمة السر ",
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.lightBlueAccent,
                                    )),
                                validator: (password) {
                                  if (password.isEmpty || password.length < 8) {
                                    return "يجب ان تتكون كلمة السر اكثر من 8 خانات";
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  _authData['password'] = val;
                                },
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                style: _textFieldStyle,
                                decoration: _inputDeco.copyWith(
                                    hintText: "رقم البطاقه الشخصيه ",
                                    prefixIcon: Icon(
                                      Icons.badge,
                                      color: Colors.lightBlueAccent,
                                    )),
                                validator: (id) {
                                  if (id.isEmpty || id.length < 14) {
                                    return "رقم البطاقه خاطئ";
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  _authData['pId'] = val;
                                },
                              ),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                style: _textFieldStyle,
                                decoration: _inputDeco.copyWith(
                                    hintText: "رقم الموبايل",
                                    prefixIcon: Icon(
                                      Icons.mobile_friendly,
                                      color: Colors.lightBlueAccent,
                                    )),
                                validator: (number) {
                                  if (number.isEmpty || number.length < 11) {
                                    return "رقم الهاتف غير صحيح ";
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  _authData['phone'] = val;
                                },
                              ),
                              TextFormField(
                                style: _textFieldStyle,
                                decoration: _inputDeco.copyWith(
                                    hintText: "فصيلة الدم",
                                    prefixIcon: Icon(
                                      Icons.filter_vintage_outlined,
                                      color: Colors.lightBlueAccent,
                                    )),
                                validator: (blood) {
                                  if (blood.isEmpty || blood.length > 4) {
                                    return "ادخل فصيلة دم صحيحه";
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  _authData['blood'] = val;
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      DateTime _date = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            DateTime.parse(_authData["bDate"]),
                                        firstDate: DateTime(1920, 1, 1),
                                        lastDate: DateTime.now(),
                                      );
                                      if (_date != null) {
                                        setState(() {
                                          _authData["bDate"] = _date.toString();
                                        });
                                      }
                                    },
                                    child: Text(
                                        _authData["bDate"].split(" ").first),
                                    style: ButtonStyle(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap),
                                  ),
                                  Text("تاريخ الميلاد")
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              _loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () => _submit()
                          .then((value) => Navigator.of(context).pop()),
                      child: Text("تسجيل"),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.lightBlueAccent))),
                          minimumSize: MaterialStateProperty.all(
                            Size(230, 30),
                          )),
                    ),
              IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.lightBlueAccent,
                  ),
                  onPressed: () => Navigator.of(context).pop())
            ],
          ),
        ),
      ),
    );
  }
}
