import 'dart:convert';
import 'package:news_app/mainMenu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_app/login.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(MaterialApp(
      home: Login_Data(),
  ));
}


