import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebest/AppHelper/AppController.dart';
import 'package:thebest/AppHelper/networking.dart';
import 'package:thebest/api/Api.dart';

import '../SubCategory.dart';
class ServicesPage extends StatefulWidget {
  ServicesPage({this.back});
  final back;
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {


  var mainCat;
  List data;

  Future<dynamic> getMainCAt() async {
    try {
      NetworkHelper networkHelper = NetworkHelper('${Api().baseURL}allservicescategory/en');
      mainCat = await networkHelper.getdata();
      setState(() {
        print(mainCat.runtimeType);

        data = mainCat;
      });
    } catch (e) {
      print(e);
    }
  }

  var languageState;


  void langState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    languageState = preferences.getString("lng");
  }


  @override
  void initState() {
    super.initState();
    getMainCAt() ;
    langState();
  }
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return  Directionality(
        textDirection: AppController.textDirection,
        child: Scaffold(
      appBar:widget.back==false? AppBar(backgroundColor: Color(0xFFf33BE9F),centerTitle: true,title: Text('${AppController.strings.services}'),):null,

      backgroundColor: Color(0xFFf33BE9F),
      body: data!=null?  ListView(
      children: [


        GridView.builder(
          shrinkWrap: true,
          primary: false,

          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 25,
            mainAxisSpacing: 35,
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.2),
          ),
          itemBuilder: (context, index) {
            return Container(
              child: InkWell(
                onTap: () {
                  int id=data[index]['PagesID'];
                  print('id id id id id ${id}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubCategory( id:id ,),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 180,
                        backgroundImage: NetworkImage(Api().baseImgURL + data[index]['Images']),
                      ),
                    ),
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            languageState=='Ar'? Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                data[index]['TitleAr'],
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ):Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                data[index]['TitleEn'],
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            RaisedButton(
                              child: Text(
                                '${AppController.strings.viewServices}',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              onPressed: () {

                                int id=data[index]['PagesID'];
                                print('id id id id id ${id}');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SubCategory( id:id ,),
                                  ),
                                );

                              },
                              color: Colors.black,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.black)),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
        )
      ],
    ) : Container(
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
                            fontSize: 18, color: Colors.black87),
                      ),
                    )),
              ],
            )),
      ),));
  }
}
