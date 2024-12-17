import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'page/profil.dart';
import 'page/home.dart';
import 'page/ticket.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const menu(),
    );
  }
}

class menu extends StatefulWidget {
  const menu({super.key});

  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {
  int index = 0;
  final screens = [
    Home(),
    ticket(),
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
      appBar: AppBar(
        title: Text("navbar"),
        elevation: 0,
        centerTitle: true,
      ),
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


