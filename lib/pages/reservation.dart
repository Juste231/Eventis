import 'package:dio/dio.dart';
import 'package:eventiss/api/models/reservation.dart';
import 'package:eventiss/api/services/reservation_service.dart';
import 'package:eventiss/pages/paymentwebview.dart';
import 'package:eventiss/pages/tickets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/services/payment_service.dart';
import '../widgets/image_loader.dart';

class reservation extends StatefulWidget {
  const reservation({super.key});

  @override
  State<reservation> createState() => _reservationState();
}

class _reservationState extends State<reservation> {
  final ReservationService reservationService = ReservationService();
  bool isLoading = true;
  List<Reservation> reservations = [];
  String? error;

  @override
  void initState() {
    super.initState();
    fetchReservations();
  }

  Future<void> fetchReservations() async {
    try {
      reservations = await reservationService.getAll();
      print("Reservations $reservations");
    } on DioException catch (e) {
      print("Error ${e.message}");
    } catch (e) {
      print("Other error $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tickets réservés',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Tickets Grid
                reservations.isEmpty
                    ? Column(
                        children: [
                          Center(
                            child: Text("Aucune réservation"),
                          )
                        ],
                      )
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.75,
                          ),
                          padding: const EdgeInsets.all(16),
                          itemCount: reservations.length,
                          itemBuilder: (context, index) {
                            return _buildTicketCard(
                              reservation: reservations[index],
                              context: context,
                            );
                          },
                        ),
                      ),
              ],
            ),
    );
  }

  Widget _buildTicketCard(
      {required Reservation reservation, required BuildContext context}) {
    final event = reservation.event;
    return GestureDetector(
      onTap: () async {
        if (reservation.paymentStatus?.toUpperCase() == "PENDING") {
          final paymentInit =
              await PaymentService().initializePayment([reservation.id!]);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PaymentWebViewPage(paymentUrl: paymentInit.paymentUrl),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TicketsPage(reservationId: reservation.id)),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CustomImage(
                    imageUrl: event?.image,
                    placeholder: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.grey.shade300,
                      child: Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: Colors.grey.shade500,
                          size: 50,
                        ),
                      ),
                    ),
                    errorWidget: Center(
                      child: Icon(Icons.error, color: Colors.red, size: 50),
                    ),
                  ),
                  if (reservation.paymentStatus?.toUpperCase() != "PENDING")
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(Icons.qr_code, size: 20),
                      ),
                    ),
                ],
              ),
            ),
            // Informations
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Affiche le titre de l'événement ou un texte par défaut
                  Text(
                    event?.title ?? 'Sans titre',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Affiche la date de l'événement formatée (ou "Date inconnue")
                  Text(
                    event?.date != null
                        ? DateFormat('dd MMM yyyy').format(event!.date!)
                        : 'Date inconnue',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  // Affiche le lieu de l'événement
                  Text(
                    event?.location ?? '',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  // Si le paiement est en attente, affiche un message d'attente
                  if (reservation.paymentStatus?.toUpperCase() == "PENDING")
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.orange.shade700,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'En attente de paiement',
                            style: TextStyle(
                              color: Colors.orange.shade700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
