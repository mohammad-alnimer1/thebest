import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppSharedPrefs.dart';
import 'package:thebest/AppHelper/AppString.dart';
import 'package:thebest/Drawer/DrawerPage.dart';
import 'package:thebest/homepage.dart';

import '../AppHelper/AppController.dart';
import '../Drawer/ServicesPage.dart';
import '../Drawer/blogspage.dart';
import 'appBar.dart';
import 'itemTap.dart';

class NavigationBBar extends StatefulWidget {
  final int currentIndex;
  NavigationBBar({this.currentIndex});

  @override
  _NavigationBBarState createState() => _NavigationBBarState();
}

class _NavigationBBarState extends State<NavigationBBar> {
  int currentPage = 1;
  bool isSelectHome = true;

  @override
  void initState() {
    if (widget.currentIndex != null) {
      currentPage = widget.currentIndex;
      isSelectHome = false;
    }

    super.initState();
  }

  final _pageOptions = [
    ServicesPage(),
    Homepage(),
    blogs(),
  ];
  final tabs = [
    AppController.strings.schedule,
  ];

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new Directionality(
              textDirection: AppController.textDirection,
              child: AlertDialog(
                content: new Text('${AppController.strings.exitapp}'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text(AppController.strings.no),
                  ),
                  new FlatButton(
                    onPressed: () => SystemNavigator.pop(),
                    //exit(0) ,//Navigator.of(context).pop(true),
                    child: new Text(AppController.strings.yes),
                  ),
                ],
              )),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: AppController.textDirection,
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
              backgroundColor: Color(0xFF04b2d9),
              drawer: DrawerWidget(),
              appBar: PreferredSize(
                  child: AppBarM(),
                  preferredSize: Size(double.infinity,
                      MediaQuery.of(context).size.height * 0.08)),
              resizeToAvoidBottomInset: false,
              // resizeToAvoidBottomPadding: true,
              body: _pageOptions[currentPage],
              floatingActionButton: FloatingActionButton(
                backgroundColor: Color(0xFF8973d9),
                onPressed: () {
                  setState(() {
                    isSelectHome = true;
                    currentPage = 1;
                  });
                },
                child: Icon(Icons.home,
                    color: isSelectHome ? Colors.white : Colors.tealAccent),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: Container(
                child: _buildBottomTab(),
              )),
        ));
  }

  _buildBottomTab() {
    return BottomAppBar(
      color: Color(0xFB04b2d9),
      shape: CircularNotchedRectangle(),
      elevation: 50,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TabItem(
              text: AppController.strings.services,
              icon: Icons.home_repair_service,
              isSelected: currentPage == 0,
              onTap: () {
                setState(() {
                  isSelectHome = false;
                  currentPage = 0;
                });
              },
            ),
            SizedBox(
              width: 30,
            ),
            TabItem(
              text: '${AppController.strings.blogs}',
              icon: Icons.create_outlined,
              isSelected: currentPage == 2,
              onTap: () {
                setState(() {
                  isSelectHome = false;
                  currentPage = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
