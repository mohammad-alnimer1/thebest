
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/networking.dart';
import 'package:thebest/Login_Page.dart';
import 'package:thebest/api/Api.dart';

import 'AppHelper/buttonClass.dart';
import 'Navigation/NavigationBar.dart';

class entrypagess extends StatefulWidget {
  @override
  _entrypagessState createState() => _entrypagessState();
}

class _entrypagessState extends State<entrypagess> {
  var Email;
  var Title;

  var data;

  Future<dynamic> getaboutUs() async {
    NetworkHelper networkHelper =
    NetworkHelper('${Api().baseURL}webpage/en?id=75');
    data = await networkHelper.getdata();
    setState(() {
      Email = data['DescriptionAr'];

      Title = data['TitleAr'];

      print(Email);
      return data;
    });
  }

  var titlephone;
  var phone;
  var phonedata;
  Future<dynamic> getPhone() async {
    NetworkHelper networkHelper =
    NetworkHelper('${Api().baseURL}webpage/en?id=74');
    phonedata = await networkHelper.getdata();
    setState(() {
      titlephone = phonedata['DescriptionAr'];

      phone = phonedata['TitleEn'];

      print(Email);
      return data;
    });
  }

  @override
  void initState() {
    super.initState();
    getaboutUs();
    getPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: AppController.textDirection,
        //textDirection: AppController.textDirection,
        //debugShowCheckedModeBanner: false,
        child: Scaffold(
            backgroundColor: Color(0xFF04b2d9),
            body: Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // CircleAvatar(
                      //   backgroundColor: Colors.white,
                      //
                      //    maxRadius: 80,
                      //    backgroundImage: AssetImage('images/Logo.png'),
                      //
                      // ),

                      CircleAvatar(
                        maxRadius: 80,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                            child: Image.asset(
                              'images/Logo.png',
                              fit: BoxFit.cover,
                              matchTextDirection: true,
                              height: 150,
                              width: 150,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: button(
                          buttonName: '${AppController.strings.login}',
                          color: Colors.black,
                          onpress: () async {
                            try {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LogInPage(),
                                  ),
                                );
                              });
                            } catch (e) {
                              setState(() {
                                // ShowSpinar=false;
                              });
                              print(e);
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: button(
                          buttonName: '${AppController.strings.loginGist}',
                          color: Colors.black,
                          onpress: () async {
                            try {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NavigationBBar(),
                                  ),
                                );
                              });
                            } catch (e) {
                              setState(() {
                                // ShowSpinar=false;
                              });
                              print(e);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
