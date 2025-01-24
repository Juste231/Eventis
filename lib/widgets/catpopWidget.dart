import 'package:eventiss/api/models/event.dart';
import 'package:eventiss/api/util/eventprovider.dart';
import 'package:eventiss/pages/detailevent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'image_loader.dart';


class catpopwidget extends StatefulWidget {
  const catpopwidget({super.key});

  @override
  State<catpopwidget> createState() => _catpopwidgetState();
}

class _catpopwidgetState extends State<catpopwidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventProvider>(context, listen: false).fetchEvents();
    });
  }

  Widget _buildEventCard(Event event) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => detailevent(eventData: event),
          ),
        );
      },
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Image de fond
            Positioned.fill(
              child: CustomImage(
                imageUrl: event.image,
                placeholder: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey.shade300,
                  child: Center(
                    child: Icon(
                      Icons.image_outlined,
                      color: Colors.grey.shade500,
                      size: 50,
                    ),
                  ),
                ),
                errorWidget: Center(
                  child: Icon(Icons.error, color: Colors.red, size: 50),
                ),
              ),
            ),
            // Catégorie en haut à gauche
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  event.category != null ? event.category! : "CINEMA",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Overlay gradient et informations en bas
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      event.title!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      event.date!.toIso8601String(),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

    return Container(
      height: 200,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: events.length,
          separatorBuilder: (context, index) => SizedBox(width: 16),
          itemBuilder: (context, index) {
            return _buildEventCard(events[index]);
          },
        ),
      ),
    );
  }
}
