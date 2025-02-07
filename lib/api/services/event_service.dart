import 'package:dio/dio.dart';
import 'package:eventiss/api/dio_instance.dart';
import 'package:eventiss/api/models/event.dart';

class EventService {
  Dio api = configureDio();

  Future<List<Event>> getAll() async {
    final response = await api.get('/events');
    return Event.fromResponse(response.data);
  }

  Future<Event> getById(String id) async {
    final response = await api.get('events/$id');
    return Event.fromResponse(response.data).first;
  }

  Future<Event> create(FormData data) async {
    final response = await api.post('/events/create', data: data);
    return Event.fromJson(response.data);
  }

  Future<Event> update(Map<String, String> data, String id) async {
    final response = await api.put('/events/$id', data: data);
    return Event.fromJson(response.data);
  }

  Future<Event> delete(String id) async {
    final response = await api.delete('/events/$id');
    return Event.fromJson(response.data);
  }
}