import 'package:dio/dio.dart';
import 'package:eventiss/api/dio_instance.dart';
import 'package:eventiss/api/models/ticket.dart';


class TicketService {
  Dio api = configureDio();

  Future<List<Ticket>> getAll() async {
    final response = await api.get('/ticket/all');
    return (response.data['tickets'] as List)
        .map((e) => Ticket.fromJson(e))
        .toList();
  }

  Future<Ticket> getTicket(String qrCode) async {
    final response = await api.post('/ticket', data: {'qrCode': qrCode});
    return Ticket.fromJson(response.data);
  }

  Future<List<Ticket>> getTicketById(String id) async {
    final response = await api.get('/ticket/$id');
    return (response.data['tickets'] as List)
        .map((e) => Ticket.fromJson(e))
        .toList();
  }

  Future<void> validateTicket(String qrCode) async {
    await api.post('/ticket/validate', data: {'qrCode': qrCode});
  }
}
