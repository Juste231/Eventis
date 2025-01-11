import 'package:dio/dio.dart';
import 'package:eventiss/main.dart';
import 'package:eventiss/pages/auth/login.dart';
import 'package:eventiss/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eventiss/pages/bottomnav.dart';
import 'package:eventiss/pages/auth/register.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with SingleTickerProviderStateMixin {


  Future<void> _checkLoginStatus() async {

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

  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 2), (){
      _checkLoginStatus();
    } );
    }

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF112A46),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Image.asset("images/logo.png"),
            ),
          ],
        ),
      ),
    );
  }
}
