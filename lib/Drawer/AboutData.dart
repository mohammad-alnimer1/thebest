import 'dart:convert';

import 'package:flutter/cupertino.dart';
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

import 'AboutUsDetals.dart';
import 'Description.dart';

class AboutData extends StatefulWidget {
  @override
  _AboutDataState createState() => _AboutDataState();
}

class _AboutDataState extends State<AboutData> {
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
  var DescriptionAr;
  var DescriptionEn;
  var TitleAr;
  var TitleEn;
  var Images;
  var AboutUsData;

  Future<dynamic> getaboutUs() async {
    NetworkHelper networkHelper = NetworkHelper('${Api().baseURL}aboutus/en');
    AboutUsData = await networkHelper.getdata();
    setState(() {
      DescriptionAr = AboutUsData['DescriptionAr'];
      DescriptionEn = AboutUsData['DescriptionEn'];
      TitleAr = AboutUsData['TitleAr'];
      TitleEn = AboutUsData['TitleEn'];
      print(TitleEn);
      Images = AboutUsData['Images'];
      print(DescriptionAr);
      return AboutUsData;
    });
  }

  var DescriptionArVision;
  var DescriptionEnVision;
  var TitleArVision;
  var TitleEnVision;
  var ImagesVision;
  var aboutvision;
  List data;
  Future<dynamic> getaboutvision() async {
    NetworkHelper networkHelper = NetworkHelper('${Api().baseURL}aboutvision/en');
    aboutvision = await networkHelper.getdata();
    setState(() {
      print(aboutvision);
      data = aboutvision;
    });
  }



  @override
  void initState() {
    super.initState();
    setState(() {
      getaboutUs();
      langState();
      getaboutvision();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: AppController.textDirection,

        child: Scaffold(
            backgroundColor: Color(0xFF04b2d9),
            appBar: AppBar(
              backgroundColor: Color(0xFF8973d9),
              centerTitle: true,
              title: AboutUsData != null?languageState!='Ar'?Text('${TitleEn}'):Text('${TitleAr}'):Container(),
              flexibleSpace: Container(
                  // decoration: BoxDecoration(
                  //     gradient: AppConstants().mainColors()),
                  ),
            ),
            body: Padding(
                padding: const EdgeInsets.all(10.0),
            child:  AboutUsData != null||data!=null
                ? ListView(
              children: [
                Card(
                  child: Container(
                    child: Directionality(
            textDirection: languageState == "Ar"
            ? TextDirection.ltr
              : TextDirection.rtl,

              child:Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 180,
                                        backgroundImage: NetworkImage(
                                            "${Api().baseImgURL + Images}"),
                                      ),
                                    ),
                        Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child:Container(

                                            child: languageState!='Ar'?
                                          Text(
                                            '${TitleEn}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ):
                                          Text(
                                            '${TitleAr}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),)
                                        ),
                                        Container(
                                          height: 60,
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            languageState!='Ar'? '${DescriptionEn}':'${DescriptionAr}',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                            textAlign: languageState == "Ar"
                                                ? TextAlign.right
                                                : TextAlign.left,
                                          ),
                                        ),
                                        RaisedButton(
                                          child: Text(
                                            '${AppController.strings.ReadMore}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            var DescriptionAr= '${AboutUsData['DescriptionAr']}';
                                            var DescriptionEn = '${AboutUsData['DescriptionEn']}';
                                            var TitleAr = '${AboutUsData['TitleAr']}';
                                            var TitleEn = '${AboutUsData['TitleEn']}';
                                            var Images = "${Api().baseImgURL + AboutUsData['Images']}";

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AboutUsDetails(
                                                  DescriptionAr: DescriptionAr,
                                                  DescriptionEn: DescriptionEn,
                                                  Images: Images,
                                                  TitleEn: TitleEn,
                                                  TitleAr: TitleAr,
                                                ),
                                              ),
                                            );
                                          },
                                          color: Colors.black,
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                  color: Colors.black)),
                                        )
                                      ],
                                    )),
                      ],
                    )),
                    height: 150,
                  ),
                ),
                Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:data.length ,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return    Card(
                        child: Container(
                          child:Directionality(
                          textDirection: languageState == "Ar"
                          ? TextDirection.ltr
                              : TextDirection.rtl,

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 180,
                                  backgroundImage: NetworkImage("${ Api().baseImgURL + data[index]['Images']}"),
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child:Text(
                                          languageState!='Ar'?    '${data[index]['TitleEn']}':'${data[index]['TitleAr']}',
                                          style: TextStyle(
                                              fontSize: 15, fontWeight: FontWeight.bold),
                                          textAlign: languageState == "Ar"
                                              ? TextAlign.right
                                              : TextAlign.left,
                                                ),
                                              ),
                                              Container(
                                                height: 60,
                                                padding: const EdgeInsets.all(5.0),
                                                child: Text(languageState!='Ar'?
                                                  '${data[index]['DescriptionEn']}':'${data[index]['DescriptionAr']}',

                                                  style: TextStyle(fontSize: 15, ),
                                                  textAlign: languageState == "Ar"
                                                      ? TextAlign.right
                                                      : TextAlign.left,
                                                )
                                              ),
                                              RaisedButton(
                                                child: Text(
                                                  '${AppController.strings.ReadMore}',
                                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  var DescriptionAr='${data[index]['DescriptionAr']}';
                                                  var DescriptionEn='${data[index]['DescriptionEn']}';
                                                  var TitleAr='${data[index]['TitleAr']}';
                                                  var TitleEn='${data[index]['TitleEn']}';
                                                  var Images="${ Api().baseImgURL + data[index]['Images']}";

                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => Description(
                                                        DescriptionAr:DescriptionAr ,DescriptionEn: DescriptionEn,Images:Images ,TitleEn:TitleEn ,TitleAr: TitleAr,
                                                      ),
                                                    ),
                                                  );

                                                },
                                                color: Colors.black,
                                                elevation: 2,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    side: BorderSide(color: Colors.black)),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),),
                                  height: 150,
                                ),
                              );
                            },),)
                          ],
                        )
                : Container(
              height: double.infinity,
              child: ModalProgressHUD(
                  color: Colors.white12,
                  inAsyncCall: loading,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Expanded(
            child: loading ? Center(child: Text(
             '${AppController.strings.PleaseWait}'))
            : Center(
            child: Text(
            '${AppController.strings.NoServices}',
            style: TextStyle(
            fontSize: 18,
            color: Colors.black87),
                ),
                )),],
                )),
                ),
                )));
  }
}
