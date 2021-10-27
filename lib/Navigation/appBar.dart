import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thebest/AppHelper/networking.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarM extends StatefulWidget {
  @override
  _AppBarMState createState() => _AppBarMState();
}

class _AppBarMState extends State<AppBarM> {
  var facebookurl;
  Future<dynamic> getFacebook() async {
    NetworkHelper networkHelper = NetworkHelper(
        'http://mohamadfaqeh-001-site37.itempurl.com/api/mobile/facebook/en');
    facebookurl = await networkHelper.getdata();
    setState(() {
      print(facebookurl);
    });
  }

  var instagramurl;
  Future<dynamic> getinstagram() async {
    NetworkHelper networkHelper = NetworkHelper(
        'http://mohamadfaqeh-001-site37.itempurl.com/api/mobile/instagram/en');
    instagramurl = await networkHelper.getdata();
    setState(() {
      print(instagramurl);
    });
  }

  var youtubeurl;
  Future<dynamic> getyoutube() async {
    NetworkHelper networkHelper = NetworkHelper(
        'http://mohamadfaqeh-001-site37.itempurl.com/api/mobile/youtube/en');
    youtubeurl = await networkHelper.getdata();
    setState(() {
      print(youtubeurl);
    });
  }

  var snapchaturl;
  Future<dynamic> getsnapchat() async {
    NetworkHelper networkHelper = NetworkHelper(
        'http://mohamadfaqeh-001-site37.itempurl.com/api/mobile/snapchat/en');
    snapchaturl = await networkHelper.getdata();
    setState(() {
      print(snapchaturl);
    });
  }

  @override
  void initState() {
    super.initState();

    getFacebook();
    getinstagram();
    getyoutube();
    getsnapchat();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF8973d9),
      title: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.facebook,
              color: Colors.white,
            ),
            onPressed: () async {
              var url = facebookurl['TitleEn'];
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.snapchat, color: Colors.white),
            onPressed: () async {
              var url = snapchaturl['TitleAr'];

              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.youtube, color: Colors.white),
            onPressed: () async {
              var url = youtubeurl['TitleEn'];
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.white),
            onPressed: () async {
              var url = instagramurl['TitleEn'];
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      )),
    );
  }
}
