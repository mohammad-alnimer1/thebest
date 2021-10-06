import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_extended/carousel_extended.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as https;
import 'package:thebest/Drawer/Description.dart';
import 'AppHelper/AppController.dart';
import 'AppHelper/AppSharedPrefs.dart';
import 'AppHelper/AppString.dart';
import 'AppHelper/networking.dart';
import 'Drawer/DrawerPage.dart';
import 'SubCategory.dart';
import 'api/Api.dart';
import 'module/MainCat_Module.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}
// class NewsFun {
//   static Future<List<MainCatModel>> getNews() async {
//     try {
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       print(preferences.getString('lng'));
//       final response = await http.post(Api().baseURL + 'servicescategory/en',
//           body: {"language": preferences.getString('lng')});
//
//       print(response.statusCode);
//       print(response.body);
//
//       if (200 == response.statusCode) {
//         print(response.body);
//         final List<MainCatModel> news = newsModelFromJson('[${response.body}]');
//         return news;
//       } else {
//         return List<MainCatModel>();
//       }
//     } catch (e) {
//       return List<MainCatModel>();
//     }
//   }
// }

class _HomepageState extends State<Homepage> {
  // List<Datum> _newsData;
  // var languageState;
  // bool loading = true;
  //
  // void langState() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   languageState = preferences.getString("lng");
  // }
  //
  // @override
  // void initState() {
  //
  //   langState();
  //   NewsFun.getNews().then((value) {
  //     setState(() {
  //       MainCategory = value;
  //       _newsData = MainCategory[0].data;
  //     });
  //   });
  //   new Future.delayed(new Duration(seconds: 2), () {
  //     setState(() {
  //       loading = false;
  //     });
  //   });
  // }
  bool loading = true;

  var DescriptionAr;
  var DescriptionEn;
  var TitleAr;
  var TitleEn;
  var Images;
  var mainCat;
  var slidImg;
  var slidOffers;
  List data;
  List imgdata;
  List ListslidOffers;
  List imgslideoffer;
  List ListFAQ;

  var servicetitle;
  Future<dynamic> getservicetitle() async {
    try {
      NetworkHelper networkHelper =
          NetworkHelper('${Api().baseURL}servicetitle/en');
      servicetitle = await networkHelper.getdata();
      setState(() {
        return servicetitle;
      });
    } catch (e) {
      print(e);
    }
  }
  var faq;
  Future<dynamic> getFAQ() async {
    try {
      NetworkHelper networkHelper =
          NetworkHelper('${Api().baseURL}gethomefaqs/en');
      faq = await networkHelper.getdata();
      setState(() {
       ListFAQ=  faq;
      });
    } catch (e) {
      print(e);
    }
  }

  var welcomebannar;

  Future<dynamic> getwelcomebannar() async {
    try {
      NetworkHelper networkHelper =
          NetworkHelper('${Api().baseURL}welcome?lang=en');
      welcomebannar = await networkHelper.getdata();
      setState(() {
        return welcomebannar;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getMainCAt() async {
    try {
      NetworkHelper networkHelper =
          NetworkHelper('${Api().baseURL}servicescategory/en');
      mainCat = await networkHelper.getdata();
      setState(() {
        print(mainCat.runtimeType);

        data = mainCat;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getImgSlid() async {
    NetworkHelper networkHelper = NetworkHelper('${Api().baseURL}getbanner/en');
    slidImg = await networkHelper.getdata();

    setState(() {
      print(slidImg.runtimeType);
      imgdata = slidImg;
    });
  }
  Future<dynamic> getslidOffers() async {
    NetworkHelper networkHelper = NetworkHelper('${Api().baseURL}getoffer/en');
    slidOffers = await networkHelper.getdata();
    setState(() {
     imgslideoffer= slidOffers;
      print('ListslidOffers ****************** ${slidOffers}');
    });
  }



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
    setState(() {
      super.initState();
      getservicetitle();
      getMainCAt();
      getFacebook();
      getinstagram();
      getImgSlid();
      getyoutube();
      getsnapchat();
      langState();
      getwelcomebannar();
      getslidOffers();
      getFAQ();

    });
  }
  final List<GlobalKey<ExpansionTileCardState>> cardKeyList = [];

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: AppController.textDirection,
        child: Scaffold(
          drawer: DrawerWidget(),
          backgroundColor: Color(0xFF04b2d9),
          body: data != null
              ? ListView(
                  children: [
                    imgdata != null
                        ? Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(250)),
                                  child: Carousel(
                                    animationDuration: Duration(seconds: 1),
                                    pageController: PageController(),
                                    boxFit: BoxFit.cover,
                                    animationCurve: Curves.fastOutSlowIn,
                                    dotSize: 10.0,
                                    autoplay: true,
                                    dotIncreasedColor: Color(0xFF04b2d9),
                                    dotBgColor: Colors.transparent,
                                    dotPosition: DotPosition.bottomCenter,
                                    dotVerticalPadding: 10.0,
                                    showIndicator: true,
                                    indicatorBgPadding: 7.0,
                                    autoplayDuration: Duration(seconds: 3),
                                    borderRadius: true,
                                    noRadiusForIndicator: true,
                                    images: [
                                      for (var i = 0; i < imgdata.length; i++)
                                        NetworkImage(
                                            '${Api().baseImgURL + imgdata[i]['Images']}'),
                                      // NetworkImage('${Api().baseImgURL + imgdata[1]['Images']}'),
                                      // NetworkImage('${Api().baseImgURL + imgdata[2]['Images']}'),
                                    ],
                                  )),
                              height: 380,
                            ),
                          )
                        : Container(),
                    Directionality(
                        textDirection: languageState == 'Ar'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: Container(
                            height: 80,
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: welcomebannar!=null?Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  languageState == 'Ar'
                                      ? '${welcomebannar['TitleAr']} '
                                      : '${welcomebannar['TitleEn']} ',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontStyle: FontStyle.italic),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Container(
                                    child: Image.network(
                                        '${Api().baseImgURL + welcomebannar['Images']}'),
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                              ],
                            ):Container(child:  CircularProgressIndicator(),))),
                    GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 15,
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1),
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          child: InkWell(
                            onTap: () {
                              var name = mainCat[index]['TitleAr'];
                              var nameEN = mainCat[index]['TitleEn'];
                              int id = data[index]['PagesID'];
                              print('id id id id id ${id}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubCategory(
                                      id: id, name: name, nameEN: nameEN),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 180,
                                    backgroundImage: NetworkImage(
                                        Api().baseImgURL + mainCat[index]['Images']),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            languageState == 'Ar'
                                                ? mainCat[index]['TitleAr']
                                                : mainCat[index]['TitleEn'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        RaisedButton(
                                          child: Text(
                                            //  '${AppController.strings.viewServices}',
                                            languageState == 'Ar'
                                                ? '${servicetitle['TitleAr']}'
                                                : '${servicetitle['TitleEn']}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            var name =
                                                mainCat[index]['TitleAr'];
                                            var nameEN =
                                                mainCat[index]['TitleEn'];
                                            int id = data[index]['PagesID'];
                                            print('id id id id id ${id}');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SubCategory(
                                                  name: name,
                                                  nameEN: nameEN,
                                                  id: id,
                                                ),
                                              ),
                                            );
                                          },
                                          color: Colors.black,
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                  color: Colors.black)),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    ),


              Container(
              color: Color(0xd2fefefb),
              child:   Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(bottom: 20,top: 20),
                  child: Text(
                    '${AppController.strings.FAQ}',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),),
              ],
            ),),



                    cardKeyList!=null? Container(margin: EdgeInsets.only(top: 20,bottom: 20),child:  ListView.builder(
                   physics: NeverScrollableScrollPhysics(),
                   padding:EdgeInsets.only(bottom: 50),
                   shrinkWrap: true,
                   itemCount: faq.length,
                   itemBuilder: (context, index) {
                     cardKeyList.add(GlobalKey(debugLabel: "index :$index"));

                     return   Container(
                       margin: EdgeInsets.all(10),
                       child: ExpansionTileCard(
                       key: cardKeyList[index],
                       onExpansionChanged: (value) {
                         if (value) {
                           Future.delayed(const Duration(milliseconds: 500), () {
                             for (var i = 0; i < cardKeyList.length; i++) {
                               if (index != i) {
                                 cardKeyList[i].currentState?.collapse();
                               }
                             }
                           });
                         }
                       },
                       title: Text(
                         languageState == 'Ar'
                             ? '${ListFAQ[index]['TitleAr']} '
                             : '${ListFAQ[index]['TitleEn']} ',

                       ),
                       children: [
                         Padding(
                           padding: EdgeInsets.all(10),
                           child:  Text(
                             languageState == 'Ar'
                                 ? '${ListFAQ[index]['DescriptionAr']} '
                                 : '${ListFAQ[index]['DescriptionEn']} ',

                           ),
                         ),
                       ],
                     ),width: 150,);
                   },),):Container(),

                    Container(
                      color: Color(0xd2fefefb),
                      child:   Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20,top: 20),
                            child: Text('${AppController.strings.offers}',
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                            ),),
                        ],
                      ),),

                    Container(child:
    imgslideoffer!=null? Carousel(
                      animationDuration: Duration(seconds: 1),
                      pageController: PageController(),
                      boxFit: BoxFit.cover,
                      animationCurve: Curves.fastOutSlowIn,
                      dotSize: 10.0,
                      autoplay: true,
                      dotIncreasedColor: Color(0xFF04b2d9),
                      dotBgColor: Colors.transparent,
                      dotPosition: DotPosition.bottomCenter,
                      dotVerticalPadding: 10.0,
                      showIndicator: true,
                      indicatorBgPadding: 7.0,
                      autoplayDuration: Duration(seconds: 3),
                      borderRadius: true,
                      noRadiusForIndicator: true,
                      images: [
                        for (var i = 0; i < imgslideoffer.length; i++)
                          NetworkImage('${Api().baseImgURL + imgslideoffer[i]['Images']}'),
                        // NetworkImage('${Api().baseImgURL + imgdata[1]['Images']}'),
                        // NetworkImage('${Api().baseImgURL + imgdata[2]['Images']}'),
                      ],
                    ):Container(),

                      height: 250,
                      margin: EdgeInsets.only(bottom: 50,top: 50),),

                  ],
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
