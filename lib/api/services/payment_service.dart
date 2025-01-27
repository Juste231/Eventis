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
    return PaymentInit(
      paymentId: json['paymentId'],
      paymentUrl: json['paymentUrl'],
      transactionId: json['transactionId'],
      totalAmount: json['totalAmount'],
      numberOfReservations: json['numberOfReservations'],
    );
  }
}

class PaymentService {
  Dio api = configureDio();

  Future<PaymentInit> initializePayment(List<String> reservationIds) async {
    try {
      final response = await api
          .post('/payments/', data: {'reservationIds': reservationIds});

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
}
