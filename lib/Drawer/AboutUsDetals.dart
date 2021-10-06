import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppColors.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/AppSharedPrefs.dart';
import 'package:thebest/AppHelper/AppString.dart';
import 'package:thebest/AppHelper/networking.dart';
import 'package:thebest/api/AllFunGet.dart';
import 'package:thebest/api/Api.dart';
import 'package:thebest/module/AboutUs_Model.dart';
import 'package:http/http.dart' as https;
import 'package:cached_network_image/cached_network_image.dart';

class AboutUsDetails extends StatefulWidget {
  final DescriptionEn;
  final DescriptionAr;
  final TitleAr;
  final TitleEn;
  final Images;
  AboutUsDetails(
      {this.DescriptionAr,
      this.DescriptionEn,
      this.TitleEn,
      this.Images,
      this.TitleAr});
  @override
  _AboutUsDetailsState createState() => _AboutUsDetailsState();
}

class _AboutUsDetailsState extends State<AboutUsDetails> {
  var languageState;

  void langState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      if (AppController.strings is ArabicString||languageState=='null'){
        AppSharedPrefs.saveLangType('Ar');
        languageState = preferences.getString("lng");
      }else{
        AppSharedPrefs.saveLangType('En');
      }
    });
    print(languageState);
  }

  bool loading = true;

  // Future getdata() async{
  //   http.Response response= await http.get('');
  //
  //   setState(() {
  //     loading=true;
  //   });
  //   try{
  //
  //   if (response.statusCode==200){
  //     setState(()  {
  //     String data=  response.body;
  //      aboutus =   jsonDecode(data)['DescriptionEn'];
  //     TitleEn =  jsonDecode(data)['TitleEn'];
  //     Images1 = jsonDecode(data)['Images']as String ;
  //     print(aboutus);
  //     print(Images1);
  //   });
  //     setState(() {
  //       loading=false;
  //     });
  // }else{
  //    print(response.statusCode);
  //    loading=true;
  //  }
  // }catch(e){
  //   print(e);
  //   setState(() {
  //     loading=false;
  //   });
  // }
  //  }
  // print(response.body);

  @override
  void initState() {
    super.initState();
    langState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: AppController.textDirection,
        //debugShowCheckedModeBanner: false,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Color(0xFF8973d9),
              title: languageState != 'Ar'
                  ? Text('${widget.TitleEn}')
                  : Text('${widget.TitleAr}'),
              flexibleSpace: Container(
                  // decoration: BoxDecoration(
                  //     gradient: AppConstants().mainColors()),
                  ),
            ),
            backgroundColor: Colors.white,
            body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Directionality(
                    textDirection: AppController.textDirection,
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: 30, right: 20, left: 20, top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 180,
                              backgroundImage: NetworkImage('${widget.Images}'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: languageState != 'Ar'
                                ? Text(
                                    '${widget.TitleEn}',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    '${widget.TitleAr}',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                          Expanded(
                              child: ListView(
                            children: [
                              languageState != 'Ar'
                                  ? Text('${widget.DescriptionEn}')
                                  : Text('${widget.DescriptionAr}')
                            ],
                          )),
                          Divider(
                            thickness: 3,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    )))));
  }
}
