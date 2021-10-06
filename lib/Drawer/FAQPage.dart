import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/AppString.dart';
import 'package:thebest/AppHelper/networking.dart';
import 'package:thebest/api/Api.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  List FAQ;
  Future<dynamic> getaboutvision() async {
    NetworkHelper networkHelper =
        NetworkHelper('${Api().baseURL}getallfaqs/en');
    FAQ = await networkHelper.getdata();
    setState(() {
      print(FAQ);
      FAQ;
    });
  }
  bool loading = true;

  var languageState;

  void langState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    languageState = preferences.getString("lng");
    if (languageState == 'Ar') {
      AppController.strings = ArabicString();
    } else if (languageState == 'En') {
      AppController.strings = EnglishString();
    }
    print(languageState);
  }
  @override
  void initState() {
    super.initState();
    getaboutvision();
    langState();
  }
  final List<GlobalKey<ExpansionTileCardState>> cardKeyList = [];

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: AppController.textDirection,
        child: Scaffold(
          backgroundColor: Color(0xFF04b2d9),
          appBar: AppBar(
            backgroundColor: Color(0xFF8973d9),
            centerTitle: true,
            title: Text('${AppController.strings.FAQ}'),
            flexibleSpace: Container(
                // decoration: BoxDecoration(
                //     gradient: AppConstants().mainColors()),
                ),
          ),
          body:
          FAQ!=null?  ListView.builder(
            padding:EdgeInsets.only(bottom: 50),
            itemCount: FAQ.length,
            itemBuilder: (context, index) {
              cardKeyList.add(GlobalKey(debugLabel: "index :$index"));

              return   Container(child:

              ExpansionTileCard(
              baseColor:Color(0xFF04b2d9) ,
                key: cardKeyList[index],
                onExpansionChanged: (value) {
                  if (value) {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      for (var i = 0; i < cardKeyList.length; i++) {
                        if (index != i) {
                          cardKeyList[i].currentState?.collapse();
                        }
                      }
                    });
                  }
                },
                title: Text(
                  languageState == 'Ar'
                      ? '${FAQ[index]['TitleAr']} '
                      : '${FAQ[index]['TitleEn']} ',
                  style: TextStyle(fontSize: 20,),

                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child:  Text(
                      languageState == 'Ar'
                          ? '${FAQ[index]['DescriptionAr']} '
                          : '${FAQ[index]['DescriptionEn']} ',

                    ),
                  ),
                ],
              ),width: 150,);
            },)
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
                          fontSize: 18,
                          color: Colors.black87),
                    ),
                  )),
            ],
          )),
    ),));
  }
}
