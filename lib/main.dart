
import 'package:eventiss/api/util/eventprovider.dart';
import 'package:eventiss/api/util/session_handler.dart';
import 'package:eventiss/pages/historique.dart';
import 'package:eventiss/pages/preference.dart';
import 'package:eventiss/pages/securite.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'pages/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);

  if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    final WebKitWebViewPlatform platform = WebViewPlatform.instance as WebKitWebViewPlatform;
    WebKitWebViewPlatform.registerWith();
  } else {
    AndroidWebViewPlatform.registerWith();
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => EventProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: SessionHandler.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: splashScreen(),
      routes: {
        '/preferences': (context) => preference(),
        '/security': (context) => securite(),
        '/history': (context) => historique(),
      },
    );
  }
}
