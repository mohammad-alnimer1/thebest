import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/AppSharedPrefs.dart';
import 'package:thebest/AppHelper/AppString.dart';
import 'package:thebest/AppHelper/networking.dart';
import 'package:thebest/api/Api.dart';

import '../SubCategory.dart';

class ServicesPage extends StatefulWidget {
  ServicesPage({this.back});
  final back;
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  var mainCat;
  List data;

  Future<dynamic> getMainCAt() async {
    try {
      NetworkHelper networkHelper =
          NetworkHelper('${Api().baseURL}allservicescategory/en');
      mainCat = await networkHelper.getdata();
      setState(() {
        print(mainCat.runtimeType);

        data = mainCat;
      });
    } catch (e) {
      print(e);
    }
  }

  var languageState;

  // void langState() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //
  //   if (AppController.strings is ArabicString||languageState=='null'){
  //     AppSharedPrefs.saveLangType('Ar');
  //     languageState = preferences.getString("lng");
  //   }else{
  //     AppSharedPrefs.saveLangType('En');
  //   }
  //   print(languageState);
  // }
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
    getMainCAt();
    langState();
  }

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: AppController.textDirection,
        child: Scaffold(
          appBar: widget.back == false
              ? AppBar(
                  backgroundColor: Color(0xFF8973d9),
                  centerTitle: true,
                  title: Text('${AppController.strings.services}'),
                )
              : null,
          backgroundColor: Color(0xFF04b2d9),
          body: data != null
              ? ListView(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 25,
                        mainAxisSpacing: 35,
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.2),
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          child: InkWell(
                            onTap: () {
                              var name = mainCat[index]['TitleAr'];
                              var nameEN = mainCat[index]['TitleEn'];
                              int id = data[index]['PagesID'];
                              print('id id id id id ${id}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubCategory(
                                    id: id,
                                    name: name,
                                    nameEN: nameEN,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 180,
                                    backgroundImage: NetworkImage(
                                        Api().baseImgURL +
                                            data[index]['Images']),
                                  ),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        languageState != 'Ar'
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  data[index]['TitleEn'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  data[index]['TitleAr'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                        RaisedButton(
                                          child: Text(
                                            '${AppController.strings.viewServices}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            var name =
                                                mainCat[index]['TitleAr'];
                                            var nameEN =
                                                mainCat[index]['TitleEn'];
                                            int id = data[index]['PagesID'];
                                            ;
                                            print('id id id id id ${id}');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SubCategory(
                                                  name: name,
                                                  nameEN: nameEN,
                                                  id: id,
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
                            ),
                          ),
                        );
                      },
                    )
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
                              child: loading
                                  ? Center(
                                      child: Text(
                                          '${AppController.strings.pleaseWait}'))
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
                ),
        ));
  }
}
