import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eventiss/api/util/utils.dart';


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
      checkToken(context);
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
