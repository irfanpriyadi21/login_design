import 'package:flutter/material.dart';
import 'package:news_app/animations/FadeAnimation.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:news_app/login.dart';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController name = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController email = new TextEditingController();

  check(){
    if(name.text.isEmpty || username.text.isEmpty || password.text.isEmpty || email.text.isEmpty){
      SweetAlert.show(context,
        subtitle: "Data Tidak Boleh Kosong",
        style: SweetAlertStyle.confirm,
      );
    }else{
      RegisterData();
    }
  }

  var resdata;
  RegisterData() async{
    final response = await http.post("https://example-api.000webhostapp.com/input_user.php",body: {
      "name" : name.text,
      "username" : username.text,
      "password" : password.text,
      "email" : email.text
    });

   resdata = response.statusCode;
   if(resdata == 200){
     final data = jsonDecode(response.body);
     String status = data['status'];
     String message = data['message'];
     if(status.trim() == "success"){
       SweetAlert.show(context,
         subtitle: message,
         style: SweetAlertStyle.confirm,
         showCancelButton: false,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
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
                                "Form Register",
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
                                  controller: name,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Name",
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
                                  controller: username,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Username",
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
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
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
                                  controller: email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
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
                                "Register",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
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
  }
}
