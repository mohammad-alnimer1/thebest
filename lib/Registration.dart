import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppHelper/AppController.dart';
import 'AppHelper/Provider.dart';
import 'AppHelper/buttonClass.dart';
import 'AppHelper/staticWidget.dart';
import 'Drawer/Constants.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

import 'Login_Page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();

  static String emailController;
  static String nameController;
  static String passwordController;

  var lat = 0.0;
  var long = 0.0;
  bool loading = true;
  bool loading1 = false;

  PanelController _pc2 = new PanelController();

  // Future<dynamic> getlocation() async {
  //   Location location = Location();
  //   await location.getcorrentlocation();
  //   setState(() {
  //     lat = location.latitude;
  //     long = location.longitude;
  //     loading = false;
  //   });
  // }

  List<Marker> myMarker = [];
  _handleTap(LatLng tappedPint) {
    print(tappedPint);
    setState(() {
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(tappedPint.toString()),
        position: tappedPint,
      ));

      print('TappedPint.longitude');
      setState(() {
        long = tappedPint.longitude;
        lat = tappedPint.latitude;
      });
    });
  }

  var languageState;
  langState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      languageState = preferences.getString("lng");
    });
  }

  @override
  void initState() {
    setState(() {
      langState();
      // getlocation().then((value) {
      //   if (long == null && lat == null) {
      //     long = 0.0;
      //     lat = 0.0;
      //     loading = false;
      //   }
      // });

      _handleTap;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    void registrationform() {
      if (formKey.currentState.validate()) {
        formKey.currentState.save();
        final successfulMessage = auth.register(
            Email: emailController.toString(),
            name: nameController.toString(),
            Password: passwordController.toString(),
            Long: long.toString(),
            Lat: lat.toString());
        loading1 = true;
        successfulMessage.then((response) {
          if (response['result'] == "success") {
            showPlatformDialog(
                context: context,
                builder: (_) => Directionality(
                      textDirection: AppController.textDirection,
                      child: BasicDialogAlert(
                        title: Text(AppController.strings.Note),
                        content:
                            Text(AppController.strings.ClientAccountcreated),
                        actions: <Widget>[
                          BasicDialogAction(
                            title: Text(AppController.strings.ok),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LogInPage()),
                                  (Route<dynamic> route) => false);
                            },
                          ),
                        ],
                      ),
                    ));
          } else {
            //   Navigator.of(context).pop();
            // show_dialogall(context,"filed","wrong email or password plese check");
          }
        });
      }
    }

    return Directionality(
        textDirection: AppController.textDirection,
        child: Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Color(0xFF04b2d9),
            ), //0xFF04b2d9
            backgroundColor: Color(0xFF04b2d9),
            // bottomNavigationBar:
            body: ModalProgressHUD(
                color: Colors.white12,
                inAsyncCall: loading1,
                child: SafeArea(
                  child: long != null && lat != null
                      ? Stack(
                          children: [
                            ListView(
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  maxRadius: 50,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                      child: Image.asset(
                                    'images/LOGO2.png',
                                    fit: BoxFit.cover,
                                    height: 150,
                                    width: 150,
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Container(
                                    color: Colors.black12.withOpacity(0.01),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Center(
                                              child: Text(
                                            '${AppController.strings.signUp}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 1),
                                          )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: TextFormField(
                                              validator:
                                                  staticWidget().namevalid,
                                              onSaved: (value) =>
                                                  nameController = value,
                                              // controller: nameController,
                                              textAlign: TextAlign.center,
                                              onChanged: (value) {},
                                              decoration: KDecoration.copyWith(
                                                  filled: true,
                                                  fillColor: Colors.white70,
                                                  labelText:
                                                      '${AppController.strings.enterFullName}',
                                                  labelStyle:
                                                      TextStyle(fontSize: 18))),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: TextFormField(
                                              validator:
                                                  staticWidget().emailvalid,
                                              onSaved: (value) =>
                                                  emailController = value,
                                              // controller: emailController,
                                              textAlign: TextAlign.center,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              onChanged: (value) {},
                                              decoration: KDecoration.copyWith(
                                                  filled: true,
                                                  fillColor: Colors.white70,
                                                  labelText:
                                                      '${AppController.strings.enterYourEmail}',
                                                  labelStyle:
                                                      TextStyle(fontSize: 18))),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: TextFormField(
                                              validator:
                                                  staticWidget().passwordValid,
                                              onSaved: (value) =>
                                                  passwordController = value,

                                              // controller: passwordController,
                                              textAlign: TextAlign.center,
                                              obscureText: true,
                                              onChanged: (value) {},
                                              decoration: KDecoration.copyWith(
                                                  filled: true,
                                                  fillColor: Colors.white70,
                                                  labelText:
                                                      '${AppController.strings.enterpassword}',
                                                  labelStyle:
                                                      TextStyle(fontSize: 18))),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            color: Colors.black12,
                                            child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) => Map_Page(lat:lat ,long: long,)));
                                                    _pc2.open();
                                                  });
                                                },
                                                child: Text(
                                                  '${AppController.strings.ChooseLocation}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: button(
                                          buttonName:
                                              '${AppController.strings.signUp}',
                                          color: Colors.black,
                                          onpress: registrationform,
                                          // onpress: () async {
                                          //   try {
                                          //     setState(() {
                                          //       RegistrationKey.currentState
                                          //           .save();
                                          //       // ShowSpinar=true;
                                          //       Registrationform().then(
                                          //           (value) =>
                                          //               loading1 = false);
                                          //       // if (myMarker.isNotEmpty) {
                                          //       // } else {
                                          //       //   Fluttertoast.showToast(
                                          //       //       msg:
                                          //       //           "${AppController.strings.ChooseyourLocation}",
                                          //       //       toastLength:
                                          //       //           Toast.LENGTH_SHORT,
                                          //       //       gravity:
                                          //       //           ToastGravity.BOTTOM,
                                          //       //       timeInSecForIosWeb: 1,
                                          //       //       backgroundColor:
                                          //       //           Color(0xFFFFADAD),
                                          //       //       textColor: Colors.white,
                                          //       //       fontSize: 16.0);
                                          //       // }
                                          //     });
                                          //   } catch (e) {
                                          //     setState(() {
                                          //       // ShowSpinar=false;
                                          //     });
                                          //     print(e);
                                          //   }
                                          // },
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${AppController.strings.alreadyHaveAccount} ',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  '${AppController.strings.login}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SlidingUpPanel(
                                minHeight: 0.9,
                                controller: _pc2,
                                isDraggable: false,
                                renderPanelSheet: true,
                                header: Container(
                                  child: IconButton(
                                      icon: Icon(Icons.arrow_circle_down),
                                      onPressed: () {
                                        _pc2.close();
                                      }),
                                ),
                                panel: Center(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        color: Colors.blueAccent,
                                        height: 300,
                                        child: GoogleMap(
                                          initialCameraPosition: CameraPosition(
                                              target: LatLng(lat, long),
                                              zoom: 5),
                                          onTap: _handleTap,
                                          markers: Set.from(myMarker),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      child: button(
                                        buttonName:
                                            '${AppController.strings.send}',
                                        color: Colors.black,
                                        onpress: () async {
                                          _pc2.close();
                                        },
                                      ),
                                    ),
                                  ],
                                ))),
                          ],
                        )
                      : Container(
                          height: double.infinity,
                          child: Card(
                            child: ModalProgressHUD(
                                opacity: 0.5,
                                inAsyncCall: loading,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Center(
                                            child: Text(
                                                '${AppController.strings.pleaseWait}'))),
                                  ],
                                )),
                          ),
                        ),
                )),
          ),
        ));
  }

  // _showCupertinoDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (_) => new CupertinoAlertDialog(
  //         title: new Text("Cupertino Dialog"),
  //         content: new Text("Hey! I'm Coflutter!"),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text('Close me!'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           )
  //         ],
  //       ));
  // }

  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("${AppController.strings.Note}"),
              content:
                  new Text("${AppController.strings.ClientAccountcreated}"),
              actions: <Widget>[
                FlatButton(
                  child: Text('${AppController.strings.ok}'),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                )
              ],
            ));
  }
}
