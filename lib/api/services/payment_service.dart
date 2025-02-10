import 'package:dio/dio.dart';
import 'package:eventiss/api/dio_instance.dart';

import '../models/payment.dart';

class PaymentInit {
  final String paymentId;
  final String paymentUrl;
  final String transactionId;
  final int totalAmount;
  final int numberOfReservations;

  PaymentInit({
    required this.paymentId,
    required this.paymentUrl,
    required this.transactionId,
    required this.totalAmount,
    required this.numberOfReservations,
  });

  factory PaymentInit.fromJson(Map<String, dynamic> json) {
    if (json['data'] == null) {
      throw Exception('La réponse ne contient pas de données');
    }

    final data = json['data'];

    if (data['paymentId'] == null || data['paymentUrl'] == null ||
        data['transactionId'] == null || data['totalAmount'] == null ||
        data['numberOfReservations'] == null) {
      throw Exception('Données de paiement incomplètes: ${json.toString()}');
    }

    return PaymentInit(
      paymentId: data['paymentId'].toString(),
      paymentUrl: data['paymentUrl'].toString(),
      transactionId: data['transactionId'].toString(),
      totalAmount: data['totalAmount'] is int
          ? data['totalAmount']
          : int.parse(data['totalAmount'].toString()),
      numberOfReservations: data['numberOfReservations'] is int
          ? data['numberOfReservations']
          : int.parse(data['numberOfReservations'].toString()),
    );
  }
}

class PaymentService {
  Dio api = configureDio();

  Future<PaymentInit> initializePayment(List<String> reservationIds) async {
    try {
      final response = await api
          .post('/payments/', data: {'reservationIds': reservationIds});
      print("Response ${response.data}");
      return PaymentInit.fromJson(response.data);
    } catch (e) {
      throw Exception("Erreur lors de l'initialisation du paiement $e");
    }
  }

  Future<Payment> getPaymentStatus(String paymentId) async {
    try {
      final response = await api.get('/payments/$paymentId');
      return Payment.fromJson(response.data);
    } catch (e) {
      throw Exception('Erreur lors de la récupération du statut $e');
    }
  }

  Future<void> handleCallback(Map<String, dynamic> data) async {
    try {
      final response = await api.post('/payments/callback', data: data);
      print("Response du callback $response");
    } catch (e) {
      print("Error $e");
    }
  }
}
