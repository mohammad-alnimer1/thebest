import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:thebest/Navigation/NavigationBar.dart';

import 'AppHelper/AppController.dart';
import 'AppHelper/AppSharedPrefs.dart';
import 'AppHelper/AppString.dart';
import 'LanguagePageMain.dart';
import 'homepage.dart';

void main()  {
  runApp(MyApp());
  var languageState;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  var languageState;
  langState()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
        languageState = preferences.getString("lng");
        if(languageState=='Ar'){
          AppController.strings = ArabicString();
        }else if(languageState=='En') {
          AppController.strings = EnglishString();
        }

    });
  }
  @override
  void initState() {
    langState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Best',
      home:languageState=='Ar'||languageState=='En'?NavigationBBar() :LangpageMain(),
    );
  }
}
