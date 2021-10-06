import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/buttonClass.dart';
import 'package:thebest/AppHelper/location.dart';
import 'package:thebest/AppHelper/networking.dart';
import 'package:thebest/AppHelper/staticWidget.dart';
import 'package:thebest/api/Api.dart';
import 'package:http/http.dart' as http;

import 'Constants.dart';

class subscribe_Page extends StatefulWidget {
  @override
  _subscribe_PageState createState() => _subscribe_PageState();
}

class _subscribe_PageState extends State<subscribe_Page> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController companyNameController = new TextEditingController();
  TextEditingController AddressController = new TextEditingController();
  TextEditingController IndestryTypeController = new TextEditingController();
  TextEditingController SnapChatController = new TextEditingController();
  TextEditingController InstegramController = new TextEditingController();
  TextEditingController FacebookController = new TextEditingController();
  TextEditingController TwitterController = new TextEditingController();
  TextEditingController PhoneController = new TextEditingController();
  PanelController _pc2 = new PanelController();

  var lat=0.0;
  var  long=0.0;
  bool loading = true;
  bool loading1 = false;

  // var addcompany;
  // Future<dynamic> getpartner() async {
  //   NetworkHelper networkHelper = NetworkHelper('${Api().baseURL}addcompany');
  //   addcompany = await networkHelper.getdata();
  //   setState(() {
  //     addcompany;
  //   });
  // }

  String _currText = '';

  List<Marker> myMarker = [];
  _handleTap(LatLng TappedPint) {
    print(TappedPint);
    setState(() {
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(TappedPint.toString()),
        position: TappedPint,
      ));

      print('TappedPint.longitude');
      setState(() {
        long = TappedPint.longitude;
        lat = TappedPint.latitude;
      });
    });
  }

  Future<dynamic> getlocation() async {
    Location location = Location();
    await location.getcorrentlocation();
    setState(() {
      lat = location.latitude;
      long = location.longitude;
      loading = false;
    });
  }

  @override
  void initState() {
    setState(() {
      print('myMarker${myMarker}');
      getlocation().then((value) {
        if (long == null && lat == null) {
          long = 0.0;
          lat = 0.0;
          loading = false;
        }
      });

      _handleTap;
    });
    super.initState();
  }

  Future senddata() async {
    var _data;
    var result;

    var  registrationData = {
      'Name':companyNameController.text ,
      'Email': emailController.text,
      "Address": AddressController.text,
      "IndestryType": IndestryTypeController.text,
      "SnapChat": SnapChatController.text,
      "Instegram":InstegramController.text,
      "Facebook": FacebookController.text,
      "Twitter": TwitterController.text,
      "Lat": lat.toString(),
      "Long": long.toString(),
      "Phone": PhoneController.text,
      "DeviceId":"2eb36956f0f1565b",

    };
    var url ='${Api().baseURL}addcompany';

    dynamic response = await http.post(url, body: registrationData);



    print(response.body);

    if (response.statusCode == 200) {

      String jsonsDataString = response.body;

      _data = jsonDecode(jsonsDataString);

      print('hi hi hi hi hihi hi ${_data}');


    }

  }
  final RegistrationKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: AppController.textDirection,
        child: Form(
          key:   RegistrationKey  ,
          child: Scaffold(
            backgroundColor: Color(0xFF04b2d9),
            appBar: AppBar(
              backgroundColor: Color(0xFF8973d9),
              centerTitle: true,
              title: Text('${AppController.strings.subscribeService}'),
            ),
            body: Stack(
              children: [
                ListView(
                  children: [
                  Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                              autocorrect: false,
                              validator: staticWidget().validEmpty,
                              controller: emailController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {},
                              decoration: KDecoration.copyWith(
                                  labelStyle: TextStyle(fontSize: 18),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  labelText:
                                  '${AppController.strings.enterYourEmail}')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                              autocorrect: false,
                              validator: staticWidget().validEmpty,
                              controller: companyNameController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {},
                              decoration: KDecoration.copyWith(
                                  labelStyle: TextStyle(fontSize: 18),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  labelText:
                                  '${AppController.strings.companyName}')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                              autocorrect: false,
                              validator: staticWidget().validEmpty,
                              controller: AddressController,
                              textAlign: TextAlign.center,
                              onChanged: (value) {},
                              decoration: KDecoration.copyWith(
                                  labelStyle: TextStyle(fontSize: 18),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  labelText: '${AppController.strings.Address}')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                              autocorrect: false,
                              validator: staticWidget().validEmpty,
                              controller: IndestryTypeController,
                              textAlign: TextAlign.center,
                              onChanged: (value) {},
                              decoration: KDecoration.copyWith(
                                  labelStyle: TextStyle(fontSize: 18),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  labelText:
                                  '${AppController.strings.IndestryType}')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                              autocorrect: false,
                              controller: SnapChatController,
                              textAlign: TextAlign.center,
                              onChanged: (value) {},
                              decoration: KDecoration.copyWith(
                                  labelStyle: TextStyle(fontSize: 18),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  labelText:
                                  '${AppController.strings.SnapChat}')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                              autocorrect: false,
                              controller: InstegramController,
                              textAlign: TextAlign.center,
                              onChanged: (value) {},
                              decoration: KDecoration.copyWith(
                                  labelStyle: TextStyle(fontSize: 18),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  labelText:
                                  '${AppController.strings.Instegram}')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                              autocorrect: false,
                              controller: FacebookController,
                              textAlign: TextAlign.center,
                              onChanged: (value) {},
                              decoration: KDecoration.copyWith(
                                  labelStyle: TextStyle(fontSize: 18),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  labelText:
                                  '${AppController.strings.Facebook}')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                              autocorrect: false,
                              controller: TwitterController,
                              textAlign: TextAlign.center,
                              onChanged: (value) {},
                              decoration: KDecoration.copyWith(
                                  labelStyle: TextStyle(fontSize: 18),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  labelText: '${AppController.strings.Twitter}')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                              autocorrect: false,
                              validator: staticWidget().validEmpty,
                              controller: PhoneController,
                              textAlign: TextAlign.center,
                              onChanged: (value) {},
                              decoration: KDecoration.copyWith(
                                  labelStyle: TextStyle(
                                      fontSize: 18,
                                      decorationColor: Colors.black),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  labelText:
                                  '${AppController.strings.phoneNum}')),
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: button(
                            buttonName: '${AppController.strings.send}',
                            color: Colors.black,
                            onpress: () async {
                              try {
                                setState(() {
                                  RegistrationKey.currentState.save();
                                  // ShowSpinar=true;
                                  if (RegistrationKey.currentState.validate()){


                                  if (myMarker.isNotEmpty){
                                    senddata().then((value) =>loading1=false).then((value) {
                                      Fluttertoast.showToast(
                                          msg: "${AppController.strings.sendDone}",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Color(0xFFFFADAD),
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    });

                                  }else{
                                    Fluttertoast.showToast(
                                        msg: "${AppController.strings.ChooseyourLocation}",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Color(0xFFFFADAD),
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }
                                  }
                                });
                              } catch (e) {
                                setState(() {
                                  // ShowSpinar=false;
                                });
                                print(e);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],),
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
                                      target: LatLng(lat, long), zoom: 5),
                                  onTap: _handleTap,
                                  markers: Set.from(myMarker),
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: button(
                                buttonName: '${AppController.strings.send}',
                                color: Colors.black,
                                onpress: () async {
                                  _pc2.close();
                                },
                              ),
                            ),
                          ],
                        ))),
              ],),
          ),
        ));
  }
}
