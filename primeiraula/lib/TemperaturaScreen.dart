// lib/temperatura_screen.dart
import 'package:flutter/material.dart';

class TemperaturaScreen extends StatefulWidget {
  @override
  _TemperaturaScreenState createState() => _TemperaturaScreenState();
}

class _TemperaturaScreenState extends State<TemperaturaScreen> {
  final _controllerCelsius = TextEditingController();
  String _resultado = '';

  void _converter() {
    final text = _controllerCelsius.text;
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Informe uma temperatura válida.')),
      );
      return;
    }

    final celsius = double.tryParse(text.replaceAll(',', '.'));
    if (celsius == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Número inválido.')),
      );
      return;
    }

    final fahrenheit = (celsius * 9 / 5) + 32;
    setState(() {
      _resultado = '${celsius.toStringAsFixed(1)}°C = ${fahrenheit.toStringAsFixed(1)}°F';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor Celsius para Fahrenheit'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controllerCelsius,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Temperatura em Celsius (°C)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _converter,
              child: Text('Converter para Fahrenheit'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
            SizedBox(height: 20),
            if (_resultado.isNotEmpty)
              Text(
                _resultado,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerCelsius.dispose();
    super.dispose();
  }
}
