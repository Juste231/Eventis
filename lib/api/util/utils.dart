import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/auth/login.dart';
import '../../pages/bottomnav.dart';

Future<void> checkLoginStatus(BuildContext context) async {

  final sharedPref = await SharedPreferences.getInstance();
  String? token = sharedPref.getString("token");

  if (token != null && !JwtDecoder.isExpired(token)) {
    print(token);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomnav()));
  }
}

Future<void> checkToken(BuildContext context) async {
  final sharedPref = await SharedPreferences.getInstance();
  String? token = sharedPref.getString("token");

  if (token != null && !JwtDecoder.isExpired(token)) {
    print(token);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => bottomnav()));
  } else {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) =>  login()));
  }
}