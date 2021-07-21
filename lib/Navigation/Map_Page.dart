import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/buttonClass.dart';

import '../Login_Page.dart';
import '../Registration.dart';

class Map_Page extends StatefulWidget {
  var long;
  var lat;
  Map_Page({this.long,this.lat});
  @override
  _Map_PageState createState() => _Map_PageState();
}

class _Map_PageState extends State<Map_Page> {


  @override
  void initState() {
    setState(() {
      _handleTap;
    widget.lat  ;
    widget.long ;
    });
    super.initState();
  }


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
        widget.long = TappedPint.longitude;
        widget.lat = TappedPint.latitude;
      });
      print('longitude${widget.long}');
      print('latitude${ widget.lat}');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:Container(
        child:  Padding(
          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 90),
          child: button(
            buttonName: '${AppController.strings.send}',
            color: Colors.black,
            onpress: () async {
              // Navigator.push(
              //         context, MaterialPageRoute(builder: (context) => RegistrationPage(Finallat: widget.lat ,Finallong: widget.long ,)));
              //

            },
          ),
        ),
      ),
      body: Container(child: GoogleMap(
      initialCameraPosition: CameraPosition(
          target:
          LatLng(widget.lat, widget.long),
          zoom: 5),
      onTap: _handleTap,
      markers: Set.from(myMarker),
    ),),);
  }
}



