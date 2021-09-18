
import 'package:concentric_transition/page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/networking.dart';
import 'package:thebest/api/Api.dart';
import 'Navigation/NavigationBar.dart';

class entrypage extends StatefulWidget {
  @override
  _entrypageState createState() => _entrypageState();
}

class PageData {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color textColor;
  final Function fun;

  PageData({
    this.title,
    this.icon,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
    this.fun
  });
}


class _entrypageState extends State<entrypage> {
  var Email;
  var Title;

  var data;

  Future<dynamic> getaboutUs() async {
    NetworkHelper networkHelper =
    NetworkHelper('${Api().baseURL}webpage/en?id=75');
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
    NetworkHelper networkHelper =
    NetworkHelper('${Api().baseURL}webpage/en?id=74');
    phonedata = await networkHelper.getdata();
    setState(() {
      titlephone = phonedata['DescriptionAr'];

      phone = phonedata['TitleEn'];

      print(Email);
      return data;
    });
  }

  var tate;

  void State() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isshow',true);
    print('languageState');
    print(tate);
  }

  @override
  void initState() {
    super.initState();
    getaboutUs();
    getPhone();
    State();

  }


  List<Color> get colors => pages.map((p) => p.bgColor).toList();

  final List<PageData> pages = [
    PageData(
      icon: Icons.format_size,
      title: "Welcome to \n The Best",
      textColor: Colors.white,
      bgColor: Color(0xFFFDBFDD),

    ),
    PageData(
      icon: Icons.hdr_weak,
      title: "services  and bloges \n and more",
      bgColor: Color(0xFFFFFFFF),
    ),
    PageData(
        icon: Icons.bubble_chart,
        title: "find what you \n want ",
        bgColor: Color(0xFF0043D0),
        textColor: Colors.white,
        fun:  (context){

        }
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: AppController.textDirection,
        //textDirection: AppController.textDirection,
        //debugShowCheckedModeBanner: false,
        child: Scaffold(
            backgroundColor: Color(0xFFf33BE9F),
            body: Directionality(
              textDirection: TextDirection.ltr,
              child:ConcentricPageView(

                onFinish: (){

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationBBar()));
                },
                colors: colors,
//          opacityFactor: 1.0,
//          scaleFactor: 0.0,
                radius: 30,
                curve: Curves.ease,
                duration: Duration(seconds: 2),
//          verticalPosition: 0.7,
//          direction: Axis.vertical,
//          itemCount: pages.length,
//          physics: NeverScrollableScrollPhysics(),
                itemBuilder: (index, value) {
                  PageData page = pages[index % pages.length];
                  // For example scale or transform some widget by [value] param
                  //            double scale = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
                  return Container(
                    child: Theme(
                      data: ThemeData(
                        textTheme: TextTheme(
                          headline6: TextStyle(
                            color: page.textColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Helvetica',
                            letterSpacing: 0.0,
                            fontSize: 17,
                          ),
                          subtitle2: TextStyle(
                            color: page.textColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      child: PageCard(page: page),
                    ),
                  );
                },
              ),)));
  }

}
class PageCard extends StatelessWidget {
  final PageData page;

  const PageCard({
    this.page,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Column(

        children: <Widget>[
          _buildPicture(context),
          SizedBox(height: 30),
          _buildText(context),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(
      page.title,
      style: Theme.of(context).textTheme.headline6,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPicture(
      BuildContext context, {
        double size = 190,
        double iconSize = 170,
      }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(60.0)),
        color: page.bgColor

            .withGreen(page.bgColor.green + 20)
            .withRed(page.bgColor.red - 100)
            .withAlpha(90),
      ),
      margin: EdgeInsets.only(
        top: 140,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: RotatedBox(
              quarterTurns: 2,
              child: Icon(
                page.icon,
                size: iconSize + 20,
                color: page.bgColor
                    .withBlue(page.bgColor.blue - 10)
                    .withGreen(220),
              ),
            ),
            right: -5,
            bottom: -5,
          ),
          Positioned.fill(
            child: RotatedBox(
              quarterTurns: 5,
              child: Icon(
                page.icon,
                size: iconSize + 20,
                color: page.bgColor.withGreen(66).withRed(77),
              ),
            ),
          ),
          Icon(
            page.icon,
            size: iconSize,
            color: page.bgColor.withRed(111).withGreen(220),
          ),
        ],
      ),
    );
  }
}