import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:band_names/services/socket_service.dart';

import 'package:band_names/screens/screens.dart';
import 'package:band_names/screens/status_page.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocketService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomePage(),
        'status': (context) => const StatusPage()
      },
    );
  }
}
