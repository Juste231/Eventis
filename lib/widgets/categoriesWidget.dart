import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eventiss/pages/detailevent.dart';
class categoriesWidget extends StatelessWidget {
  const categoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 5 ,horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xFFF3D3BD),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  child:
                  Icon(
                    CupertinoIcons.music_note_2,
                    size: 14, // Taille de l'icône à l'intérieur du Container
                  ),

                ),
                Text(
                  "Music",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 5 ,horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xFFF3D3BD),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  child:
                  Icon(
                    FontAwesomeIcons.masksTheater,
                    size: 14, // Taille de l'icône à l'intérieur du Container
                  ),

                ),
                Text(
                  "Théâtre",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 5 ,horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xFFF3D3BD),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  child:
                  Icon(
                    FontAwesomeIcons.personRunning,
                    size: 14, // Taille de l'icône à l'intérieur du Container
                  ),

                ),
                Text(
                  "Sports",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 5 ,horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xFFF3D3BD),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  child:
                  Icon(
                    CupertinoIcons.music_note_2,
                    size: 17, // Taille de l'icône à l'intérieur du Container
                  ),

                ),
                Text(
                  "festival",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class cardforevent extends StatefulWidget {
  const cardforevent({super.key});

  @override
  State<cardforevent> createState() => _cardforeventState();
}

class _cardforeventState extends State<cardforevent> {
  final List<Map<String, String>> eventData = [
    {
      'image': 'images/ça.jpeg',
      'title': 'Data',
      'subtitle': 'Weloveeya'
    },
    {
      'image': 'images/mark1.jpg',
      'title': 'Data',
      'subtitle': 'Weloveeya'
    },
    {
      'image': 'images/mark2.jpeg',
      'title': 'Data',
      'subtitle': 'Weloveeya'
    },
    {
      'image': 'images/Hoy.jpeg',
      'title': 'Data',
      'subtitle': 'Weloveeya'
    },
  ];

  Widget _buildEventCard(Map<String, String> event) {
    return GestureDetector( // Ajout du GestureDetector
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
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                event['image']!,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.all(8),
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
                  children: [
                    Text(
                        event['title']!,
                        style: TextStyle(color: Colors.white, fontSize: 16)
                    ),
                    Text(
                        event['subtitle']!,
                        style: TextStyle(color: Colors.white, fontSize: 14)
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
          separatorBuilder: (context, index) => SizedBox(width: 20),
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

