import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventiss/api/util/session_handler.dart';
import 'package:eventiss/pages/admin/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:eventiss/pages/profil.dart';
import 'package:eventiss/pages/reservation.dart';
import 'package:eventiss/pages/home.dart';
import 'package:provider/provider.dart';

import '../api/models/event.dart';
import '../api/util/eventprovider.dart';

import 'admin/add.dart';

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
      checkAdminStatus();
    });
  }

  void checkAdminStatus() async {
    bool adminStatus = await SessionHandler.isAdmin();
    setState(() {
      isAdmin = adminStatus;
    });
  }

  int index = 0;
  bool isAdmin = false;
  @override
  Widget build(BuildContext context) {
  final eventProvider = Provider.of<EventProvider>(context);

  final List<Event> events = eventProvider.events;

  final screens = [
    Home(eventData: events),
    isAdmin ? AddTicketPage() : const reservation(),
    DashboardScreen(eventData: events),
  ];

    final items = [
      Icon(CupertinoIcons.house , size: 30,),
      Icon(CupertinoIcons.tickets , size: 30,),
      Icon(Icons.account_circle_outlined, size: 30, ),
    ];

    return Scaffold(
      extendBody: true,
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
