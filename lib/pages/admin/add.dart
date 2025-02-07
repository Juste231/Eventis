import 'package:dio/dio.dart';
import 'package:eventiss/api/models/event.dart';
import 'package:eventiss/api/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:intl/intl.dart';

class AddTicketPage extends StatefulWidget {
  @override
  _AddTicketPageState createState() => _AddTicketPageState();
}


class _AddTicketPageState extends State<AddTicketPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TimeOfDay _selectedStartTime = TimeOfDay(hour: 15, minute: 0);
  TimeOfDay _selectedEndTime = TimeOfDay(hour: 23, minute: 0);

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final dateController = TextEditingController();
  final List<String> categories = ['CONCERT', 'THEATRE', 'SPORTS', 'FESTIVAL', 'CINEMA'];
  String? selectedCategory;
  final capacityController = TextEditingController(text: '0');

  final TextEditingController _startTimeController = TextEditingController(
      text: '15:00');
  final TextEditingController _endTimeController = TextEditingController(
      text: '23:00');
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;
  EventService eventService = EventService();

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
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85, // Ajout d'une qualité d'image pour réduire la taille
      ).catchError((error) {
        print("Erreur lors de la sélection: $error");
        Fluttertoast.showToast(
          msg: "Impossible d'accéder à la galerie",
          gravity: ToastGravity.TOP,
        );
        return null;
      });

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Erreur générale: $e");
      Fluttertoast.showToast(
        msg: "Une erreur est survenue lors de la sélection de l'image",
        gravity: ToastGravity.TOP,
      );
    }
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  createEvent() async {
    setState(() {
      isLoading = true;
    });
    try {
      FormData eventData = FormData.fromMap({
        'image': _imageFile != null
            ? await MultipartFile.fromFile(_imageFile!.path, filename: _imageFile!.path.split('/').last)
            : null,
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'location': locationController.text.trim(),
        'category': selectedCategory,
        'date': _selectedDate != null ? DateFormat('yyyy-MM-dd').format(
            _selectedDate!) : null,
        'start_time': _selectedStartTime,
        'end_time': _selectedEndTime,
        'price': int.parse(ticketPrices['Standard']!.text.trim()),
        'capacity': int.parse(capacityController.text.trim()),
        'ticketsSold': 0
      });

      Event event = await eventService.create(eventData);
      print("Event créee $event");
      Fluttertoast.showToast(msg: "Evenement crée avec succès", gravity: ToastGravity.TOP_LEFT);

      titleController.text = "";
      descriptionController.text = "";
      locationController.text = "";
      capacityController.text = "";
      descriptionController.text = "";
    } on DioException catch (e) {
      if (e.response != null) {
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

  @override
  Widget build(BuildContext context) {
    Widget categoryDropdown = DropdownButtonFormField<String>(
      value: selectedCategory,
      decoration: InputDecoration(
        labelText: 'Catégorie *',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: categories.map((String category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedCategory = newValue;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez sélectionner une catégorie';
        }
        return null;
      },
    );
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
                                controller: titleController,
                                decoration: InputDecoration(
                                  labelText: 'Titre *',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ce champ est requis';
                                  }
                                  return null;
                                },
                            ),
                          ),
                          SizedBox(width: 16),
                          // Type Field
                          Expanded(
                            child: categoryDropdown,
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
                              controller: dateController,
                              readOnly: true,
                              onTap: _selectDate,
                              decoration: InputDecoration(
                                labelText: 'Date',
                                filled: true,
                                suffixIcon: Icon(Icons.calendar_today),
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
                              controller: locationController,
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
                      ...ticketPrices.entries.map((entry) =>
                          Padding(
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
                        controller: capacityController,
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
                        controller: descriptionController,
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await createEvent();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('Ajouter'),
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
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    ticketPrices.values.forEach((controller) => controller.dispose());
    super.dispose();
  }
}