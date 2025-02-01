import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddTicketPage extends StatefulWidget {
  @override
  _AddTicketPageState createState() => _AddTicketPageState();
}

class _AddTicketPageState extends State<AddTicketPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedTicketType = 'Standard';
  bool _showAffiche = false;
  TimeOfDay _selectedStartTime = TimeOfDay(hour: 15, minute: 0);
  TimeOfDay _selectedEndTime = TimeOfDay(hour: 23, minute: 0);
  final TextEditingController _startTimeController = TextEditingController(text: '15:00');
  final TextEditingController _endTimeController = TextEditingController(text: '23:00');
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Map<String, TextEditingController> ticketPrices = {
    'Standard': TextEditingController(),
    'VIP': TextEditingController(),
    'Premium': TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    _setStartTimeText();
    _setEndTimeText();
  }

  void _setStartTimeText() {
    final String hour = _selectedStartTime.hour.toString().padLeft(2, '0');
    final String minute = _selectedStartTime.minute.toString().padLeft(2, '0');
    _startTimeController.text = '$hour:$minute';
  }

  void _setEndTimeText() {
    final String hour = _selectedEndTime.hour.toString().padLeft(2, '0');
    final String minute = _selectedEndTime.minute.toString().padLeft(2, '0');
    _endTimeController.text = '$hour:$minute';
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE4D9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ajoutez de nouveaux tickets',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 24),

                      // Image Picker
                      InkWell(
                        onTap: _pickImage,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _imageFile != null
                              ? Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                          )
                              : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate, size: 50),
                                Text('Ajouter une image'),
                              ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Nom Field
                      Row(
                        children: [
                          // Nom Field
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Nom',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          // Type Field
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Type',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Time Fields Row
                      Row(
                        children: [
                          // Start Time Field
                          Expanded(
                            child: TextFormField(
                              controller: _startTimeController,
                              readOnly: true,
                              onTap: () async {
                                final TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: _selectedStartTime,
                                );
                                if (time != null) {
                                  setState(() {
                                    _selectedStartTime = time;
                                    _setStartTimeText();
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Heure de début',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: Icon(Icons.access_time),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          // End Time Field
                          Expanded(
                            child: TextFormField(
                              controller: _endTimeController,
                              readOnly: true,
                              onTap: () async {
                                final TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: _selectedEndTime,
                                );
                                if (time != null) {
                                  setState(() {
                                    _selectedEndTime = time;
                                    _setEndTimeText();
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Heure de fin',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: Icon(Icons.access_time),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          // Date Field
                          Expanded(
                            child: TextFormField(
                              initialValue: '15/03/25',
                              decoration: InputDecoration(
                                labelText: 'Date',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          // Lieu Field
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Lieu',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Ticket Types with Prices
                      Text(
                        'Prix des tickets',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      ...ticketPrices.entries.map((entry) => Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(entry.key),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: entry.value,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Prix',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  suffixText: 'FCFA',
                                ),
                              ),
                            ),
                          ],
                        ),
                      )).toList(),

                      // Number of tickets
                      TextFormField(
                        initialValue: '0',
                        decoration: InputDecoration(
                          labelText: 'Disponibilité des tickets',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Description Field
                      TextFormField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Handle form submission
                            }
                          },
                          child: Text('Ajouter'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    ticketPrices.values.forEach((controller) => controller.dispose());
    super.dispose();
  }
}