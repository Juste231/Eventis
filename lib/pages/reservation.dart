import 'package:flutter/material.dart';

class reservation extends StatefulWidget {
  const reservation({super.key});

  @override
  State<reservation> createState() => _reservationState();
}

class _reservationState extends State<reservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('reservation'),
    );
  }
}
