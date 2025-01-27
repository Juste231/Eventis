import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:eventiss/pages/profil.dart';
import 'package:eventiss/pages/reservation.dart';
import 'package:eventiss/pages/home.dart';
import 'package:provider/provider.dart';

import '../api/models/event.dart';
import '../api/services/event_service.dart';
import '../api/util/eventprovider.dart';

class bottomnav extends StatefulWidget {
  const bottomnav({super.key});

  @override
  State<bottomnav> createState() => _bottomnavState();
}

class _bottomnavState extends State<bottomnav> {

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventProvider>(context, listen: false).fetchEvents();
    });
  }

  int index = 0;


  @override
  Widget build(BuildContext context) {
  final eventProvider = Provider.of<EventProvider>(context);


  final List<Event> events = eventProvider.events;

  final screens = [
    Home(eventData: events),
    const reservation(),
    const profil(),
  ];

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
