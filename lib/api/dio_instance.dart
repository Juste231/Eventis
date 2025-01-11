import 'package:dio/dio.dart';
import 'package:eventiss/api/util/session_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio configureDio() {
  final options = BaseOptions(
    baseUrl: 'http://192.168.122.1:3000/api',
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
  );
  final dio = Dio(options);

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final sharedPref = await SharedPreferences.getInstance();
      final token = sharedPref.getString("token");

      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
    onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        await SessionHandler.showSessionExpiredDialog();
      }
      return handler.next(error);
    },
  ));
  return dio;
}