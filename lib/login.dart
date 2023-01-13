import 'package:flutter/material.dart';
import 'package:news_app/animations/FadeAnimation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/mainMenu.dart';
import 'package:news_app/register.dart';


class Login_Data extends StatefulWidget {
  @override
  _Login_DataState createState() => _Login_DataState();
}
enum LoginStatus {notSignIn, signIn}

class _Login_DataState extends State<Login_Data> {

  bool isLoading = false;
  var resdata;
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final _key = new GlobalKey<FormState>();

  check(){
    if(username.text.isEmpty || password.text.isEmpty){
      SweetAlert.show(context,
          subtitle: "Username & Password \nTidak boleh Kosong",
          style: SweetAlertStyle.confirm,
        );
    }else{
      login();
    }
  }

  login() async{
    final response = await http.post("https://example-api.000webhostapp.com/login.php",body: {
      "username" : username.text,
      "password" : password.text
    });

    resdata = response.statusCode;
    if(resdata == 200){
      final data = jsonDecode(response.body);
      String status = data['status'];
      String message = data['message'];
      if(status.trim() == "success"){
        setState(() {
          _loginStatus = LoginStatus.signIn;
          savePref(status);
        });
        SweetAlert.show(context,
          subtitle: message,
          style: SweetAlertStyle.confirm,
        );
      }else{
        SweetAlert.show(context,
          subtitle: message,
          style: SweetAlertStyle.error,
        );
      }
    }else{
      SweetAlert.show(context,
        subtitle: "Terjadi Kesalahan !!",
        style: SweetAlertStyle.error,
      );
    }
  }

  savePref(String status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("status", status);
      preferences.commit();
    });
  }

  String status;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      status = preferences.getString("status");
      _loginStatus = status == "success" ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  signOut() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("status", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
      switch(_loginStatus) {
        case LoginStatus.notSignIn:
          return Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: _key,
            child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(1, Container(
                        height: 400,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.fill,
                            )
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              left: 30,
                              width: 80,
                              height: 200,
                              child: FadeAnimation(1, Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light1.png')
                                    )
                                ),
                              )),
                            ),
                            Positioned(
                              left: 140,
                              width: 80,
                              height: 150,
                              child: FadeAnimation(1.3, Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light2.png')
                                    )
                                ),
                              )),
                            ),
                            Positioned(
                              right: 40,
                              top: 40,
                              width: 80,
                              height: 200,
                              child: FadeAnimation(1.5, Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/clock.png')
                                    )
                                ),
                              )),
                            ),
                            Positioned(
                              child: FadeAnimation(1.6, Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              )),
                            )
                          ],
                        ),
                      ),),
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            FadeAnimation(1.5, Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(143, 148, 251, 2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10)
                                    )
                                  ]
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(
                                            color: Colors.grey[100]))
                                    ),
                                    child: TextField(
                                      controller: username,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email Or Phone Number",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400]
                                          )
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(
                                            color: Colors.grey[100]))
                                    ),
                                    child: TextField(
                                      controller: password,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400]
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(height: 50),
                            FadeAnimation(1.8, FlatButton(
                              onPressed: () {
                                check();
                              },
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        colors: [
                                          Color.fromRGBO(143, 148, 251, 1),
                                          Color.fromRGBO(143, 148, 251, 6),
                                        ]
                                    )
                                ),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            )),
                            SizedBox(height: 30),
                            FadeAnimation(2.0, Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Not Have Account ?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(143, 148, 251, 1)
                                  ),
                                ),
                                SizedBox(
                                    width: 90,
                                    height: 25,
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Register(),
                                          ),
                                        );
                                      },
                                      splashColor: Colors.purple,
                                      child: Text(
                                        "Register",
                                        style: TextStyle(
                                            color: Color.fromRGBO(143, 148, 251, 1),
                                            ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(10)),
                                    )
                                ),
                              ],
                            )),

                          ],
                        ),
                      )
                    ],
                  ),
                )
            ),
          ),
        );
          break;
        case LoginStatus.signIn:
          return Mainmenu(signOut);
          break;
    }
  }
}

