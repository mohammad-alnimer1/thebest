import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppSharedPrefs.dart';
import 'package:thebest/AppHelper/AppString.dart';

import 'AppHelper/AppController.dart';
import 'AppHelper/networking.dart';
import 'DetailsPage.dart';
import 'api/Api.dart';

class SubCategory extends StatefulWidget {
  final id;
  final name;
  final nameEN;
  SubCategory({this.id, this.name, this.nameEN});
  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  bool loading = true;
  var SubCat;
  List data;

  Future<dynamic> getSubCat(int id) async {
    try {
      NetworkHelper networkHelper =
      NetworkHelper('${Api().baseURL}serviceslist/en?id=${id = widget.id}');
      SubCat = await networkHelper.getdata();
      setState(() {
        print('hi hi hi hih ih hi hi id ${id}');
        print(SubCat.runtimeType);
        print(SubCat.toString());
        data = SubCat;
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }


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
  setState(() {
    widget.name;
    widget.nameEN;

    print('widget.name');
    // print('widget.name${widget.nameEN}');
    // print('widget.name${widget.name}');
    getSubCat(widget.id);
    langState();
  });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: AppController.textDirection,
        child: Scaffold(
          backgroundColor: Color(0xFFf33BE9F),
          appBar: AppBar(
            backgroundColor: Color(0xFFf33BE9F),
            elevation: 0,
            toolbarHeight: 70,
            centerTitle: true,
            title:languageState == 'Ar'? Text('${widget.name}')
                :Text('${widget.nameEN}') ,
          ),
          body: data != null && data.isNotEmpty
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.network(
                                '${Api().baseImgURL + data[index]['Images']}',
                              ),
                               Padding(
                                 padding: EdgeInsets.all(10),
                                 child:Center(child: Text(
                                   languageState != 'Ar'
                                       ?'${data[index]['TitleEn']}':'${data[index]['TitleAr']}',
                                 ),)
                               ),

                              Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(languageState != 'Ar' ? "${data[index]['DescriptionEn']}":"${data[index]['DescriptionAr']}",
                                        textAlign: languageState == "Ar"
                                          ? TextAlign.right
                                          : TextAlign.left,),
                                    ),

                              Container(
                                height: 50,
                                color: Colors.grey.shade200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        var id = data[index]['PagesID'];
                                        print(id);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailsPage(id: id,)),
                                        );
                                      },
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.search),
                                            Text(
                                                '${AppController.strings.details}')
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Container(
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
                                  ),
                          ),
                        ],
                      )),
                ),
        ));
  }
}
