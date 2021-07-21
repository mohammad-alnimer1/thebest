import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppHelper/AppColors.dart';
import 'AppHelper/AppController.dart';
import 'AppHelper/AppSharedPrefs.dart';
import 'AppHelper/AppString.dart';
import 'Login_Page.dart';
import 'Navigation/NavigationBar.dart';

// import 'package:group_button/group_button.dart';

class LangpageMain extends StatefulWidget {
  @override
  _LangpageMain createState() => _LangpageMain();
}

class _LangpageMain extends State<LangpageMain> {
  Axis direction = Axis.vertical;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // SizeConfig().init(context);
    return Directionality(
      textDirection: AppController.textDirection,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Color(0xFFf33BE9F),
          body: Align(
            alignment: Alignment.center,
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    height: 60,
                    child: RaisedButton(
                        child: Text('العربية'),
                        onPressed: () {
                          setState(() {
                            AppController.textDirection = TextDirection.rtl;
                            AppController.strings = ArabicString();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavigationBBar(),
                                ));
                            AppSharedPrefs.saveMainLangInSP(true);
                            AppSharedPrefs.saveLangType("Ar");
                          });
                        }),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),

                // width: 300.0,
              Padding(
                padding: const EdgeInsets.all(20),
                child:    Container(
                  height: 60,
                  child: RaisedButton(
                    child: Text('English'),
                    onPressed: () {
                      setState(() {
                        AppController.textDirection = TextDirection.ltr;
                        AppController.strings = EnglishString();
                        AppSharedPrefs.saveMainLangInSP(true);
                        AppSharedPrefs.saveLangType('En');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavigationBBar(),
                            ));
                      });
                    }),))
              ],
            )),
            // child: Container(
            //     color: Colors.white,
            //     // decoration: BoxDecoration(gradient: AppConstants().mainColors()),
            //
            //
            //     // child: GroupButton(
            //     //
            //     //   selectedColor: Colors.grey,
            //     //   spacing: 10,
            //     //   direction: direction,
            //     //   onSelected: (index, isSelected) =>
            //     //       print('$index button is selected'),
            //     //   buttons: [
            //     //     "Arabic",
            //     //     "English",
            //     //   ],
            //     // ),
            //
            //     ),
          ),
        ),
      ),
    );
  }
}

// class SizeConfig {
//   static MediaQueryData _mediaQueryData;
//   static double screenWidth;
//   static double screenHeight;
//   static double blockSizeHorizontal;
//   static double blockSizeVertical;
//
//   void init(BuildContext context) {
//     _mediaQueryData = MediaQuery.of(context);
//     screenWidth = _mediaQueryData.size.width;
//     screenHeight = _mediaQueryData.size.height;
//     blockSizeHorizontal = screenWidth / 100;
//     blockSizeVertical = screenHeight / 100;
//   }
// }
