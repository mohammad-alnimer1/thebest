import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs {
  static String spIsLoginKey = 'isLogin';
  static String spLangKey = 'Lang';
  static String spEmailKey = 'Email';
  static String spPhoneKey = 'Phone';
  static String spAddressKey = 'Address';
  static String spIdKey = 'userId';
  static String spNameKey = 'name';
  static String spImgKey = 'img';
  static String doneLangMain = 'mainLang';
  static String langType = 'lng';
  static String isEmpKey = 'isEmp';
  static String onBoard = 'onBoard';
  static String notificationOn = 'notificationOn';
  static String isShow ='isshow';


  static Future<bool> saveIsShow(bool isshow) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(isShow, isshow);
  }

  static Future<bool> saveLangInSP(bool lang) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(spLangKey, lang);
  }

  static Future<bool> saveMainLangInSP(bool langMain) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(doneLangMain, langMain);
  }

  static Future<bool> saveIsLoginSP(bool isLogin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(spIsLoginKey, isLogin);
  }

  static Future<bool> saveEmailSP(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spEmailKey, email);
  }

  static Future<bool> savePhoneSP(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spPhoneKey, email);
  }

  static Future<bool> saveAddressSP(String address) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spAddressKey, address);
  }

  static Future<bool> saveIdSP(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spIdKey, id);
  }

  static Future<bool> saveNameSP(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spNameKey, name);
  }

  static Future<bool> saveImgSP(String img) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spImgKey, img);
  }

  static Future<bool> saveLangType(String lang) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(langType, lang);
  }

  static Future<bool> saveEmpSP(bool isInst) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(isEmpKey, isInst);
  }

  static Future<bool> saveonBoard(bool onboard) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(onBoard, onboard);
  }

  static Future<bool> saveNotificationOn(bool notiOn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(notificationOn, notiOn);
  }
}
