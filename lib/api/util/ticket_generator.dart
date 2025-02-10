import 'dart:convert';
import 'dart:io';
import 'package:eventiss/api/models/authenticated_user.dart';
import 'package:eventiss/api/util/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:eventiss/api/models/ticket.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> generateTicketPDF(Ticket ticket, BuildContext context) async {
  final scaffoldContext = Scaffold.maybeOf(context)?.context ?? context;
  final permissionHandler = PermissionHandler();

  bool hasPermission = await permissionHandler.requestStoragePermission(scaffoldContext);

  if (!hasPermission) {
    if (scaffoldContext.mounted) {
      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
        const SnackBar(
          content: Text('Permission de stockage requise pour enregistrer le ticket'),
        ),
      );
    }
    return;
  }

  final pdf = pw.Document();
  final font = await PdfGoogleFonts.robotoRegular();
  final fontBold = await PdfGoogleFonts.robotoBold();
  // Récupération des données utilisateur (exemple)
  final sharedPref = await SharedPreferences.getInstance();
  String? userData = sharedPref.getString("user");
  AuthenticatedUser user = AuthenticatedUser.fromJson(jsonDecode(userData!));

  // Récupérer les informations du ticket
  final eventTitle = ticket.reservation?.event?.title ?? "Inconnu";
  final eventDate = ticket.reservation?.event?.date != null
      ? DateFormat('dd MMM yyyy').format(ticket.reservation!.event!.date!)
      : "Date inconnue";
  final eventLocation = ticket.reservation?.event?.location ?? "Lieu inconnu";
  final userName = ticket.reservation?.user != null
      ? "${user.user?.firstname} ${user.user!.lastname}"
      : "Utilisateur inconnu";
  final eventPrice = ticket.reservation?.event?.price?.toString() ?? "0";

  // Création du contenu du PDF
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text("Votre Ticket",
                style: pw.TextStyle(
                  font: fontBold,
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                )),
            pw.SizedBox(height: 16),
            pw.Text("Événement: $eventTitle",
                style: pw.TextStyle(font: font, fontSize: 18)),
            pw.Text("Date: $eventDate", style: pw.TextStyle(fontSize: 16)),
            pw.Text("Lieu: $eventLocation", style: pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 8),
            pw.Text("Utilisateur: $userName", style: pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 16),
            // Génération du QR code dans le PDF
            pw.BarcodeWidget(
              barcode: pw.Barcode.qrCode(),
              data: ticket.qrCode ?? "",
              width: 100,
              height: 100,
            ),
            pw.SizedBox(height: 16),
            pw.Text("Ticket ID: ${ticket.id}",
                style: pw.TextStyle(fontSize: 14)),
            pw.SizedBox(height: 8),
            pw.Text("Prix: $eventPrice FCFA",
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromInt(0xff008000),
                )),
          ],
        );
      },
    ),
  );

  try {
    // Pour Android (11+), utilisez getExternalStorageDirectory() pour obtenir le répertoire spécifique à l'app
    String directoryPath;
    if (Platform.isAndroid) {
      final Directory? directory = await getExternalStorageDirectory();
      if (directory == null) {
        print("Impossible de trouver le répertoire de stockage de l'application");
        return;
      }
      directoryPath = directory.path;
    } else {
      // Pour iOS ou d'autres plateformes, vous pouvez utiliser getApplicationDocumentsDirectory()
      final Directory directory = await getApplicationDocumentsDirectory();
      directoryPath = directory.path;
    }

    final String filePath = '$directoryPath/ticket_${ticket.id}.pdf';
    final File file = File(filePath);

    await file.writeAsBytes(await pdf.save());
    print("PDF sauvegardé dans : $filePath");

    if (await file.exists()) {
      print("Fichier créé et vérifié avec succès");
      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
        SnackBar(content: Text("Ticket téléchargé dans : $filePath")),
      );
    } else {
      print("Échec de la création du fichier");
    }
  } catch (e) {
    print("Erreur lors de la sauvegarde du PDF: $e");
    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
      SnackBar(content: Text('Erreur lors de l\'enregistrement du ticket: ${e.toString()}')),
    );
  }
}