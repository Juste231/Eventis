
import 'dart:convert';

List<Event> eventFromJson(String str) => List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));
String eventToJson(List<Event> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Event {
  String? id;
  String? title;
  String? description;
  String? location;
  DateTime? date;
  int? capacity;
  int? ticketsSold;
  int? price;
  String? category;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Event(
      {this.id,
        this.title,
        this.description,
        this.location,
        this.date,
        this.capacity,
        this.category,
        this.image,
        this.ticketsSold,
        this.price,
        this.createdAt,
        this.updatedAt});

  factory Event.fromJson(Map<String, dynamic> json) => Event(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      category: json['category'],
      image: json['image'],
      date: json['date'] == null ? null : DateTime.parse(json["date"]),
      capacity: json['capacity'],
      ticketsSold: json['ticketsSold'],
      price: json['price'],
      createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['location'] = location;
    data['date'] = date?.toIso8601String();
    data['capacity'] = capacity;
    data['image'] = image;
    data['category'] = category;
    data['ticketsSold'] = ticketsSold;
    data['price'] = price;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    return data;
  }

  static List<Event> fromResponse(dynamic json) {
    if (json is Map<String, dynamic> && json['events'] is List) {
      return (json['events'] as List).map((e) => Event.fromJson(e)).toList();
    } else if (json is Map<String, dynamic> && json['event'] != null) {
      return [Event.fromJson(json['event'])];
    }
    throw Exception("Invalid response format");
  }
}