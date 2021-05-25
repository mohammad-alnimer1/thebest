import 'package:thebest/AppHelper/networking.dart';

import 'Api.dart';

class Getdata {

  Future<dynamic> getaboutUs() async {
    NetworkHelper networkHelper = NetworkHelper('${Api().baseURL}aboutus/en');
    var AboutUsData = await networkHelper.getdata();
    return AboutUsData;
  }


  // Future<dynamic> getcityname(String cityname) async {
  //   var url = '$openweather?q=$cityname=&appid=$apikey&units=metric';
  //   NetworkHelper networkHelper = NetworkHelper(url);
  //   var weatherdata = await networkHelper.getdata();
  //   return weatherdata;
  // }

  // Future<dynamic> getlocationandweatherforecast() async {
  //
  //   NetworkHelper networkHelperforecast = NetworkHelper('http://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apikey&units=metric&lang=ar');
  //   var forecastweatherdata = await networkHelperforecast.getdata();
  //   return forecastweatherdata;
  // }
  //
  // dynamic getlocationandweatherforecastbyname(String cityname) {
  //   var url =
  //       'http://api.openweathermap.org/data/2.5/forecast?q=$cityname&appid=$apikey&units=metric&lang=ar';
  //   NetworkHelper networkHelper = NetworkHelper(url);
  //   var forcastweather = networkHelper.getdata();
  //   return forcastweather;
  // }

}