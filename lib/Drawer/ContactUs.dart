
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/networking.dart';
import 'package:thebest/api/Api.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  var Email;
  var Title;

  var data;

  Future<dynamic> getaboutUs() async {
    NetworkHelper networkHelper = NetworkHelper('${Api().baseURL}webpage/en?id=75');
    data = await networkHelper.getdata();
    setState(() {
      Email = data['DescriptionAr'];

      Title = data['TitleAr'];

      print(Email);
      return data;
    });
  }
  var titlephone;
  var phone;
  var phonedata;
  Future<dynamic> getPhone() async {
    NetworkHelper networkHelper = NetworkHelper('${Api().baseURL}webpage/en?id=74');
    phonedata = await networkHelper.getdata();
    setState(() {
      titlephone = phonedata['DescriptionAr'];

      phone = phonedata['TitleEn'];

      print(Email);
      return data;
    });
  }
    @override
  void initState() {
    super.initState();
    getaboutUs();
    getPhone();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: AppController.textDirection,
        //textDirection: AppController.textDirection,
        //debugShowCheckedModeBanner: false,
        child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.pop(context);}),
            backgroundColor: Color(0xFFf33BE9F),
            centerTitle: true,
            title: Text('${AppController.strings.contactUs}'),),

          backgroundColor: Color(0xFFf33BE9F),
          body:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage('images/Logo.png'),
                ),

                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  height: 80,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.alternate_email),
                      ),
                      Text('  ${Title}   ',style: TextStyle(fontSize: 18),),
                      Text(': ${Email  } ',style: TextStyle(fontSize: 18),),

                    ],
                  ),
                ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  height: 80,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.phone),
                      ),
                      Text('${phone  } : ',style: TextStyle(fontSize: 18),),
                      Text('  ${titlephone}   ',style: TextStyle(fontSize: 18),),


                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  height: 80,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.web),
                      ),
                      Text('web site  :  ',style: TextStyle(fontSize: 18),),
                      Text('wwww.thebest.com',style: TextStyle(fontSize: 18),)
                    ],
                  ),
                ),
            ],
          ),
          ),
        )));
  }
}
