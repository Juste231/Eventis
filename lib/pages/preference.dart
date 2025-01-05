import 'package:flutter/material.dart';

class preference extends StatefulWidget {
  const preference({Key? key}) : super(key: key);

  @override
  State<preference> createState() => _preferenceState();
}

class _preferenceState extends State<preference> {
  bool notificationsEnabled = false;
  bool soundEnabled = false;
  bool darkThemeEnabled = false;

  Widget _buildPreferenceItem({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3D3BD),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Switch.adaptive(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Préférences',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPreferenceItem(
                  title: 'Notifications',
                  value: notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),
                _buildDescription(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc tempus arcu a lorem et tempus.',
                ),
                _buildPreferenceItem(
                  title: 'Sons',
                  value: soundEnabled,
                  onChanged: (value) {
                    setState(() {
                      soundEnabled = value;
                    });
                  },
                ),
                _buildDescription(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc tempus arcu a lorem et tempus.',
                ),
                _buildPreferenceItem(
                  title: 'Thème sombre',
                  value: darkThemeEnabled,
                  onChanged: (value) {
                    setState(() {
                      darkThemeEnabled = value;
                    });
                  },
                ),
                _buildDescription(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc tempus arcu a lorem et tempus.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}