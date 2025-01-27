import 'package:dio/dio.dart';
import 'package:eventiss/api/models/event.dart';
import 'package:eventiss/api/services/reservation_service.dart';
import 'package:eventiss/pages/payementpage.dart';
import 'package:eventiss/widgets/image_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class detailevent extends StatefulWidget {
  final Event eventData;

  const detailevent({super.key, required this.eventData});

  @override
  State<detailevent> createState() => _detaileventState();
}

class _detaileventState extends State<detailevent> {
  String selectedTicketType = 'Standard'; // Valeur par défaut
  int quantity = 1; // État pour la quantité
  ReservationService reservationService = ReservationService();

  bool isLoading = false;

  // Fonction pour décrémenter
  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  reservations() async {
    setState(() {
      isLoading = true;
    });

    try {
      Map<String, dynamic> data = {
        "eventId": widget.eventData.id,
        "numberOfTickets": quantity
      };
      final result = await reservationService.create(data);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => paymentpage(
            title: widget.eventData.title!,
            ticketType: selectedTicketType,
            quantity: quantity,
            date: DateFormat.yMMMEd('fr_FR')
                .format(widget.eventData.date!),
            location: widget.eventData.location!,
            // Vous pouvez ajouter cette info dans eventData
            image: widget.eventData.image!,
            amount: widget.eventData.price!
                .toDouble(), // Remplacez par le vrai prix selon le type de ticket
          ),
        ),
      );
      print("All reservations are created $result");
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 404) {
          Fluttertoast.showToast(msg: "Event not found");
        } else if (e.response?.statusCode == 400) {
          Fluttertoast.showToast(msg: "Not enough tickets available");
        }

        print(e.response?.statusCode);
        print(e.response?.data);

        Fluttertoast.showToast(msg: "Une erreur est survenue");
      } else {
        print("Not dio error ${e.requestOptions}");
        print("Not dio error ${e.message}");

        Fluttertoast.showToast(msg: "Une erreur est survenue");
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Fonction pour incrémenter
  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Stack avec image et bouton retour (reste inchangé)
          Stack(
            children: [
              CustomImage(
                imageUrl: widget.eventData.image,
                placeholder: Container(
                  width: double.infinity,
                  height: 400,
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
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              DateFormat.yMMMEd('fr_FR')
                                  .format(widget.eventData.date!),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Contenu
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.eventData.category != null
                          ? widget.eventData.category!
                          : "CINEMA",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.eventData.title!,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(
                          'Place de l\'Amazone',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.access_time, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(
                          '18H',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque posuere, mauris nec tristique fringilla, quam turpis vulputate libero, eget dictum dui ligula vel lectus. Pellentesque ac elit eget est euismod dignissim. In ac augue at mi eleifend tincidunt. Curabitur non massa ut metus efficitur interdum eget a diam. Nunc dapibus nulla magna, at volutpat massa elementum ultricies. Nulla luctus volutpat turpis, eget scelerisque felis.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.eventData.price.toString() + ' FCFA',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedTicketType,
                              isExpanded: true,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              items: [
                                'Standard',
                                'VIP',
                                'Premium'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedTicketType = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        // Sélecteur de quantité amélioré
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Bouton moins
                                  InkWell(
                                    onTap: decrementQuantity,
                                    child: Icon(
                                      Icons.remove,
                                      color: quantity > 1
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                  // Affichage de la quantité
                                  Container(
                                    constraints: BoxConstraints(minWidth: 40),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      quantity.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  // Bouton plus
                                  InkWell(
                                    onTap: incrementQuantity,
                                    child: Icon(Icons.add, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bouton Réserver
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () async {
                await reservations();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0F1728),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: isLoading ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ) : Text(
                'Réserver',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
