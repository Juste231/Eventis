import 'package:eventiss/pages/auth/login.dart';
import 'package:flutter/material.dart';

class SessionHandler {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
            onPressed: () {
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
}
