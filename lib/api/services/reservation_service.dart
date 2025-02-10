import 'package:dio/dio.dart';
import 'package:eventiss/api/dio_instance.dart';
import 'package:eventiss/api/models/reservation.dart';

import '../models/ticket.dart';

class ReservationService {
  Dio api = configureDio();

  Future<List<Reservation>> getAll() async {
    final response = await api.get('/reservations');
    print("Reponse de l'api ${response.data}");
    return (response.data['reservations'] as List)
        .map((e) => Reservation.fromJson(e))
        .toList();
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> data) async {
    final response = await api.post('/reservations/create', data: data);
    final responseData = response.data['data'];

    final reservations = (responseData['reservations'] as List)
        .map((e) => Reservation.fromJson(e))
        .toList();

    final tickets = (responseData['tickets'] as List)
        .map((e) => Ticket.fromJson(e))
        .toList();

    return {
      'reservations': reservations,
      'tickets': tickets,
    };
  }

  Future<Reservation> getById(String id) async {
    final response = await api.get('/reservations/$id');
    return Reservation.fromJson(response.data['reservation']);
  }

  Future<Reservation> updateStatus(String id) async {
    final response = await api.put('/reservations/$id');
    return Reservation.fromJson(response.data);
  }

  Future<void> delete(String id) async {
    await api.delete('/reservations/$id');
  }
}
