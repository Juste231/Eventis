import 'dart:async';

import 'package:eventiss/api/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class PaymentWebViewPage extends StatefulWidget {
  final String paymentUrl;
  final Function(bool success)? onPaymentComplete;

  const PaymentWebViewPage({
    Key? key,
    required this.paymentUrl,
    this.onPaymentComplete,
  }) : super(key: key);

  @override
  _PaymentWebViewPageState createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    // Création du contrôleur avec la bonne plateforme
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      controller = WebViewController.fromPlatformCreationParams(
        WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: true,
          mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
        ),
      );
    } else {
      controller = WebViewController.fromPlatformCreationParams(
        const PlatformWebViewControllerCreationParams(),
      );
    }

    // Configuration du contrôleur
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
              hasError = false;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
            checkPaymentStatus(url);
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              hasError = true;
              errorMessage = error.description;
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));

    // Configuration spécifique à Android
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(false); // Mettre à true seulement en debug
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

  }

  void checkPaymentStatus(String url) {
    print("URL $url");
    if (url.contains('approved')) {
      Uri uri = Uri.parse(url);
      String? status = uri.queryParameters['status'];
      String? id = uri.queryParameters['id'];
      print('Statut: $status, ID: $id');
      PaymentService().handleCallback({
        "transaction_id": id
      });

      Navigator.of(context).pop(true);
    } else if (url.contains('cancel') || url.contains('failure')) {
      print("URL $url");
      widget.onPaymentComplete?.call(false);
      Navigator.of(context).pop(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Effectuer le paiement"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ),
      body: Stack(
        children: [
          if (hasError)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Erreur: $errorMessage'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      controller.reload();
                      setState(() {
                        hasError = false;
                        isLoading = true;
                      });
                    },
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            )
          else
            WebViewWidget(controller: controller),
          if (isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}