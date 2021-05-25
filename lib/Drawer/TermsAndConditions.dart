import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:thebest/AppHelper/AppController.dart';

class TermsConditions extends StatefulWidget {
  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppController.textDirection,
      //textDirection: AppController.textDirection,
      //debugShowCheckedModeBanner: false,
      child: Scaffold(
          backgroundColor: Color(0xFFf33BE9F),
          appBar: AppBar(
            backgroundColor: Color(0xFFf33BE9F),
            centerTitle: true,
            title: Text(AppController.strings.terms),
          ),
          body: ModalProgressHUD(
            inAsyncCall: loading,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Directionality(
                textDirection: AppController.textDirection,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'TermsConditions',
                      textAlign: TextAlign.left,

                      //AppController.strings.terms,
                      style: new TextStyle(fontSize: 25.0, color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 10.0,
                      child: Center(
                        child: Text(
                          'Wraps platform-specific persistent storage for simple data (NSUserDefaults on iOS and macOS, SharedPreferences on Android, etc.). Data may be persisted to disk asynchronously, and there is no guarantee that writes will be persisted to disk after returning, so this plugin must not be used for storing critical data.',

                         textAlign: TextAlign.left,
                          maxLines: 500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

// class _TermsAndCondState extends State<TermsAndCond> {
//   bool loading = true;
//   String TAC="";
//   List<CompInfo> _TandC;
//
//   Future<List<CompInfo>> TACFun() async {
//     try {
//       var map = Map<String, dynamic>();
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       map['lang'] = preferences.getString('lng');
//       final response = await http.post(Api().baseURL + 'getTermsAndCond.php', body: map);
//       if (200 == response.statusCode) {
//         List<CompInfo> list = parseResponse(response.body);
//         return list;
//       } else {
//         return List<CompInfo>();
//       }
//     } catch (e) {
//       return List<CompInfo>(); // return an empty list on exception/error
//     }
//   }
//
//   static List<CompInfo> parseResponse(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<CompInfo>((json) => CompInfo.fromJson(json)).toList();
//   }
//
//   _getTAC() {
//     TACFun().then((compinfo) {
//       setState(() {
//         _TandC = compinfo;
//         loading=false;
//       });
//
//       if (compinfo.length != 0) {
//         TAC=compinfo[0].termsandcond;
//
//       } else {
//         print('Not Correct');
//
//       }
//       print("Length ${compinfo.length}");
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _getTAC();
//   }
