import 'dart:convert';
import 'package:http/http.dart' as https;

class NetworkHelper {
  NetworkHelper(this.url,);
   final url;
   Future <dynamic> getdata()async{
     print(url);
     print('))))))))))))))))');
    https.Response response = await https.get(url);
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
