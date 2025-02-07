import 'package:dio/dio.dart';
import 'package:eventiss/api/dio_instance.dart';
import 'package:eventiss/api/models/authenticated_user.dart';

class UserService {
  Dio api = configureDio();

  Future<AuthenticatedUser> login(Map<String, dynamic> data) async {
    final response =  await api.post('/auth/login', data: data);
    print("Réponse API login: ${response.data['data']}");
    return AuthenticatedUser.fromJson(response.data['data']);
  }

  Future<User> register(Map<String, dynamic> data) async {
    final response = await api.post('/auth/register', data: data);
    return User.fromJson(response.data);
  }

  Future<AuthenticatedUser> user() async {
    final response = await api.get('/auth/me');
    print(response.data);
    final authenticatedUser = AuthenticatedUser.fromJson(response.data['data']);
    return authenticatedUser;
  }
}