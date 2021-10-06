import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/AppSharedPrefs.dart';
import 'package:thebest/AppHelper/AppString.dart';
import 'package:thebest/AppHelper/networking.dart';
import 'package:thebest/api/Api.dart';

class TermsConditions extends StatefulWidget {
  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  bool loading =true;
  @override
  void initState() {
    getTermsConditions();
    langState();
    super.initState();
  }

  var languageState;

  void langState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    languageState = preferences.getString("lng");
    if(languageState=='Ar'){
      AppController.strings = ArabicString();
    }else if(languageState=='En') {
      AppController.strings = EnglishString();
    }
    print(languageState);
  }
  var data;
  Future<dynamic> getTermsConditions() async {
    NetworkHelper networkHelper = NetworkHelper('${Api().baseURL}tearmcondition/en');
    data = await networkHelper.getdata();
    setState(() {
      loading=false;

      print(data);
      return data;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppController.textDirection,
      //textDirection: AppController.textDirection,
      //debugShowCheckedModeBanner: false,
      child: Scaffold(
          backgroundColor: Color(0xFF04b2d9),
          appBar: AppBar(
            backgroundColor: Color(0xFF8973d9),
            centerTitle: true,
            title: Text(AppController.strings.terms),
          ),
          body: data != null
              ?Padding(
            padding: const EdgeInsets.all(10.0),
            child: Directionality(
              textDirection: AppController.textDirection,
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  languageState != 'Ar'
                      ? Center(child: Text(
                    '${data['TitleEn']}',
                    textAlign: TextAlign.left,
                    //AppController.strings.terms,
                    style: new TextStyle(fontSize: 25.0, color: Colors.black),
                  ),): Center(child: Text(
                    '${data['TitleAr']}',
                    textAlign: TextAlign.left,
                    //AppController.strings.terms,
                    style: new TextStyle(fontSize: 25.0, color: Colors.black),
                  ),),


                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 10.0,
                    child: Center(
                      child: Text(
                        languageState != 'Ar'
                            ?  '${data['DescriptionEn']}': data['DescriptionAr'],
                        textAlign: languageState == "Ar"
                            ? TextAlign.right
                            : TextAlign.left,

                      )
                    ),
                  ),
                ],
              ),
            ),
          ):Container(
        height: double.infinity,
        child: ModalProgressHUD(
            color: Colors.white12,
            inAsyncCall: loading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: loading
                        ? Center(
                        child: Text(
                            '${AppController.strings.PleaseWait}'))
                        : Center(
                      child: Text(
                        '${AppController.strings.NoServices}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87),
                      ),
                    )),
              ],
            )),
      ),),
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
