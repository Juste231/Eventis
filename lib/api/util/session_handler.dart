import 'dart:convert';

import 'package:eventiss/pages/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/authenticated_user.dart';

class SessionHandler {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<void> saveUserSession(AuthenticatedUser user) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString("user", jsonEncode(user.toJson()));
  }

  static Future<AuthenticatedUser?> getUserSession() async {
    final sharedPref = await SharedPreferences.getInstance();
    String? userData = sharedPref.getString("user");

    if (userData == null) {
      print("Aucune session utilisateur trouvée !");
      return null;
    }

    try {
      return AuthenticatedUser.fromJson(jsonDecode(userData));
    } catch (e) {
      print("Erreur de décodage JSON : $e");
      return null;
    }
  }

  static Future<bool> isAdmin() async {
    final user = await getUserSession();
    return user?.user?.role == "Admin";
  }

  static Future<void> showSessionExpiredDialog() async {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Session expirée'),
        content: Text('Votre session a expiré. Veuillez vous reconnecter.'),
        actions: [
          TextButton(
            onPressed: () async {
              final sharedPref = await SharedPreferences.getInstance();
              await sharedPref.remove("token");
              await sharedPref.remove("user");
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => login(),
              ),);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  static Future<void> logout() async {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.remove("token");
    await sharedPref.remove("user");

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => login()));
  }
}
