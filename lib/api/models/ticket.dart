import 'dart:convert';

import 'package:eventiss/api/models/reservation.dart';

List<Ticket> ticketFromJson(String str) =>
    List<Ticket>.from(json.decode(str).map((x) => Ticket.fromJson(x)));

String ticketToJson(List<Ticket> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ticket {
  final String? id;
  final Reservation? reservation;
  final String? qrCode;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Ticket({
    this.id,
    this.reservation,
    this.qrCode,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['_id'],
      reservation: json['reservation'] is Map<String, dynamic>
          ? Reservation.fromJson(json['reservation'])
          : null,
      qrCode: json['qrCode'],
      status: json['status'],
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'reservationId': reservation?.toJson(),
      'qrCode': qrCode,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}


