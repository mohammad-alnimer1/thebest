import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/AppSharedPrefs.dart';
import 'package:thebest/AppHelper/AppString.dart';

class BlogDisc extends StatefulWidget {
  final DescriptionAr;
  final DescriptionEn;
  final TitleAr;
  final TitleEn;
  final Images;
  BlogDisc(
      {this.DescriptionAr,
      this.DescriptionEn,
      this.Images,
      this.TitleAr,
      this.TitleEn});

  @override
  _BlogDiscState createState() => _BlogDiscState();
}




class _BlogDiscState extends State<BlogDisc> {


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


  @override
  void initState() {
    super.initState();
    setState(() {
      langState();

    });
  }

  @override
  Widget build(BuildContext context) {
    return  Directionality(
        textDirection: AppController.textDirection,
        //textDirection: AppController.textDirection,
        //debugShowCheckedModeBanner: false,
        child: Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF04b2d9),centerTitle: true,
        title:   languageState!='Ar'? Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          '${widget.TitleEn}',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ): Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          '${widget.TitleAr}',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),),

      body: Container(
        padding: EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 30),
        height: MediaQuery.of(context).size.height*1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 180,
                backgroundImage: NetworkImage(widget.Images),
              ),
            ),
            languageState!='Ar'? Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '${widget.TitleEn}',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ): Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '${widget.TitleAr}',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
             Expanded(
                 flex: 2,
                 child:ListView(
               children: [
                Text( languageState!='Ar'? widget.DescriptionEn:widget.DescriptionAr,
                  textAlign: languageState == "Ar"
                      ? TextAlign.right
                      : TextAlign.left,
                )
               ],
             )),
            Divider(
              thickness: 2,
              color: Colors.blue,
            )
          ],
        ),
      ),
    ));
  }
}
