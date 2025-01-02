import 'package:flutter/material.dart';

class paymentpage extends StatefulWidget {
  final Map<String, dynamic> reservationData;

  const paymentpage({
    Key? key,
    required this.reservationData,
  }) : super(key: key);

  @override
  State<paymentpage> createState() => _paymentpageState();
}

class _paymentpageState extends State<paymentpage> {
  String? selectedPaymentMethod;
  final TextEditingController operatorController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Structure des modes de paiement et leurs champs
  final Map<String, Map<String, dynamic>> paymentMethods = {
    'Mobile Money': {
      'icon': 'assets/icons/mobile_money.png',
      'subtitle': 'MTN, MOOV, WAVE',
      'fields': ['Opérateur', 'Numéro', 'Email']
    },
    'Carte Bancaire': {
      'icon': 'assets/icons/bank_card.png',
      'subtitle': 'VISA, MASTERCARD',
      'fields': ['Numéro de carte', 'Date d\'expiration', 'CVV', 'Email']
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Votre Réservation'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carte de résumé de réservation
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFFFF3EE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.reservationData['image'] ?? '',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.reservationData['title']} - ${widget.reservationData['ticketType']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(widget.reservationData['date'] ?? ''),
                        Text(widget.reservationData['location'] ?? ''),
                        Text('Qté: ${widget.reservationData['quantity']}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Quel mode de paiement vous convient le mieux?',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Menu déroulant des modes de paiement
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text('Entrez une option'),
                  value: selectedPaymentMethod,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  items: paymentMethods.keys.map((String method) {
                    return DropdownMenuItem<String>(
                      value: method,
                      child: Row(
                        children: [
                          Image.asset(
                            paymentMethods[method]!['icon'],
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(method),
                              Text(
                                paymentMethods[method]!['subtitle'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 24),

            // Champs dynamiques basés sur le mode de paiement
            if (selectedPaymentMethod != null) ...[
              ...paymentMethods[selectedPaymentMethod]!['fields']
                  .map((field) => buildTextField(field))
                  .toList(),

              // Montant
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Montant',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${widget.reservationData['amount']} FCFA',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Bouton Payer
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: selectedPaymentMethod == null ? null : () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0F1728),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Payer',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        keyboardType: label.toLowerCase().contains('numéro') ||
            label.toLowerCase().contains('cvv')
            ? TextInputType.number
            : label.toLowerCase().contains('email')
            ? TextInputType.emailAddress
            : TextInputType.text,
      ),
    );
  }
}