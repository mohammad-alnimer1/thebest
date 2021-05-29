import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:thebest/Navigation/NavigationBar.dart';

import 'AppHelper/AppController.dart';
import 'AppHelper/AppSharedPrefs.dart';
import 'AppHelper/AppString.dart';
import 'homepage.dart';

void main()  {
  runApp(MyApp());
  var languageState;

  void langState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (AppController.strings is ArabicString||languageState=='null'){
      AppSharedPrefs.saveLangType('Ar');
      languageState = preferences.getString("lng");
      languageState='Ar';
    }else{
      AppSharedPrefs.saveLangType('En');
    }
    print(languageState);
  }

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  var languageState;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Best',
      home: NavigationBBar(),
    );
  }
}
