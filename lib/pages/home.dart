import 'package:dio/dio.dart';
import 'package:eventiss/api/models/event.dart';
import 'package:eventiss/api/util/eventprovider.dart';
import 'package:eventiss/pages/event.dart';
import 'package:eventiss/pages/eventpop.dart';
import 'package:eventiss/widgets/catpopWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/services/event_service.dart';
import '../widgets/homeAppBar.dart';
import '../widgets/categoriesWidget.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventProvider>(context, listen: false).fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    if(eventProvider.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final List<Event> events = eventProvider.events;

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
                  MaterialPageRoute(builder: (context) => event(eventData: events,)),
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
