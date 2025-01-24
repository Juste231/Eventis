import 'package:dio/dio.dart';
import 'package:eventiss/api/dio_instance.dart';
import 'package:eventiss/api/util/eventprovider.dart';
import 'package:eventiss/api/util/session_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
    );
  }
}
