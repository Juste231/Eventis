import 'package:flutter/material.dart';

class securite extends StatelessWidget {
  const securite({Key? key}) : super(key: key);

  Widget _buildSecurityItem({
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card Container
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3E7),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        // Description Text outside container
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Sécurité',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSecurityItem(
                title: 'Modifier mon mot de passe',
                description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, nunc tempus arcu a lorem et tempus.',
                onTap: () {
                  debugPrint('Modifier mot de passe');
                },
              ),
              _buildSecurityItem(
                title: 'Supprimer mon compte',
                description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, nunc tempus arcu a lorem et tempus.',
                onTap: () {
                  debugPrint('Supprimer compte');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}