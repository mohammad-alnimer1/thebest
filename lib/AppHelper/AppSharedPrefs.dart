import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs {
  static String spLangKey = "Lang";
  static String doneLangMain = "mainLang";
  static String langType = "lng";

  static Future<bool> saveLangInSP(bool lang) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(spLangKey, lang);
  }

  static Future<bool> saveMainLangInSP(bool langMain) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(doneLangMain, langMain);
  }

  static Future<bool> saveLangType(String lang) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(langType, lang='Ar');
  }
}
