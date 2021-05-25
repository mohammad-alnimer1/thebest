import 'dart:convert';
import 'package:http/http.dart ' as http;

class NetworkHelper {
  NetworkHelper(this.url,);
   final url;
   Future <dynamic> getdata()async{
     print(url);
     print('))))))))))))))))');
    http.Response response = await http.get(url);
     if (response.statusCode == 200) {
       String data = response.body;
       print('+++++++++++++++++++${data.runtimeType}');
      return jsonDecode(data);
     }
     else {
       print(response.statusCode);
     }

  }



}
