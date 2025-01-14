import 'package:dio/dio.dart';
import 'package:eventiss/api/dio_instance.dart';
import 'package:eventiss/api/models/ticket.dart';


class TicketService {
  Dio api = configureDio();

  Future<List<Ticket>> getAll(String id) async {
    final response = await api.get('/tickets/$id');
    return (response.data['tickets'] as List)
        .map((e) => Ticket.fromJson(e))
        .toList();
  }

  Future<Ticket> getTicket(String qrCode) async {
    final response = await api.post('/tickets', data: {'qrCode': qrCode});
    return Ticket.fromJson(response.data);
  }

  Future<void> validateTicket(String qrCode) async {
    await api.post('/tickets/validate', data: {'qrCode': qrCode});
  }
}
