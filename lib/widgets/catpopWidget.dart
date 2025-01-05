import 'package:eventiss/pages/detailevent.dart';
import 'package:flutter/material.dart';


class catpopwidget extends StatefulWidget {
  const catpopwidget({super.key});

  @override
  State<catpopwidget> createState() => _catpopwidgetState();
}

class _catpopwidgetState extends State<catpopwidget> {
  final List<Map<String, String>> eventData = [
    {
      'image': 'images/ça.jpeg',
      'title': 'Data',
      'subtitle': 'Weloveeya',
      'category': 'Technologie',
      'date': '30 Décembre 2024'
    },
    {
      'image': 'images/mark1.jpg',
      'title': 'Data',
      'subtitle': 'Weloveeya',
      'category': 'Innovation',
      'date': '31 Décembre 2024'
    },
    {
      'image': 'images/mark2.jpeg',
      'title': 'Data',
      'subtitle': 'Weloveeya',
      'category': 'Design',
      'date': '1 Janvier 2025'
    },
    {
      'image': 'images/Hoy.jpeg',
      'title': 'Data',
      'subtitle': 'Weloveeya',
      'category': 'Marketing',
      'date': '2 Janvier 2025'
    },
  ];

  Widget _buildEventCard(Map<String, String> event) {
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
              child: Image.asset(
                event['image']!,
                fit: BoxFit.cover,
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
                  event['category']!,
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
                      event['title']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      event['date']!,
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
    return Container(
      height: 200,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: eventData.length,
          separatorBuilder: (context, index) => SizedBox(width: 16),
          itemBuilder: (context, index) {
            return _buildEventCard(eventData[index]);
          },
        ),
      ),
    );
  }
}

// Méthode à implémenter pour charger les données depuis l'API
Future<void> fetchEvents() async {
  // Exemple de structure pour l'appel API
  try {
    // const response = await http.get('votre_url_api/events');
    // final data = json.decode(response.body);
    // setState(() {
    //   eventData = data;
    // });
  } catch (e) {
    print('Erreur lors du chargement des événements: $e');
  }
}