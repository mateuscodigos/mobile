// lib/main.dart
import 'package:flutter/material.dart';
import 'conversor_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Moeda e Temperatura',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ConversorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}