import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:thebest/AppHelper/shared_preference.dart';
import 'package:thebest/Model/UserModel.dart';
import 'package:thebest/api/Api.dart';


enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}
class AuthProvider with ChangeNotifier {

  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;


  Future login(String email, String password) async {
    var result;

    var loginData = {

        'Email': email,
        'Password': password

    };
    var url ='${Api().baseURL}login';

    _loggedInStatus = Status.Authenticating;
    notifyListeners();
    dynamic response = await http.post(url, body: loginData);

      final  responseData = json.decode(response.body);
      if(responseData['ID']!=0){
        User authUser = User.fromJson(responseData);
        UserPreferences().saveUser(authUser);

        _loggedInStatus = Status.LoggedIn;
        notifyListeners();


        result = '1';
      } else{
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = '0';
    }

    return result;
  }

  Future register({String name, String Email, String Password, String Lat, String Long,}) async {
    var _data;
    var result;

    var  registrationData = {
        'Name': name,
        'Email': Email,
        'Password': Password,
        'Lat': Lat,
        'Long': Long,
    };
    var url ='${Api().baseURL}addusers';

    dynamic response = await http.post(url, body: registrationData);



    print(response.body);

    if (response.statusCode == 200) {

      String jsonsDataString = response.body;

      _data = jsonDecode(jsonsDataString);

      print('hi hi hi hi hihi hi ${_data}');

      notifyListeners();
      result = {'result': 'success', 'message': 'Login Successful', };
    }  else {

      notifyListeners();
      result = {
        'status': 'failure',
        'message': json.decode(response.body)['Login failure']
      };
    }
    return result;

  }



}