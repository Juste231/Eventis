import 'dart:convert';

List<Ticket> ticketFromJson(String str) =>
    List<Ticket>.from(json.decode(str).map((x) => Ticket.fromJson(x)));

String ticketToJson(List<Ticket> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ticket {
  final String? id;
  final String? reservationId;
  final String? qrCode;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Ticket({
    this.id,
    this.reservationId,
    this.qrCode,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['_id'],
      reservationId: json['reservationId'],
      qrCode: json['qrCode'],
      status: json['status'],
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'reservationId': reservationId,
      'qrCode': qrCode,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}


