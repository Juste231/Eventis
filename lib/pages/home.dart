import 'package:dio/dio.dart';
import 'package:eventiss/api/models/event.dart';
import 'package:eventiss/pages/event.dart';
import 'package:eventiss/pages/eventpop.dart';
import 'package:eventiss/widgets/catpopWidget.dart';
import 'package:flutter/material.dart';
import '../api/services/event_service.dart';
import '../widgets/homeAppBar.dart';
import '../widgets/categoriesWidget.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  EventService eventService = EventService();

  @override
  void initState(){
    super.initState();
    getEvents();
  }

  getEvents() async {
    try {
      List<Event> response = await eventService.getAll();
      print(response.length);
      print("Event 1 ${response[0].toJson()}");
    } on DioException catch (e) {
      print(e.error.toString());
      print(e.message);
      print(e.response);
    }
  }

  final List<Map<String, String>> eventData = [
    {
      'image': 'images/ça.jpeg',
      'title': 'WELOVEEEYA',
      'subtitle': 'Weloveeya',
      'category': 'CONCERT',
      'date': '30 Dec',
    },
    {
      'image': 'images/mark1.jpg',
      'title': 'WELOVEEEYA',
      'subtitle': 'Weloveeya',
      'category': 'CONCERT',
      'date': '30 Dec',
    },
    {
      'image': 'images/mark2.jpeg',
      'title': 'WELOVEEEYA',
      'subtitle': 'Weloveeya',
      'category': 'CONCERT',
      'date': '30 Dec',
    },
    {
      'image': 'images/Hoy.jpeg',
      'title': 'WELOVEEEYA',
      'subtitle': 'Weloveeya',
      'category': 'CONCERT',
      'date': '30 Dec',
    },
  ];

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
                  MaterialPageRoute(builder: (context) => event(eventData: eventData,)),
                );
              },
              child: Text("Evènements à venir >",
                style: TextStyle(
                    color: Color(0xFF112A46),
                    fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          cardforevent(),
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
              child: Text("Evènements populaire >",
                style: TextStyle(
                    color: Color(0xFF112A46),
                    fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          catpopwidget(),


        ],
      ),
    );
  }
}
