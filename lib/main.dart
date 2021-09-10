import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:thebest/Login_Page.dart';
import 'package:thebest/Navigation/NavigationBar.dart';

import 'AppHelper/AppController.dart';
import 'AppHelper/AppSharedPrefs.dart';
import 'AppHelper/AppString.dart';
import 'AppHelper/Provider.dart';
import 'LanguagePageMain.dart';
import 'entryPage.dart';
import 'homepage.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  var languageState;

  void langState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    languageState = preferences.getBool('isLogin');
    print('languageState');
    print(languageState);
  }

  @override
  void initState() {
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
      theme: ThemeData(fontFamily:'HappyMonkey-Regular' ),
      debugShowCheckedModeBanner: false,
      title: 'The Best',
      home: languageState==true ? NavigationBBar() : entrypage(),
    ));
  }
}
