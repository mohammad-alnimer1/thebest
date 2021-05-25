// import 'dart:async';
// import 'dart:convert';
// import 'package:contactus/contactus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:najahni/AppHelper/AppColors.dart';
//  import 'package:najahni/AppHelper/AppController.dart';
// import 'package:najahni/AppHelper/AppSize.dart';
// import 'package:najahni/Model/CompInfo.dart';
// import 'package:najahni/api/Api.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:social_buttons/social_buttons.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
// import 'package:modal_progress_hud/modal_progress_hud.dart';
//
//
// class ContactUsPage extends StatefulWidget {
//   @override
//   _ContactUsState createState() => _ContactUsState();
// }
//
// class _ContactUsState extends State<ContactUsPage> {
//
//   bool loading=true;
//
//   Completer<GoogleMapController> _controller = Completer();
//
//   void _onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//   }
//
//   _launchURLWhatsApp() async {
//      String  url =
//         'https://api.whatsapp.com/send?phone=+962${ContactWhatsapp}&text=Hi Naga7ny..!';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//   _launchURLYouTube() async {
//     const url =
//         'https://youtube.com';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   String address="";
//   String email="";
//   String phone="";
//   String website="";
//   String ContactWhatsapp="";
//   List<CompInfo> _contactUs;
//
//   Future<List<CompInfo>> TACFun() async {
//     try {
//
//       var map = Map<String, dynamic>();
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       map['lang'] = preferences.getString('lng');
//       final response = await http.post(Api().baseURL + 'getContactUs.php', body: map);
//
//       if (200 == response.statusCode) {
//         List<CompInfo> list = parseResponse(response.body);
//         return list;
//       } else {
//         return List<CompInfo>();
//       }
//     } catch (e) {
//       return List<CompInfo>(); // return an empty list on exception/error
//     }
//   }
//   static List<CompInfo> parseResponse(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<CompInfo>((json) => CompInfo.fromJson(json)).toList();
//   }
//
//   _getContactUs() {
//     TACFun().then((compinfo) {
//       setState(() {
//         loading=false;
//         _contactUs = compinfo;
//        });
//       if (compinfo.length != 0) {
//         address=_contactUs[0].address;//=null ? "" : _contactUs[0].address;
//         email=_contactUs[0].email ;//=null ? "" : _contactUs[0].email ;
//         phone=_contactUs[0].phone;//=null ? "" : _contactUs[0].phone;
//         website=_contactUs[0].website;//=null ? "" : _contactUs[0].website;
//         ContactWhatsapp=_contactUs[0].ContactWhatsapp;//=null ? "" : _contactUs[0].website;
//       } else {
//         print('Not Correct');
//         viewToast();
//       }
//       print("Length ${compinfo.length}");
//     });
//   }
//   // final _companynameController = TextEditingController();
//   // final _companyAddressController = TextEditingController();
//   // final _companyTelController = TextEditingController();
//   // final _companyFaxController = TextEditingController();
//   // final _companyEmailController = TextEditingController();
//   // final _companyWebsiteController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     // application.onLocaleChanged = onLocaleChange;
//     // _getSharedPreferences();
//     _getContactUs();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//    // double width=MediaQuery.of(context).size.width * 0.9;
//
//     return Directionality(
//       textDirection: AppController.textDirection,
//       child: Scaffold(
//         //   debugShowCheckedModeBanner: false,
//         appBar: AppBar(
//           backgroundColor: AppColors.primaryColor,
//
//           flexibleSpace: Container(
//            // decoration: BoxDecoration(gradient: AppConstants().mainColors()),
//           ),
//             leading: new IconButton(
//               icon: new Icon(Icons.arrow_back, color: Colors.white),
//               onPressed: () =>    Navigator.pop(context),),
//           title: Text(AppController.strings.contactUs),
//         ),
//         backgroundColor: Colors.white,
//         body:ModalProgressHUD(
//           inAsyncCall: loading ,
//           child: ListView(
//             children: [
//               Align(
//                 alignment: Alignment.topRight,
//                 child: Column(
//                   children: [
//                     SizedBox(height: 50,),
//                     CircleAvatar(
//                       backgroundColor: Colors.white,
//                       radius: 70.0,
//                       child: Image.asset('icons/logo.png'),
//                     ),
//                     SizedBox(height: 50,),
//                     Divider(),
//                     _drawContact( Icons.location_pin, address),
//                     _drawContact( Icons.email, email),
//                     _drawContact( Icons.phone_in_talk, phone),
//                     _drawContact( Icons.language, website),
//                     Divider(),
//
//                     Container(
//                       color: Colors.white,
//                       child: Center(
//                        // child: Padding(
//                          // padding: const EdgeInsets.all(20.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Container(
//                                 height: AppSize.appWidth(context)*.08,
//                                 child: GestureDetector (
//                                     child: Hero(
//                                       tag: 'll',
//                                       child: Image.asset(
//                                         'icons/whatsapp.png',
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       _launchURLWhatsApp();
//                                       // Navigator.push(context, MaterialPageRoute(builder: (_) {
//                                       //   return DetailScreen();
//                                     }
//                                 ),),
//                               SocialButtons(
//                                   items: [
//                                     // SocialButtonItem(
//                                     //     socialItem: socialItems.website,
//                                     //     itemColor: Colors.blue[400],
//                                     //     itemSize: 225.0,
//                                     //     url: "https://youtube.com"),
//                                     SocialButtonItem(
//                                         socialItem: socialItems.instagram,
//                                         itemColor: Colors.pink[800],
//                                         itemSize: 30.0,
//                                         url: "https://www.instagram.com/"),
//                                     SocialButtonItem(
//                                         socialItem: socialItems.facebook,
//                                         itemColor: Colors.blue[900],
//                                         itemSize: 30.0,
//                                         url: "https://www.facebook.com/"),
//                                     SocialButtonItem(
//                                         socialItem: socialItems.snapchat,
//                                         itemColor: Colors.yellow[700],
//                                         itemSize: 30.0,
//                                         url: "https://www.google.com/")
//                                   ],
//                                 ),
//                               Container(
//                                 height: AppSize.appWidth(context)*.08,
//
//                                 child: GestureDetector (
//                                     child: Hero(
//                                       tag: 'nn',
//                                       child: Image.asset(
//                                         'icons/youtube.png',
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       _launchURLYouTube();
//                                       // Navigator.push(context, MaterialPageRoute(builder: (_) {
//                                       //   return DetailScreen();
//                                     }
//                                 ),),
//                             ],
//                          // ),
//                         ),
//                       ),
//                     ),
//
//
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Future viewToast() {
//     return Fluttertoast.showToast(
//         msg: AppController.strings.wrongPhoneOrPassword,
//         toastLength: Toast.LENGTH_SHORT,
//         // gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }
//
//   Widget _drawContact(IconData icon,String txtDesc){
//     return    Center(
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Row(
//             children: <Widget>[
//               Icon(icon,color:AppColors.primaryColor ,),
//               SizedBox(width: 10,),
//               InkWell(
//                 child: Text(
//                   txtDesc,
//                   // style:
//                   // TextStyle(color: AppColors.blackColor,decoration: TextDecoration.underline,),
//                   style: TextStyle(color: AppColors.blackColor),
//                 ),
//                 onTap: () {
//                 },
//               ),
//
//             ]),
//       ),
//     );
//   }
// }
