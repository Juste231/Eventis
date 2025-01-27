class Payment {
  String? id;
  List<String>? reservationIds;
  String? transactionId;
  int? amount;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Payment(
      {this.id,
      this.reservationIds,
      this.transactionId,
      this.amount,
      this.status,
      this.createdAt,
      this.updatedAt});

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json['_id'],
        reservationIds: json['reservationIds'].cast<String>(),
        transactionId: json['transactionId'],
        amount: json['amount'],
        status: json['status'],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['reservationIds'] = reservationIds;
    data['transactionId'] = transactionId;
    data['amount'] = amount;
    data['status'] = status;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    return data;
  }
}
