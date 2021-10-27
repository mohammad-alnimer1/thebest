import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as https;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share/share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppSharedPrefs.dart';
import 'package:thebest/AppHelper/AppString.dart';
import 'package:thebest/Login_Page.dart';

import 'AppHelper/AppController.dart';
import 'AppHelper/networking.dart';
import 'Drawer/Constants.dart';
import 'api/Api.dart';

class DetailsPage extends StatefulWidget {
  final id;
  DetailsPage({this.id});
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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

  bool loading = true;
  bool loading1 = true;
  var servicesDetails;

  Future<dynamic> getdetails(int id) async {
    try {
      NetworkHelper networkHelper = NetworkHelper(
          'http://mohamadfaqeh-001-site37.itempurl.com/api/mobile/webpage/en?id=${widget.id}');
      servicesDetails = await networkHelper.getdata();

      setState(() {
        print(servicesDetails.runtimeType);
        print('daaaaaaaaaaaaaaaaaaaaaatttttttaaaaaaa+${servicesDetails}');
      });
    } catch (e) {
      print(e);
    }
  }

  List comm;

  Future<dynamic> getAllComment(int id) async {
    try {
      NetworkHelper networkHelper = NetworkHelper(
          'http://mohamadfaqeh-001-site37.itempurl.com/api/mobile/allcommentservices/en?serviceid=${widget.id}');
      comm = await networkHelper.getdata();

      setState(() {
        print(comm.runtimeType);
        loading1 = false;
        return comm;
      });
      print('cooooooooooooooommmmmmm+${comm.toString()}');
      print('cooooooooooooooommmmmmm+${comm[0]['Email']}');
    } catch (e) {
      print(e);
    }
  }

  var thankpage;
  Future<dynamic> getthankpage() async {
    try {
      NetworkHelper networkHelper =
          NetworkHelper('${Api().baseURL}thankpage/en');
      thankpage = await networkHelper.getdata();

      setState(() {
        print(thankpage);
        loading1 = false;
        return thankpage;
      });
    } catch (e) {
      print(e);
    }
  }

  GlobalKey<FormState> commentKey = new GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  static final TextEditingController CommentController =
      TextEditingController();

  Future<dynamic> senddata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("Name");
    String email = prefs.getString("Email");
    var url =
        'http://mohamadfaqeh-001-site37.itempurl.com/api/mobile/addcomment';
    var commentdata = commentKey.currentState;
    if (commentdata.validate()) {
      var dataToSend = {
        "ServiceID": widget.id.toString(),
        "Description": CommentController.text,
        "Title": name.toString(),
        "Email": email.toString()
      };
      print('))))))))))))))))');
      https.Response response = await https.post(url, body: dataToSend);
      if (response.statusCode == 200) {
        String data = response.body;
        print('hi hi hi hi hi hi  data ${data}');
        setState(() {
          if (mounted) jsonEncode(data);
        });
      } else {
        print(response.statusCode);
      }
    }
  }

  Future<dynamic> sendrequest() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("Name");
    String email = prefs.getString("Email");
    var url =
        'http://mohamadfaqeh-001-site37.itempurl.com/api/mobile/insertadvuser';
    var dataToSend = {
      "Phone": "000000000",
      "Title": name.toString(),
      "Email": email.toString()
    };
    print('))))))))))))))))');
    https.Response response = await https.post(url, body: dataToSend);
    if (response.statusCode == 200) {
      String data = response.body;
      print('hi hi hi hi hi hi  data ${data}');
      setState(() {
        if (mounted) jsonEncode(data);
      });
    } else {
      print(response.statusCode);
    }
  }

  String validdata(String val) {
    if (val.trim().isEmpty) {
      return "${AppController.strings.fillDataError}";
    }
  }

  bool userIsLoggedIn = false;

  getLoggedInState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      userIsLoggedIn = preferences.getBool('isLogin');
    });
    print(userIsLoggedIn);
    print('userIsLoggedIn');
  }

  @override
  void initState() {
    super.initState();
    widget.id;
    getdetails(widget.id);
    getAllComment(widget.id);
    langState();
    getLoggedInState();
  }

  // _onShare(BuildContext context) async {
  //   // A builder is used to retrieve the context immediately
  //   // surrounding the ElevatedButton.
  //   //
  //   // The context's `findRenderObject` returns the first
  //   // RenderObject in its descendent tree when it's not
  //   // a RenderObjectWidget. The ElevatedButton's RenderObject
  //   // has its position and size after it's built.
  //   final RenderBox box = context.findRenderObject() as RenderBox;
  //
  //
  //     await Share.shareFiles(imagePaths,
  //         text: text,
  //         subject: subject,
  //         sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  //   }

  _onShareWithEmptyOrigin(BuildContext context) async {
    if (Platform.isAndroid) {
      await Share.share(
          "https://play.google.com/store/apps/details?id=servesApp.thebest");
    } else {
      await Share.share("https://apps.apple.com/us/app/the-best/id1573635575");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: AppController.textDirection,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF8973d9),
            elevation: 0,
            centerTitle: true,
          ),
          backgroundColor: Color(0xFF04b2d9),
          body: servicesDetails != null && servicesDetails.isNotEmpty
              ? ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      languageState != 'Ar'
                                          ? Text(
                                              '${servicesDetails['TitleEn']}',
                                              style: TextStyle(fontSize: 22))
                                          : Text(
                                              '${servicesDetails['TitleAr']}',
                                              style: TextStyle(fontSize: 22)),
                                    ],
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.black45,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white,
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: Image.network(
                                            '${Api().baseImgURL + servicesDetails['Images']}',
                                            fit: BoxFit.fill,
                                          )))),
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    languageState != 'Ar'
                                        ? "${servicesDetails['DescriptionEn']}"
                                        : "${servicesDetails['DescriptionAr']}",
                                    style: TextStyle(fontSize: 18),
                                    textAlign: languageState == "Ar"
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  )),
                              // Container(
                              //   padding: EdgeInsets.all(16),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       InkWell(
                              //           onTap: () {},
                              //           child: Text(
                              //             '< Previous Post',
                              //             style: TextStyle(color: Colors.blue, fontSize: 16),
                              //           )),
                              //       InkWell(
                              //           onTap: () {},
                              //           child: Text(' Next Post>',
                              //               style:
                              //                   TextStyle(color: Colors.blue, fontSize: 16)))
                              //     ],
                              //   ),
                              // )
                              userIsLoggedIn == null || userIsLoggedIn == false
                                  ? Container()
                                  : ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          sendrequest().then((value) => Alert(
                                              context: context,
                                              type: AlertType.success,
                                              title:
                                                  "${AppController.strings.Submittedsuccessfully}",
                                              desc:
                                                  "${AppController.strings.assoon}",
                                              buttons: [
                                                DialogButton(
                                                  child: Text(
                                                    "${AppController.strings.ok}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  width: 120,
                                                )
                                              ],
                                              style: AlertStyle(
                                                titleStyle:
                                                    TextStyle(fontSize: 18),
                                                isCloseButton: false,
                                                animationDuration:
                                                    Duration(milliseconds: 400),
                                              )).show());
                                        });
                                      },
                                      child: languageState != 'Ar'
                                          ? Text('Request the service now',
                                              style: TextStyle(fontSize: 22))
                                          : Text('أطلب الخدمة الان',
                                              style: TextStyle(fontSize: 22)),
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${AppController.strings.Comments}',
                                    textAlign: languageState == "Ar"
                                        ? TextAlign.right
                                        : TextAlign.left,
                                    style: TextStyle(fontSize: 22)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.black45,
                                ),
                              ),
                              Container(
                                height: 300,
                                child: comm.isNotEmpty || comm == null
                                    ? ListView.separated(
                                        shrinkWrap: true,
                                        itemCount: comm.length,
                                        separatorBuilder: (context, index) =>
                                            Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Divider(
                                            thickness: 1,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black38)),
                                                          child: Icon(
                                                            Icons.person,
                                                            size: 40,
                                                            color:
                                                                Colors.black26,
                                                          )),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  bottom: 8,
                                                                  top: 8),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.60,
                                                                child: Text(
                                                                  "${comm[index]['Title']}  ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  "${comm[index]['Email']}  ",
                                                                ),
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.60,
                                                              )
                                                            ],
                                                          )),
                                                    ],
                                                  )),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${comm[index]['Description']}",
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    : Container(
                                        height: double.infinity,
                                        child: ModalProgressHUD(
                                            color: Colors.white12,
                                            inAsyncCall: loading1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                    child: loading1
                                                        ? Center(
                                                            child: Text(
                                                                '${AppController.strings.pleaseWait}'))
                                                        : Center(
                                                            child: Text(
                                                              '${AppController.strings.NoComment}',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black87),
                                                            ),
                                                          )),
                                              ],
                                            )),
                                      ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.black45,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Form(
                                  key: commentKey,
                                  child:
                                      userIsLoggedIn == null ||
                                              userIsLoggedIn == false
                                          ? Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Container(
                                                color: Colors.black12,
                                                child: TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        bool loginback = true;

                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    LogInPage(
                                                              loginback:
                                                                  loginback,
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                    },
                                                    child: Text(
                                                      '${AppController.strings.LoginCommented}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 18,
                                                      ),
                                                    )),
                                              ),
                                            )
                                          : Container(
                                              padding: EdgeInsets.all(16),
                                              child: ExpansionTileCard(
                                                title: Text(
                                                    '${AppController.strings.LeaveComment}'),
                                                children: [
                                                  // Padding(
                                                  //   padding: EdgeInsets.all(10),
                                                  //   child: TextFormField(
                                                  //       controller: nameController,
                                                  //       textAlign: TextAlign.center,
                                                  //       validator: validdata,
                                                  //       decoration:
                                                  //           KDecoration.copyWith(
                                                  //         labelText:
                                                  //             '${AppController.strings.EnteryourName}',
                                                  //       )),
                                                  // ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.all(10),
                                                  //   child: TextFormField(
                                                  //       controller: emailController,
                                                  //       textAlign: TextAlign.center,
                                                  //       keyboardType:
                                                  //           TextInputType.emailAddress,
                                                  //       validator: validdata,
                                                  //       decoration: KDecoration.copyWith(
                                                  //           labelText:
                                                  //               '${AppController.strings.EnteryourEmail}')),
                                                  // ),
                                                  Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: TextFormField(
                                                        controller:
                                                            CommentController,
                                                        maxLines: 5,
                                                        textAlign:
                                                            TextAlign.center,
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        validator: validdata,
                                                        decoration: KDecoration
                                                            .copyWith(
                                                                labelText:
                                                                    '${AppController.strings.writComment}')),
                                                  ),
                                                  MaterialButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          if (commentKey
                                                              .currentState
                                                              .validate()) {
                                                            if (userIsLoggedIn ==
                                                                    null ||
                                                                userIsLoggedIn ==
                                                                    false) {
                                                              _showMaterialDialog(
                                                                  textcontent:
                                                                      '${AppController.strings.LoginCommented}',
                                                                  textTitle:
                                                                      '${AppController.strings.noteLogin}',
                                                                  function: [
                                                                    FlatButton(
                                                                      child: Text(
                                                                          '${AppController.strings.login}'),
                                                                      onPressed:
                                                                          () {
                                                                        bool
                                                                            loginback =
                                                                            true;
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                LogInPage(
                                                                              loginback: loginback,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    )
                                                                  ]);
                                                            } else {
                                                              senddata();
                                                              //Navigator.push(context, MaterialPageRoute(builder: (BuildContextcontext) => super.widget));
                                                              getthankpage().then((value) =>
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder: (_) => new AlertDialog(
                                                                          title: Container(
                                                                            child:
                                                                                Icon(
                                                                              FontAwesomeIcons.solidCheckCircle,
                                                                              size: 50,
                                                                              color: Colors.greenAccent,
                                                                            ),
                                                                          ),
                                                                          content: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                            Center(
                                                                              child: languageState != 'Ar'
                                                                                  ? Text(
                                                                                      '${thankpage['TitleEn']}',
                                                                                      style: TextStyle(fontSize: 22),
                                                                                      textAlign: TextAlign.center,
                                                                                    )
                                                                                  : Text(
                                                                                      '${thankpage['TitleAr']}',
                                                                                      style: TextStyle(fontSize: 22),
                                                                                      textAlign: TextAlign.center,
                                                                                    ),
                                                                            ),

                                                                            new Center(
                                                                              child: languageState != 'Ar'
                                                                                  ? Text(
                                                                                      '${thankpage['DescriptionEn']}',
                                                                                      style: TextStyle(fontSize: 19),
                                                                                      textAlign: TextAlign.center,
                                                                                    )
                                                                                  : Text(
                                                                                      '${thankpage['DescriptionAr']}',
                                                                                      style: TextStyle(fontSize: 19),
                                                                                      textAlign: TextAlign.center,
                                                                                    ),
                                                                            ),
                                                                            ElevatedButton(
                                                                              child: Text('${AppController.strings.ok}'),
                                                                              onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContextcontext) => super.widget)), // passing true
                                                                            ),
                                                                            SizedBox(
                                                                              height: 40,
                                                                            ),
                                                                            GestureDetector(
                                                                              child: Text('${AppController.strings.share}'),
                                                                              onTap: () {
                                                                                _onShareWithEmptyOrigin(context);
                                                                              },
                                                                            ), // passing true
                                                                          ]))));
                                                              nameController
                                                                  .clear();
                                                              emailController
                                                                  .clear();
                                                              CommentController
                                                                  .clear();
                                                            }
                                                          }
                                                        });
                                                      },
                                                      color: Color(0xFF04b2d9),
                                                      child: Text(
                                                        '${AppController.strings.send}',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      ))
                                                ],
                                              )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
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

  _showMaterialDialog(
      {BuildContext context,
      String textTitle,
      String textcontent,
      List<Widget> function}) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: Center(child: new Text(textTitle)),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(FontAwesomeIcons.checkCircle),
                  ),
                  new Text(
                    textcontent,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: function,
            ));
  }
}
//
//
