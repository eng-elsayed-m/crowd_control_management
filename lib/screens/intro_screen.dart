import 'package:crowd_control_management/app_localizations.dart';
import 'package:crowd_control_management/models/http_exception.dart';
import 'package:crowd_control_management/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/register_screen.dart';

class IntroScreen extends StatefulWidget {
  static const navN = "intro-screen";
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {"email": "", "password": ""};
  final _inputDeco = InputDecoration(
    fillColor: Colors.white,
    contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    filled: true,
  );
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
      await Provider.of<Auth>(context, listen: false)
          .login(_authData['email'], _authData["password"]);
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
      setState(() {
        _loading = false;
      });
    } catch (e) {
      const errorMessage = "Check your internet connection . then try again";
      _showErrorDialog(errorMessage);
      setState(() {
        _loading = false;
      });
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Some thing went wrong!"),
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
    final trans = AppLocalizations.of(context).translate;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: deviceSize.width,
          height: deviceSize.height,
          color: Color(0xffffffff),
          child: Column(
            children: [
              Container(
                  width: deviceSize.width,
                  height: deviceSize.height * 0.40,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF77acf1), Color(0xFFc0fefc)],
                          stops: [0.1, 0.9],
                          begin: AlignmentDirectional.bottomStart,
                          end: AlignmentDirectional.topEnd),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(170))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 90),
                    child: Image.asset(
                      "assets/images/ccm_logo.png",
                      fit: BoxFit.contain,
                    ),
                  )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                            color: Colors.lightBlueAccent, fontSize: 20),
                        decoration: _inputDeco.copyWith(
                            prefixIcon: Icon(Icons.email),
                            labelText: trans("Email")),
                        validator: (email) {
                          if (email.isEmpty || !email.contains("@")) {
                            return trans("Invalid email");
                          }
                          return null;
                        },
                        onSaved: (val) {
                          _authData['email'] = val;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: TextStyle(
                            color: Colors.lightBlueAccent, fontSize: 20),
                        obscureText: true,
                        decoration: _inputDeco.copyWith(
                          prefixIcon: Icon(Icons.lock),
                          labelText: AppLocalizations.of(context)
                              .translate("Password"),
                        ),
                        validator: (password) {
                          if (password.isEmpty || password.length < 8) {
                            return trans("Short password");
                          }
                          return null;
                        },
                        onSaved: (val) {
                          _authData['password'] = val;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _loading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Colors.lightBlueAccent))),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(230, 30),
                                  )),
                              onPressed: _submit,
                              child: Text(
                                trans("SignIn"),
                              )),
                      Spacer(),
                      TextButton(
                        child: Text(trans("Forget password")),
                        onPressed: () {},
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(trans("Don't have account")),
                          TextButton(
                            child: Text(
                              trans("Create account"),
                              style: TextStyle(color: Colors.lightBlueAccent),
                            ),
                            onPressed: () => Navigator.of(context)
                                .pushNamed(RegisterScreen.navN),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
