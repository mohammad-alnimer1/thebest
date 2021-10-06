
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/networking.dart';
import 'package:thebest/api/Api.dart';

class AboutVision extends StatefulWidget {
  @override
  _AboutVisionState createState() => _AboutVisionState();
}

class _AboutVisionState extends State<AboutVision> {


  var DescriptionAr;
  var DescriptionEn;
  var TitleAr;
  var TitleEn;
  var Images;
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
    getaboutvision();
  }

  bool loading=true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    data!=null?  ListView.builder(
         itemCount: data.length,
         itemBuilder:(context, index) {
         return Container(
           padding: EdgeInsets.only(bottom: 30,right: 20,left: 20,top: 30),
           height: 500,
           child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             Expanded(
               child: CircleAvatar(
                 backgroundColor: Colors.white,
                 radius: 180,
                 backgroundImage: NetworkImage('${Api().baseImgURL+aboutvision[index]['Images']}'),
             ),),
             Padding(
               padding: const EdgeInsets.all(5.0),
               child: Text(
                 '${data[index]['TitleEn']}',
                 style: TextStyle(
                     fontSize: 17, fontWeight: FontWeight.bold),
               ),
             ),
             Expanded(child: Text('${data[index]['DescriptionEn']}')),
           Divider(thickness: 3,color: Colors.blue,)
           ],
         ),);
       },):
      Container(height: double.infinity,child:  ModalProgressHUD(
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
          )),),


      );
  }
}
