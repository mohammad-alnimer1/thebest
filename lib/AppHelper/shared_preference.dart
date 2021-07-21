import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:thebest/Model/UserModel.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("ID", user.userId);
    prefs.setString("Name", user.name);
    prefs.setString("Email", user.email);
    prefs.setString("Long", user.Long.toString());
    prefs.setString("Lat", user.Lat.toString());
    prefs.setBool("isLogin", true);

    print("object prefere");
    print(user.userId);
    print(user.name);
    print(user.email);
    print(user.Long);
    print(user.Lat);


    return prefs.commit();
  }

  Future<User> getUser() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt("ID");
    String name = prefs.getString("Name");
    String email = prefs.getString("Email");
    String Long = prefs.getString("Long");
    String Lat = prefs.getString("Lat");
    bool isLogin = prefs.getBool("isLogin");
    print(isLogin);

    return User(
        userId: userId,
        name: name,
        email: email,
        Lat: Lat,
        Long: Long,
        islogin: isLogin
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("Name");
    prefs.remove("Email");
    prefs.remove("Long");
    prefs.remove("Lat");
    prefs.remove("ID");
    prefs.remove('isLogin');
  }


}
