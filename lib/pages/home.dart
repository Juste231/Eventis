import 'package:eventiss/api/models/event.dart';
import 'package:eventiss/pages/event.dart';
import 'package:eventiss/pages/eventpop.dart';
import 'package:eventiss/widgets/catpopWidget.dart';
import 'package:flutter/material.dart';
import '../widgets/homeAppBar.dart';
import '../widgets/categoriesWidget.dart';

class Home extends StatefulWidget {
  final List<Event> eventData;

  const Home({super.key, required this.eventData});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          homeAppBar(),
          SizedBox(height: 20),
          categoriesWidget(),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => event(eventData: widget.eventData)),
                );
              },
              child: Text(
                "Evènements à venir >",
                style: TextStyle(
                  color: Color(0xFF112A46),
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          widget.eventData.isEmpty
              ? Center(
                  child: Text("Aucun evenement existant"),
                )
              : cardforevent(),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => eventpop()),
                );
              },
              child: Text(
                "Evènements populaire >",
                style: TextStyle(
                  color: Color(0xFF112A46),
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          widget.eventData.isEmpty
              ? Center(
                  child: Text("Aucun evenement existant"),
                )
              : catpopwidget(),
        ],
      ),
    );
  }
}
