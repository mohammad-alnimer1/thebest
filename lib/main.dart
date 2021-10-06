import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/Navigation/NavigationBar.dart';

import 'AppHelper/AppController.dart';
import 'AppHelper/AppSharedPrefs.dart';
import 'AppHelper/AppString.dart';
import 'AppHelper/Provider.dart';
import 'entryPage.dart';
import 'entrypagess.dart';
import 'homepage.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  var State;


  var languageState;

  void langState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    languageState = preferences.getString('lng');
    print('languageState');
    print(languageState);

    if (languageState == null) {
      await AppSharedPrefs.saveLangType('Ar');
    }
    languageState = preferences.getString('lng');
    print(languageState);
    if (languageState == 'Ar') {
      setState(() {
        AppController.textDirection = TextDirection.rtl;
        AppController.strings = ArabicString();
      });
    } else {
      AppController.textDirection = TextDirection.ltr;
      AppController.strings = EnglishString();
    }
  }
  void State1() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    State = preferences.getBool('isLogin');
    print('languageState');
  }
  var isShow;

  void show() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isShow = preferences.getBool('isshow');
    print('isShow');
    print(isShow);
  }

  @override
  void initState() {
    State1();
    show();
    langState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: MaterialApp(
          theme:languageState == 'Ar'? ThemeData( fontFamily:'alfont_com_Air-Strip' ):ThemeData( fontFamily:'Nunito-Regular' ),
          debugShowCheckedModeBanner: false,
          title: 'The Best',
          home: EasySplashScreen(
            logo: Image.asset(
              'images/Logo.png',
                    fit: BoxFit.cover,
                    height: 150,
                    width: 150,
            ),
            title: Text(
              "the best",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Color(0xFF04b2d9),
            showLoader: true,
            navigator:State==true ? NavigationBBar() : entrypagess(),
            durationInSeconds: 5,
          )




        ));
  }
}
