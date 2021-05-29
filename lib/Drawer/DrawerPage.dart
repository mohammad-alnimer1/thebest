import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/AppSharedPrefs.dart';
import 'package:thebest/AppHelper/AppString.dart';
import 'package:thebest/Navigation/NavigationBar.dart';
import 'package:thebest/homepage.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

import 'AboutData.dart';
import 'ContactUs.dart';
import 'PrivacyPolicyPage.dart';
import 'ServicesPage.dart';
import 'SettingsPage.dart';
import 'TermsAndConditions.dart';
import 'aboutVision.dart';
import 'blogspage.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  // Future<bool> _onWillPop() async {
  //   return (await showDialog(
  //       context: context,
  //       builder: (context) =>   Directionality(
  //         textDirection: TextDecoration.
  //         child:  AlertDialog(
  //           title:   Text('${AppController.strings.alertExitTitle}'),
  //
  //           content:   Text('${AppController.strings.exitapp}'),
  //           actions: <Widget>[
  //             FlatButton(
  //               onPressed: () => Navigator.of(context).pop(false),
  //               child:   Text('${AppController.strings.no}'),
  //             ),
  //             FlatButton(
  //               onPressed: () {
  //                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => registration()));
  //               } ,
  //               //exit(0) ,//Navigator.of(context).pop(true),
  //               child:   Text('${AppController.strings.yes}'),
  //             ),
  //           ],
  //         ),)
  //   )) ??
  //       false;
  // }
  bool loading = true;

  String name = ' ';
  String email = ' ';



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppController.textDirection,
      child: Drawer(
          child: Padding(
        padding:
            const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 8.5, left: 8.5),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, bottom: 0.0, right: 8.5, left: 8.5),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60.0,
                      child: Image.asset(
                        'images/Logo.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black26,
                    height: 10,
                    thickness: 2,
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height* 0.03,),
                  ListTile(
                    title: Text('${AppController.strings.home}',
                        style: TextStyle(fontSize: 20)),
                    leading: Icon(
                      Icons.home,
                      size: 30,
                    ),
                    contentPadding: EdgeInsets.all(10),
                    onTap: () {
                      var Backdrawer = false;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigationBBar(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('${AppController.strings.services}',
                        style: TextStyle(fontSize: 20)),
                    leading: Icon(
                      Icons.assignment_rounded,
                      size: 30,
                    ),
                    contentPadding: EdgeInsets.all(10),
                    onTap: () {
                      bool back = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServicesPage(
                            back: back,
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('${AppController.strings.blogs}',
                        style: TextStyle(fontSize: 20)),
                    leading: Icon(
                      Icons.create_outlined,
                      size: 30,
                    ),
                    contentPadding: EdgeInsets.all(10),
                    onTap: () {
                      bool back = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => blogs(
                            back: back,
                          ),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.black26,
                    height: 10,
                    thickness: 2,
                  ),
                  ExpansionTileCard(
                    title: Text('${AppController.strings.Changelanguage}'),
                    leading: Icon(
                      Icons.settings,
                      size: 30,
                    ),
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                            title:Text('English'),
                            onTap: () {
                              setState(() {
                                AppController.textDirection = TextDirection.rtl;
                                AppController.strings = EnglishString();
                                AppSharedPrefs.saveMainLangInSP(true);
                                AppSharedPrefs.saveLangType('En');
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NavigationBBar(),
                                    ));
                              });
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                              title: Text('العربية') ,
                              onTap: () {
                                setState(() {
                                  AppController.textDirection = TextDirection.ltr;
                                  AppController.strings = ArabicString();
                                  AppSharedPrefs.saveMainLangInSP(true);
                                  AppSharedPrefs.saveLangType('Ar');
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NavigationBBar(),
                                      ));
                                });
                              })),
                    ],
                  ),
                  Divider(
                    color: Colors.black26,
                    height: 10,
                    thickness: 2,
                  ),

                  ListTile(
                    title: Text('${AppController.strings.contactUs}',
                        style: TextStyle(fontSize: 20)),
                    leading: Icon(
                      Icons.local_phone_sharp,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactUs(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('${AppController.strings.about}',
                        style: TextStyle(fontSize: 20)),
                    leading: Icon(
                      Icons.info,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutData(),
                        ),
                      );
                    },
                  ),

                  Divider(
                    color: Colors.black26,
                    height: 10,
                    thickness: 2,
                  ),
              ListTile(
                    title: Text('${AppController.strings.terms}',
                        style: TextStyle(fontSize: 20)),
                    leading: Icon(
                      Icons.admin_panel_settings_rounded,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                   builder: (context) => TermsConditions(),
                        ),
                      );
                    },
                  ),
              ListTile(
              title: Text('${AppController.strings.PrivacyPolicy}',
                        style: TextStyle(fontSize: 20)),
              leading: Icon(
                      Icons.privacy_tip_outlined,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                   builder: (context) => PrivacyPolicy(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
