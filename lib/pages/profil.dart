import 'package:dio/dio.dart';
import 'package:eventiss/api/models/authenticated_user.dart';
import 'package:eventiss/api/services/user_service.dart';
import 'package:eventiss/api/util/session_handler.dart';
import 'package:eventiss/pages/historique.dart';
import 'package:eventiss/pages/preference.dart';
import 'package:eventiss/pages/securite.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class profil extends StatefulWidget {
  const profil({Key? key}) : super(key: key);

  @override
  State<profil> createState() => _profilState();
}

class _profilState extends State<profil> {
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

  User? user;
  UserService userService = UserService();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  logout() async {
    try {
      await SessionHandler.logout();
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Une erreur est survenue", gravity: ToastGravity.TOP_RIGHT);
    }
  }
  // Charger les données utilisateur
  Future<void> loadUserData() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      AuthenticatedUser fetchedUser = await userService.user();
      print("Fetched user ${fetchedUser.user}");
      setState(() {
        user = fetchedUser.user;
      });

    } on DioException catch(e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.statusCode);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () async {
              // Navigation vers la page de modification
              final result = await Navigator.pushNamed(context, '/edit-profile');
              if (result == true) {
                loadUserData(); // Recharger les données après modification
              }
            },
            child: Text(
              'Modifier',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: loadUserData,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 20),
              // Photo de profil
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                        ),
                      ],
                      image: null,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.grey[400],
                    )
                  ),
                  InkWell(
                    onTap: () async {
                      // Ajouter la logique pour changer la photo de profil
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF0F1728),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                user?.lastname.toString() ?? 'Nom d\'utilisateur',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                user?.email ?? 'email@example.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 32),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Icons.settings,
                      title: 'Préférences',
                      onTap: () async {
                        final result = await Navigator.pushNamed(context, '/preferences');
                        if (result == true) {
                          loadUserData();
                        }
                      },
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      icon: Icons.security,
                      title: 'Sécurité',
                      onTap: () {
                        Navigator.pushNamed(context, '/security');
                      },
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      icon: Icons.history,
                      title: 'Historique',
                      onTap: () {
                        Navigator.pushNamed(context, '/history');
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Déconnexion'),
                        content: Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Annuler'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              await logout();
                            },
                            child: Text(
                              'Déconnexion',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    elevation: 0,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.red),
                    ),
                  ),
                  child: Text(
                    'Déconnexion',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFFFFF3EE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Color(0xFF0F1728),
              ),
            ),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 1,
      color: Colors.grey[200],
    );
  }
}

