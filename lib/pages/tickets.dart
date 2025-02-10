import 'package:flutter/material.dart';
import 'package:eventiss/api/models/ticket.dart';
import 'package:eventiss/api/services/ticket_service.dart';

import '../api/util/ticket_generator.dart';

class TicketsPage extends StatefulWidget {
  final String? reservationId;
  final List<String>? reservationIds;

  const TicketsPage({
    super.key,
    this.reservationId,
    this.reservationIds
  });

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TicketService ticketService = TicketService();
  bool isLoading = true;
  List<Ticket> tickets = [];
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchTickets();
  }

  Future<void> _handleTicketDownload(Ticket ticket) async {
    // Use the scaffold's context instead of the ListView item's context
    BuildContext stableContext = _scaffoldKey.currentContext ?? context;
    try {
      await generateTicketPDF(ticket, stableContext);
    } catch (e) {
      // Add error handling
      if (mounted) {  // Check if widget is still mounted
        ScaffoldMessenger.of(stableContext).showSnackBar(
          SnackBar(content: Text('Error downloading ticket: ${e.toString()}')),
        );
      }
    }
  }
  Future<void> _fetchTickets() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (widget.reservationId == null && widget.reservationIds == null) {
        tickets = await ticketService.getAll();
      }
      else if (widget.reservationId != null) {
        tickets = await ticketService.getTicketById(widget.reservationId!);
      }
      else if (widget.reservationIds != null) {
        tickets = await ticketService.getAll();
      }
    } catch (e) {
      error = e.toString();
      print("Error $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text("Mes Tickets")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text("Ticket ${ticket.id?.substring(0, 8).toUpperCase()}"),
              subtitle: Text("Statut: ${ticket.status}"),
              trailing: ElevatedButton(
                onPressed: () => _handleTicketDownload(ticket),
                child: const Text("Télécharger"),
              ),
              onTap: () {
                // Optionnel : ouvrir la page de détail du ticket si besoin
              },
            ),
          );
        },
      ),
    );
  }
}
