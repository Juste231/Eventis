class Dashboard{
  final int totalEvents;
  final int upcomingEvents;
  final int ongoingEvents;
  final int finishedEvents;
  final int totalRevenue;
  final int totalTickets;

  Dashboard({
    required this.totalEvents,
    required this.upcomingEvents,
    required this.ongoingEvents,
    required this.finishedEvents,
    required this.totalRevenue,
    required this.totalTickets,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
      totalEvents: json['totalEvents'],
      upcomingEvents: json['upcomingEvents'],
      ongoingEvents: json['ongoingEvents'],
      finishedEvents: json['finishedEvents'],
      totalRevenue: json['totalRevenue'],
      totalTickets: json['totalTickets'],
    );
  }
}
