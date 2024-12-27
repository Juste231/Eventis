import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned.fill(child: Image.asset("images/ça.jpeg",fit: BoxFit.cover, ),),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Data", style: TextStyle(color: Colors.white, fontSize: 16)),
                        Text("Weloveeya", style: TextStyle(color: Colors.white, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20,),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned.fill(child: Image.asset("images/mark1.jpg",fit: BoxFit.cover, ),),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Data", style: TextStyle(color: Colors.white, fontSize: 16)),
                        Text("Weloveeya", style: TextStyle(color: Colors.white, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20,),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned.fill(child: Image.asset("images/mark2.jpeg",fit: BoxFit.cover, ),),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Data", style: TextStyle(color: Colors.white, fontSize: 16)),
                        Text("Weloveeya", style: TextStyle(color: Colors.white, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20,),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned.fill(child: Image.asset("images/Hoy.jpeg",fit: BoxFit.cover, ),),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Data", style: TextStyle(color: Colors.white, fontSize: 16)),
                        Text("Weloveeya", style: TextStyle(color: Colors.white, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20,),
          ],
        ),
      ),
    );
  }
}

