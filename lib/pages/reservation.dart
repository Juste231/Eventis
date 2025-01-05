import 'package:flutter/material.dart';

class reservation extends StatelessWidget {
  const reservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tickets réservés',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Voir tout'),
                ),
              ],
            ),
          ),

          // Tickets Grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildTicketCard(
                  title: 'RED ROOM RECORD',
                  date: '19 Décembre 2024',
                  venue: 'Palais des congrès',
                  imageUrl: 'images/mark1.jpg',
                  hasQrCode: true,
                ),
                _buildTicketCard(
                  title: 'SHOW',
                  date: '20 Décembre 2024',
                  venue: 'Nouvelle',
                  imageUrl: 'images/mark5.jpg',
                ),
                _buildTicketCard(
                  title: 'Vip party',
                  date: '15 Décembre 2024',
                  venue: 'Canal olympia',
                  imageUrl: 'images/mark2.jpeg',
                  isPending: true,
                ),
                _buildTicketCard(
                  title: 'Match',
                  date: '28 Février 2024',
                  venue: 'Stade la réunion',
                  imageUrl: 'images/ifrilogo.jpeg',
                  isPending: true,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildTicketCard({
    required String title,
    required String date,
    required String venue,
    required String imageUrl,
    bool hasQrCode = false,
    bool isPending = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
                if (hasQrCode)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(Icons.qr_code, size: 20),
                    ),
                  ),
              ],
            ),
          ),

          // Info
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  venue,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                if (isPending)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.orange.shade700,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'En attente de paiement',
                          style: TextStyle(
                            color: Colors.orange.shade700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
