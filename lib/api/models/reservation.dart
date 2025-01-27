import 'dart:convert';

List<Reservation> reservationFromJson(String str) => List<Reservation>.from(
    json.decode(str).map((x) => Reservation.fromJson(x)));

String reservationToJson(List<Reservation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reservation {
  String? event;
  String? user;
  String? paymentStatus;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  Reservation(
      {this.event,
      this.user,
      this.paymentStatus,
      this.id,
      this.createdAt,
      this.updatedAt});

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
        id: json['_id'],
        event: json['event'],
        user: json['user'],
        paymentStatus: json['paymentStatus'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event'] = event;
    data['user'] = user;
    data['paymentStatus'] = paymentStatus;
    data['_id'] = id;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();

    return data;
  }
}
