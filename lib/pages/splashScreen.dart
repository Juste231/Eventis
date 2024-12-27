import 'package:eventiss/main.dart';
import 'package:eventiss/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eventiss/pages/bottomnav.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 2), (){
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => bottomnav())
      );
    } );
    }

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
