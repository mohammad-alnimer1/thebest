import 'package:flutter/material.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:thebest/AppHelper/buttonClass.dart';
import 'package:thebest/Navigation/NavigationBar.dart';

import 'Constants.dart';

class Setting_page extends StatefulWidget {
  @override
  _Setting_pageState createState() => _Setting_pageState();
}

class _Setting_pageState extends State<Setting_page> {
  final _PasswordformKey = GlobalKey<FormState>();

  static final _oldpasswordController = TextEditingController();
  static final _newpasswordController = TextEditingController();
  static final _repasswordController = TextEditingController();

  String newconfpassvalid(String val) {
    if (val.trim().isEmpty) {
      return '${AppController.strings.errorPassword}';
    }
    if (val.length < 5) {
      return '${AppController.strings.Passwordliss6}';
    }
    if (val != _newpasswordController.text) {
      return '${AppController.strings.errorMatchPassword}';
    }
  }

  var _data;
  var UserEmail;

  Future ChangePasswordFun() async {
    if (_PasswordformKey.currentState.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserEmail = prefs.getString("Email");
      print(UserEmail);
      var data = {
        "Email": UserEmail.toString(),
        "UDF4": _oldpasswordController.text,
        "Password": _newpasswordController.text,
      };
      var url =
          "http://mohamadfaqeh-001-site37.itempurl.com/api/mobile/changepassword";
      dynamic response = await http.post(url, body: data);
      print(response.body);
      String jsonsDataString = response.body;
      _data = jsonDecode(jsonsDataString);
      print('hi hi hi hi hi hi hi ${_data}');
      if (_data != "0") {
        Showtoast("${AppController.strings.changeDataSuccess}");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NavigationBBar()));
      } else {
        Showtoast("${AppController.strings.PleaseCheckPassword}");
        // show_dialogall(context,"filed","wrong email or password plese check");

      }
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
    return Directionality(
        textDirection: AppController.textDirection,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFf33BE9F),
            centerTitle: true,
            title: Text(AppController.strings.Settings),
          ),
          body: Form(
            key: _PasswordformKey,
            child: ListView(
              children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(color: Colors.black87),
                    )),
                    child: ExpansionTile(
                      collapsedBackgroundColor:
                          Color(0xFff33BE9F).withOpacity(0.7),
                      backgroundColor: Colors.white,

                      // onExpansionChanged: _onExpansionChanged,
                      maintainState: true,
                      key: Key(1.toString()), //attention
                      title: Text(
                        '${AppController.strings.ChangePassword}',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),

                      children: [
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppController.strings.OldPassword}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextFormField(
                                    validator: (val) {
                                      return val.isEmpty
                                          ? AppController.strings.OldPassword
                                          : null;
                                    },
                                    controller: _oldpasswordController,
                                    keyboardType: TextInputType.text,
                                    decoration: KDecoration.copyWith(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        hintText:
                                            '${AppController.strings.OldPassword}'))
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(right: 15, left: 15),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppController.strings.NewPassword}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextFormField(
                                    obscureText: true,
                                    validator: newconfpassvalid,
                                    controller: _newpasswordController,
                                    keyboardType: TextInputType.text,
                                    autocorrect: true,
                                    decoration: KDecoration.copyWith(
                                        hintText:
                                            '${AppController.strings.NewPassword}'))
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppController.strings.ConfirmNewPassword}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextFormField(
                                    obscureText: true,
                                    validator: newconfpassvalid,
                                    controller: _repasswordController,
                                    keyboardType: TextInputType.text,
                                    autocorrect: true,
                                    decoration: KDecoration.copyWith(
                                        hintText:
                                            '${AppController.strings.ConfirmNewPassword}'))
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: button(
                              buttonName: '${AppController.strings.Change}',
                              color: Colors.black,
                              onpress: () {
                                ChangePasswordFun();

                                // print(email);
                                // print(password);
                                // try {
                                //   setState(() {
                                //     ShowSpinar=true;
                                //   });
                                //   final newuser = await _auth.createUserWithEmailAndPassword(
                                //       email: email, password: password);
                                //
                                //
                                //   if (newuser != null) {
                                //     Navigator.pushNamed(context, ChatScreen.id);
                                //   }
                                //
                                //
                                // } catch (e) {
                                //   setState(() {
                                //     ShowSpinar=false;
                                //   });
                                //   print(e);
                                // }
                              },
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }

  Future Showtoast(
    String Msg,
  ) {
    Fluttertoast.showToast(
        msg: Msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xFFFFADAD),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
