import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/AppSharedPrefs.dart';
import 'package:thebest/AppHelper/AppString.dart';
import 'package:thebest/AppHelper/networking.dart';
import 'package:thebest/api/Api.dart';

class ourclientsPage extends StatefulWidget {
  @override
  _ourclientsPageState createState() => _ourclientsPageState();
}

class _ourclientsPageState extends State<ourclientsPage> {


  List Listpartner;
  var partner;

  Future<dynamic> getpartner() async {
    NetworkHelper networkHelper =
    NetworkHelper('${Api().baseURL}getpartner/en');
    partner = await networkHelper.getdata();
    setState(() {
      Listpartner = partner;
    });
  }

  bool loading = true;

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
    langState();
    getpartner();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: AppController.textDirection,
        //textDirection: AppController.textDirection,
        //debugShowCheckedModeBanner: false,
        child: Scaffold(
          backgroundColor:Color(0xFFf33BE9F) ,
            appBar: AppBar(
              backgroundColor: Color(0xFFf33BE9F),
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${AppController.strings.ourclients}',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: Listpartner!=null?   GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: Listpartner.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5,
                mainAxisSpacing: 15,
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1),
              ),
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 4,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 180,
                          backgroundImage: NetworkImage(
                              Api().baseImgURL + Listpartner[index]['Images']),
                        ),
                      ),
                      Listpartner[index]['TitleAr']!=null|| Listpartner[index]['TitleEn']!=null?
                      Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  languageState == 'Ar'
                                      ? Listpartner[index]['TitleAr']
                                      : Listpartner[index]['TitleEn'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                            ],
                          )):Container(),
                    ],
                  ),
                );
              },
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
            ),));
  }
}
