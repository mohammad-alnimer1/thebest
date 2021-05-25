import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppController.dart';

class Description extends StatefulWidget {

  final DescriptionAr; final DescriptionEn; final TitleAr; final TitleEn;final Images;
  Description({this.DescriptionAr, this.DescriptionEn, this.Images, this.TitleAr, this.TitleEn});

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {


  var languageState;


  void langState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      languageState = preferences.getString("lng");

    });
  }

  @override
  void initState() {
    super.initState();
    langState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Directionality(
        textDirection: AppController.textDirection,
        child:
      Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf33BE9F),
        centerTitle: true,
        title: languageState=='Ar'? Text(widget.TitleAr):Text(widget.TitleEn),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 30, right: 20, left: 20, top: 30),
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 180,
                backgroundImage: NetworkImage(widget.Images),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: languageState=='Ar'?Text(
                '${widget.TitleAr}',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ):Text(
                '${widget.TitleEn}',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child:languageState=='Ar'?Text(widget.DescriptionAr): Text(widget.DescriptionEn)),
            Divider(
              thickness: 3,
              color: Colors.blue,
            )
          ],
        ),
      ),
    ));
  }
}
