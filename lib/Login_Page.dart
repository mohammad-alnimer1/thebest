import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'package:thebest/Navigation/NavigationBar.dart';
import 'AppHelper/AppController.dart';
import 'AppHelper/staticWidget.dart';
import 'DetailsPage.dart';
import 'Drawer/Constants.dart';
import 'ForgotPassword.dart';
import 'Registration.dart';
import 'AppHelper/buttonClass.dart';

import 'AppHelper/Provider.dart';

class LogInPage extends StatefulWidget {
  final loginback;
  LogInPage({this.loginback});
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController PasswordController = new TextEditingController();
  // var _data;
  // Future loginform() async {
  //   var logindata = GlobalFormKey.currentState;
  //   if (logindata.validate()) {
  //     logindata.save();
  //     // show_loading(context);
  //
  //     var data = {
  //       "login": emailController.text,
  //       "password": PasswordController.text
  //     };
  //     var url = "http://kuwaitlivestock.com:5000/login_data";
  //     dynamic response = await http.post(url, body: data);
  //     print(response.body);
  //
  //     String jsonsDataString = response.body;
  //     _data =jsonDecode(jsonsDataString.replaceAll("'",'"')) ;
  //     print('hi hi hi hi hihi hi ${_data['name']}'  );
  //     if (_data ['result'] == "success"){
  //
  //       // savepreflogin(id: _data['user_id'],name:_data['name'],phone: _data['phone'],login: _data['login'], );
  //       // AppSharedPrefs.saveIsLoginSP(true);
  //       // print(await AppSharedPrefs.saveIsLoginSP(true));
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => NavigationBBar()));
  //     } else {
  //       Showtoast();
  //       // show_dialogall(context,"filed","wrong email or password plese check");
  //
  //     }
  //   }else{
  //
  //   }
  // }


  // savepreflogin(String name,String login,String id) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString("user_id",id);
  //   pref.setString("name", name);
  //   pref.setString("login", login);
  //   print (pref.getString("id"));
  //   print(pref.getString("name"));
  //   print(pref.getString("login"));
  //
  // }

  // void main()async {
  //   String url = "http://kuwaitlivestock.com:5000/login_data";
  //   var response = await http.post(url, body: {
  //     "password" :PasswordController.text,
  //     "login":emailController.text
  //   });
  //
  //   var body = jsonEncode(response.body);
  //
  //   if(response.statusCode == 200){
  //     debugPrint("Data posted successfully");
  //   }else{
  //     debugPrint("Something went wrong! Status Code is: ${response.statusCode}");
  //   }
  //
  // }
  bool loading1 = false;

  GlobalKey<FormState> GlobalFormKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    Future doLogin () {
       loading1=true;
       final form = GlobalFormKey.currentState;
       if (form.validate()) {
         form.save();
         final Future successfulMessage = auth.login(emailController.text, PasswordController.text);
         successfulMessage.then((response) {
           print(response);
           if (response=='0') {
            Showtoast();
            loading1=false;
                 }
          else {
             widget.loginback==false?  Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigationBBar(),
                )): Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(
                   builder: (context) => NavigationBBar(),
                 ));
             //DetailsPage
            print('lllll');


           }
        });
      } else {
        print("form is invalid");
      }
    };

    return  Directionality(
        textDirection: AppController.textDirection,
        child:ModalProgressHUD(
        color: Colors.white12,
        inAsyncCall: loading1,
        child:  Scaffold(
          backgroundColor: Color(0xFFf33BE9F),

      bottomNavigationBar: Container(
        height: 125,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: button(
                buttonName: '${AppController.strings.login}',
                color: Colors.black,
                onpress: () async {
                  setState(() {

                    doLogin().then((value) =>  loading1=false);
                  });
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${AppController.strings.createANewAccount}',
                      style: TextStyle(fontSize: 16),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationPage()));
                      },
                      child: Text(
                        '${AppController.strings.registration}',
                        style:
                            TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
      body:Form(
    key: GlobalFormKey,
    child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            maxRadius: 80,
            backgroundColor: Colors.white,
            child: ClipOval(
                child: Image.asset(
                  'images/Logo.png',
                  fit: BoxFit.fitWidth,
                  height: 150,
                  width: 150,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              color: Colors.black12.withOpacity(0.01),
              child:  Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '${AppController.strings.login}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: TextFormField(
                          autocorrect: false,
                        validator: staticWidget().emailvalid,
                          controller: emailController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {},
                          decoration: KDecoration.copyWith(
                            filled: true,
                              fillColor: Colors.white70,
                              labelText: '${AppController.strings.enterYourEmail}')),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: TextFormField(
                          autocorrect: false,
                        validator: staticWidget().validEmpty,
                          controller: PasswordController,
                          textAlign: TextAlign.center,
                          onChanged: (value) {},
                          decoration: KDecoration.copyWith(
                              fillColor: Colors.white70,
                              filled: true,
                              labelText: '${AppController.strings.enterpassword}')),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: InkWell(
                        child: Text(
                          '${AppController.strings.forgotYourPassword}',
                          style: TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPassword(),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),

        ],
      )),
    )));
  }

  Future Showtoast(){
    Fluttertoast.showToast(

        msg: "${AppController.strings.wrongEmailOrPassword}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xFFFFADAD),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
