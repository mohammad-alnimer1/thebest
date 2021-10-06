import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/Drawer/Constants.dart';
import 'package:thebest/Login_Page.dart';
import 'package:thebest/Registration.dart';

import 'AppHelper/AppColors.dart';
import 'AppHelper/AppController.dart';
import 'AppHelper/buttonClass.dart';
import 'api/Api.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  static final TextEditingController _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int state = 1;
  _toggle() {
    setState(() {
      state = state == 1 ? 2 : 1;
    });
  }

  final _Form = GlobalKey<FormState>();

  var emailControl;
  Future register() async {
    var registrationData = {
      'Email': _emailController.text,
    };
    var url =
        'http://mohamadfaqeh-001-site37.itempurl.com/api/mobile/resetpassword';

    dynamic response = await http.post(url, body: registrationData);

    print("response.body${response.body}");
    emailControl = jsonDecode(response.body);

    if (emailControl == "-1") {
      return showPlatformDialog(
          context: context,
          builder: (_) => Directionality(
              textDirection: AppController.textDirection,
              child: BasicDialogAlert(
                title: Text(AppController.strings.Note),
                content: Text(AppController.strings.EmailInvalid),
                actions: <Widget>[
                  BasicDialogAction(
                    title: Text(AppController.strings.ok),
                    onPressed: () {
                      Navigator.of(context).pop('dialog');
                    },
                  ),
                ],
              )));
    } else {
      return showPlatformDialog(
          context: context,
          builder: (_) => Directionality(
              textDirection: AppController.textDirection,
              child: BasicDialogAlert(
                title: Text(AppController.strings.Note),
                content: Text(AppController.strings.sendPassword),
                actions: <Widget>[
                  BasicDialogAction(
                    title: Text(AppController.strings.ok),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LogInPage()),
                              (Route<dynamic> route) => false);
                    },
                  ),
                ],
              )));
    }
  }
  var languageState;
  langState()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      languageState = preferences.getString("lng");

    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.5;

    return Directionality(
        textDirection: AppController.textDirection,
        child: Form(
          key: _Form,
          child: Scaffold(
            backgroundColor: Color(0x04b2d9),
            bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 320,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: button(
                      buttonName: '${AppController.strings.send}',
                      color: Colors.black,
                      onpress: () async {
                        if (_Form.currentState.validate()) {
                          register();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => VerifyPassword(),
                          //   ),
                          // );
                        }
                      },
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppController.strings.dontHaveAccount,
                    style: TextStyle(
                        fontFamily: 'Anton',
                        fontSize: 14,
                        color: AppColors.blackColor.withOpacity(0.5)),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  InkWell(
                    child: Text(AppController.strings.signUp,
                        style: TextStyle(
                          // fontWeight:FontWeight.bold ,
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          fontFamily: 'Anton',
                          color: Colors.white,
                        )),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationPage(),
                        ),
                      ),
                    },
                  ),
                ],
              )
            ],
          ),
            ),
            body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 2,
                        child: CircleAvatar(
                          maxRadius: 80,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                              child: Image.asset(
                                'images/Logo.png',
                                fit: BoxFit.fitWidth,
                                height: 150,
                                width: 150,
                              )),
                        ),),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(
                          bottom: 15, left: 5, top: 15, right: 5),
                      child: Text(
                        '${AppController.strings.ForgotPassword}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                    )),
                    Expanded(
                     child: Padding(
                        padding: const EdgeInsets.all(8.0),
                       child: Container(
                            //padding: EdgeInsets.only(top: height * 1.2),
                         child: TextFormField(
                          validator: (value) => value.isEmpty
                              ? '${AppController.strings.FillEmail}'
                              : null,
                          keyboardType: TextInputType.text,
                          autocorrect: true,
                          decoration: KDecoration.copyWith(
                              prefixIcon: Icon(Icons.email),
                            labelText: AppController.strings.email,
                            filled: true,
                            fillColor: Colors.white70,
                          ),

                          controller: _emailController,
                        )),
                      ),
                    ),
                  ],
                ))
              ],
            )
          ],
            ),
          ),
        ));
  }
}
