import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/AppSharedPrefs.dart';
import 'package:thebest/AppHelper/AppString.dart';
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
    try {
      NetworkHelper networkHelper = NetworkHelper('${Api().baseURL}blogs/en');
      mainblogs = await networkHelper.getdata();
      setState(() {
        datablogs = mainblogs;
      });
      print(datablogs);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getblogCAt();
    langState();
  }

  var languageState;
  void langState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (languageState == 'Ar') {
      AppController.strings = ArabicString();
    } else if (languageState == 'En') {
      AppController.strings = EnglishString();
    }
    languageState = preferences.getString("lng");
    print(languageState);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: languageState == "Ar"
            ? TextDirection.ltr
            : TextDirection.rtl,
        //textDirection: AppController.textDirection,
        //debugShowCheckedModeBanner: false,
        child: Scaffold(
          backgroundColor: Color(0xFFf33BE9F),
          appBar: widget.back == false
              ? AppBar(
                  backgroundColor: Color(0xFFf33BE9F),
                  centerTitle: true,
                  title: Text('${AppController.strings.blogs}'),
                )
              : null,
          body: datablogs != null
              ? ListView.builder(
         itemCount: datablogs.length, itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [

                        Expanded(
                          flex: 3,
                          child:     ClipOval(
                            child: Image.network(
                              "${Api().baseImgURL + datablogs[index]['Images']}",
                              fit: BoxFit.fill,
                              height: 150,
                              width: 150,
                            )),),
                            // CircleAvatar(
                            //
                            //   backgroundColor: Colors.white,
                            //   backgroundImage: NetworkImage(
                            //   ),
                            //   maxRadius: 70,
                            //
                            // ),
                            Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [

                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.08,
                                      width: MediaQuery.of(context).size.width *
                                          0.60,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          languageState != 'Ar'
                                              ? '${datablogs[index]['TitleEn']}'
                                              : '${datablogs[index]['TitleAr']}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          textAlign: languageState == "Ar"
                                              ? TextAlign.right
                                              : TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.11,
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          languageState != "Ar"
                                              ? '${datablogs[index]['DescriptionEn']}'
                                              : '${datablogs[index]['DescriptionAr']}',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: languageState == "Ar"
                                              ? TextAlign.right
                                              : TextAlign.left,
                                        )),
                                    RaisedButton(
                                      child: Text(
                                        '${AppController.strings.ReadMore}',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      onPressed: () {
                                        var DescriptionAr =
                                            '${datablogs[index]['DescriptionAr']}';
                                        var DescriptionEn =
                                            '${datablogs[index]['DescriptionEn']}';
                                        var TitleAr =
                                            '${datablogs[index]['TitleAr']}';
                                        var TitleEn =
                                            '${datablogs[index]['TitleEn']}';
                                        var Images =
                                            "${Api().baseImgURL + datablogs[index]['Images']}";

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BlogDisc(
                                              DescriptionAr: DescriptionAr,
                                              DescriptionEn: DescriptionEn,
                                              Images: Images,
                                              TitleEn: TitleEn,
                                              TitleAr: TitleAr,
                                            ),
                                          ),
                                        );
                                      },
                                      color: Colors.black,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side:
                                              BorderSide(color: Colors.black)),
                                    )
                                  ],
                                )),
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
