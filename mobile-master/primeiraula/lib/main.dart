import 'package:flutter/material.dart';
import 'pages/conversor_page.dart';
import 'splash_screen.dart'; // importe o splash

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conversor de Moedas',
      theme: ThemeData(useMaterial3: true),
      home: const SplashScreen(), // agora inicia pelo splash
    );
  }
}
