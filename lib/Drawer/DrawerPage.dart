
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/AppSharedPrefs.dart';
import 'package:thebest/AppHelper/AppString.dart';
import 'package:thebest/AppHelper/logOut.dart';
import 'package:thebest/AppHelper/networking.dart';
import 'package:thebest/AppHelper/shared_preference.dart';
import 'package:thebest/Model/UserModel.dart';
import 'package:thebest/Navigation/NavigationBar.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:thebest/api/Api.dart';
import 'subscribe_Page.dart';

import '../Login_Page.dart';
import 'AboutData.dart';
import 'ContactUs.dart';
import 'FAQPage.dart';
import 'PrivacyPolicyPage.dart';
import 'ServicesPage.dart';
import 'Setting_page.dart';
import 'SettingsPage.dart';
import 'TermsAndConditions.dart';
import 'aboutVision.dart';
import 'blogspage.dart';
import 'ourclientsPage.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (context) => Directionality(
                  textDirection: AppController.textDirection,
                  child: AlertDialog(
                    title: Text('${AppController.strings.alertExitTitle}'),
                    content: Text('${AppController.strings.exitapp}'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('${AppController.strings.no}'),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new NavigationBBar()));
                          AppConstants().logOutApp();
                        }, //exit(0) ,//Navigator.of(context).pop(true),
                        child: new Text('${AppController.strings.yes}'),
                      ),
                    ],
                  ),
                ))) ??
        false;
  }

  bool loading = true;

  String name ;
  String email ;

  bool userIsLoggedIn = false;

 Future getLoggedInState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userIsLoggedIn = preferences.getBool('isLogin');
       name = preferences.getString("Name");
       email = preferences.getString("Email");    });
    print(userIsLoggedIn);
    print('userIsLoggedIn');
    print('user.name${name}' );
    print('user.name${email}' );
  }

  UserPreferences  user = UserPreferences();
  @override
  void initState(){

    getLoggedInState();
    super.initState();
    getwelcomebannar();
  }
  var welcomebannar;

  Future getwelcomebannar() async {
    try {
      NetworkHelper networkHelper = NetworkHelper('${Api().baseURL}welcome?lang=en');
      welcomebannar = await networkHelper.getdata();
       setState(()  {
       return welcomebannar;
       });
    } catch (e) {
      print(e);
    }
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
                  welcomebannar!=null?  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60.0,
                      child:
                    Image.network('${Api().baseImgURL + welcomebannar['Images']}',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,)


                    ),
                  ):Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60.0,
                      child:  Container(
                        width: 100,
                        height: 100,
                        child:   CircularProgressIndicator(),
                      )


                    ),
                  ),
                  name!=null ?ListTile(
                    title:Center(child: Text('${name}',
                        style: TextStyle(fontSize: 20)),),
                    subtitle: Center(child: Text('${email}'),),
                    contentPadding: EdgeInsets.all(10),
                  ):Container(),
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
                  ListTile(
                    title: Text('${AppController.strings.subscribeService}',
                        style: TextStyle(fontSize: 20)),
                    leading: Icon(
                      Icons.assignment_turned_in_rounded,
                      size: 30,
                    ),
                    contentPadding: EdgeInsets.all(10),
                    onTap: () {
                      bool back = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => subscribe_Page(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.black26,
                    height: 10,
                    thickness: 2,
                  ),
                  userIsLoggedIn==false|| userIsLoggedIn==null?    ListTile(
                 title: Text('${AppController.strings.login}'),
                 leading: Icon(
                   Icons.login_outlined, size: 30,),
                 onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => LogInPage(),),);
                   },
               ):Container(),
                ExpansionTileCard(
                  title: Text('${AppController.strings.Changelanguage}'),
                  leading: Icon(Icons.language, size: 30,),
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text('English'),
                            onTap: () {
                              setState(() {
                                AppController.textDirection = TextDirection.ltr;
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
                              title: Text('العربية'),
                              onTap: () {
                                setState(() {
                                  AppController.textDirection =
                                      TextDirection.rtl;
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
                  userIsLoggedIn==true?
                  ListTile(
                    title: Text('${AppController.strings.Settings}'),
                    leading: Icon(
                      Icons.settings,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Setting_page(),
                        ),
                      );
                    },
                  ):Container(),
                  Divider(
                    color: Colors.black26,
                    height: 10,
                    thickness: 2,
                  ),
                  ListTile(
                    title: Text('${AppController.strings.ourclients}',
                    ),
                    leading: Icon(
                      Icons.assignment_ind_outlined,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ourclientsPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('${AppController.strings.contactUs}',
                    ),
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
                    ),
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
                    title: Text('${AppController.strings.FAQ}',
                    ),
                    leading: Icon(
                      Icons.question_answer_rounded,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FAQPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('${AppController.strings.terms}',
                    ),
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
                    ),
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
                  Divider(
                    color: Colors.black26,
                    height: 10,
                    thickness: 2,
                  ),

                  userIsLoggedIn==true?   ListTile(
                    title: Text(AppController.strings.logout,
                    ),
                    leading: Icon(
                      Icons.logout,
                      size: 30,
                    ),
                    contentPadding: EdgeInsets.all(10),
                    onTap: () {
                      setState(() {
                        _onWillPop();
                      });
                    },
                  ):Container(),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}


