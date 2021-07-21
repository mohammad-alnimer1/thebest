import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/shared_preference.dart';

import 'AppSharedPrefs.dart';



class AppConstants {

  bool isLogin = false;

  getLoggedInState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

      isLogin = preferences.getBool('isLogin');

    return isLogin;
  }

  Future logOutApp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await UserPreferences().removeUser();

    // AppSharedPrefs.saveIsLoginSP(false);
  }
}
