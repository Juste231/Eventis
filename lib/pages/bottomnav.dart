import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:eventiss/pages/profil.dart';
import 'package:eventiss/pages/reservation.dart';
import 'package:eventiss/pages/home.dart';

class bottomnav extends StatefulWidget {
  const bottomnav({super.key});

  @override
  State<bottomnav> createState() => _bottomnavState();
}

class _bottomnavState extends State<bottomnav> {
  int index = 0;
  final screens = [
    Home(),
    reservation(),
    profil(),
  ];
  @override
  Widget build(BuildContext context) {

    final items = [
      Icon(CupertinoIcons.house , size: 30,),
      Icon(CupertinoIcons.tickets , size: 30,),
      Icon(Icons.account_circle_outlined, size: 30, ),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.blue,
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(color: Colors.black )
        ),
        child: CurvedNavigationBar(
          items: items,
          index: index,
          height: 60,
          onTap: (index)=> setState(() {
            this.index = index;
          }),
          backgroundColor: Colors.transparent,
          animationDuration: Duration(milliseconds: 300),
        ),
      ),
    );
  }
}
