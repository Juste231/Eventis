import 'package:flutter/material.dart';

class notificationspage extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Confirmation d\'achat de ticket',
      'message': 'Votre ticket pour wofeliveyes a été confirmé',
      'type': 'confirmation',
      'time': '9:41'
    },
    {
      'title': 'Tickets en attente de paiement',
      'message': 'Votre réservation pour wolezeyes expire dans 2h',
      'type': 'pending',
      'time': '45m'
    },
    {
      'title': 'Tickets expirés',
      'message': 'Votre ticket pour wolenewyes a expiré',
      'type': 'expired',
      'time': '1h'
    },
    {
      'title': 'Rappels d\'événements à venir',
      'message': 'N\'oubliez pas : wolenewyes se déroule le 30 décembre à 9h',
      'type': 'reminder',
      'time': '2h'
    },
    {
      'title': 'Modification d\'événements',
      'message': 'L\'événement woleneyes a été déplacé au Palais des congrès',
      'type': 'update',
      'time': '3h'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF9F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Ajouter la logique pour effacer toutes les notifications
            },
            child: Text(
              'Tout effacer',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Dismissible(
            key: Key(index.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              // Ajouter la logique pour supprimer la notification
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _getBackgroundColor(notification['type']),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  notification['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      notification['message'],
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      notification['time'],
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Ajouter la logique pour gérer le tap sur la notification
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getBackgroundColor(String type) {
    switch (type) {
      case 'confirmation':
        return Color(0xFFE8F5E9); // Vert clair
      case 'pending':
        return Color(0xFFFFF3E0); // Orange clair
      case 'expired':
        return Color(0xFFFFEBEE); // Rouge clair
      case 'reminder':
        return Color(0xFFE3F2FD); // Bleu clair
      case 'update':
        return Color(0xFFF3E5F5); // Violet clair
      default:
        return Colors.white;
    }
  }
}