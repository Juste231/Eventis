import 'package:flutter/material.dart';
import 'package:eventiss/api/models/event.dart';
import 'package:eventiss/api/services/event_service.dart';

class EventProvider with ChangeNotifier {
  final EventService _eventService = EventService();
  List<Event> _events = [];
  bool _isLoading = false;

  List<Event> get events => _events;
  bool get isLoading => _isLoading;

  Future<void> fetchEvents() async {
    _isLoading = true;
    notifyListeners();
    try {
      _events = await _eventService.getAll();
    } catch (e) {
      print("Erreur lors de la récupération des événements : $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
