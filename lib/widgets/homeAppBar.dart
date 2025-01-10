import 'package:eventiss/pages/notifications.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
class homeAppBar extends StatefulWidget {
  const homeAppBar({super.key});

  @override
  State<homeAppBar> createState() => _homeAppBarState();
}

class _homeAppBarState extends State<homeAppBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(80.0),
        bottomRight: Radius.circular(80.0),
      ),
      child: Container(
        color: Color(0xFF112A46),
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  "images/minilogo.png",
                  scale: 8,
                ),
                Spacer(),
                badges.Badge(
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.red,
                    padding: EdgeInsets.all(5),
                  ),
                  badgeContent: Text('3'),
                  child: InkWell(
                    // Fonction de redirection lors du clic
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => notificationspage()),
                      );
                    },
                    child: Icon(
                      Icons.notifications_active_outlined,
                      size: 32,
                      color: Color(0xFFF3D3BD),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                hintStyle: TextStyle(color: Color(0xFF112A46)),
                suffixIcon: Icon(Icons.search, color: Color(0xFF112A46)),
                suffixIconConstraints: BoxConstraints(minWidth: 60, minHeight: 60),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
