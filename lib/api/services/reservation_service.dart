import 'package:dio/dio.dart';
import 'package:eventiss/api/dio_instance.dart';
import 'package:eventiss/api/models/reservation.dart';

class ReservationService {
  Dio api = configureDio();

  Future<List<Reservation>> getAll() async {
    final response = await api.get('/reservations');
    return (response.data['reservations'] as List).map((e) => Reservation.fromJson(e)).toList();
  }

  Future<Reservation> create(Map<String, dynamic> data) async {
    /*
    * data {
    *   "eventId": "6771a3c8a2e0834396938224",
    *   "numberOfTickets": 2
    * }
    * */
    final response = await api.post('/reservations/create', data: data);
    return Reservation.fromJson(response.data);
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