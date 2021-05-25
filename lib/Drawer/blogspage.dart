
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/networking.dart';
import 'package:thebest/api/Api.dart';

import 'blogDiscription.dart';

class blogs extends StatefulWidget {
  blogs({this.back});
final back;
  @override
  _blogsState createState() => _blogsState();
}

class _blogsState extends State<blogs> {

  bool loading = true;
  var mainblogs;
  List datablogs;

  Future<dynamic> getblogCAt() async {
    try{
   NetworkHelper networkHelper = NetworkHelper('${Api().baseURL}blogs/en');
   mainblogs = await networkHelper.getdata();
   setState(() {
     datablogs = mainblogs;
   });
   print(datablogs);
   }catch(e){
   print(e);
   }}
  @override
  void initState() {
    super.initState();
    getblogCAt();
    langState();
  }

  var languageState;


  void langState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    languageState = preferences.getString("lng");
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: AppController.textDirection,
        //textDirection: AppController.textDirection,
        //debugShowCheckedModeBanner: false,
        child: Scaffold(
          backgroundColor: Color(0xFFf33BE9F),
      appBar: widget.back==false?AppBar(backgroundColor: Color(0xFFf33BE9F),centerTitle: true,title: Text('${AppController.strings.blogs}'),):null,
      body:datablogs!=null? ListView.builder(
        itemCount:datablogs.length ,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 180,
                      backgroundImage: NetworkImage("${ Api().baseImgURL + datablogs[index]['Images']}"),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      languageState=='Ar'? Padding(
                      padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '${datablogs[index]['TitleAr']}',
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ):Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          '${datablogs[index]['TitleEn']}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      languageState=='Ar'? Container(
          height: 60,
          padding: const EdgeInsets.all(5.0),
          child: Text(
          '${datablogs[index]['DescriptionAr']}',
          style: TextStyle(fontSize: 15, ),
          ),
          ): Container(
                        height: 60,
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          '${datablogs[index]['DescriptionEn']}',
                          style: TextStyle(fontSize: 15, ),
                        ),
                      ),
                      RaisedButton(
                        child: Text(
                          '${AppController.strings.ReadMore}',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        onPressed: () {
                          var DescriptionAr='${datablogs[index]['DescriptionAr']}';
                          var DescriptionEn='${datablogs[index]['DescriptionEn']}';
                          var TitleAr='${datablogs[index]['TitleAr']}';
                          var TitleEn='${datablogs[index]['TitleEn']}';
                          var Images="${ Api().baseImgURL + datablogs[index]['Images']}";

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlogDisc(DescriptionAr:DescriptionAr ,DescriptionEn: DescriptionEn,Images:Images ,TitleEn:TitleEn ,TitleAr: TitleAr,),
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
                  )
                  ),
                ],
              ),
              height: 150,
            ),
          );
        },
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
                  child: loading
                      ? Center(
                      child: Text(
                          '${AppController.strings.PleaseWait}'))
                      : Center(
                    child: Text(
                      '${AppController.strings.NoServices}',
                      style: TextStyle(
                          fontSize: 18, color: Colors.black87),
                    ),
                  )),
            ],
          )
      ),),
    ));
  }
}
