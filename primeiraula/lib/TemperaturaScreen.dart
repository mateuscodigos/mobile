// temperatura_screen.dart
import 'package:flutter/material.dart';

class TemperaturaScreen extends StatefulWidget {
  @override
  _TemperaturaScreenState createState() => _TemperaturaScreenState();
}

class _TemperaturaScreenState extends State<TemperaturaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllerCelsius = TextEditingController();
  String _resultado = '';

  void _converter() {
    if (_formKey.currentState!.validate()) {
      // Converte a temperatura (substitui vírgula por ponto para parse)
      final celsius = double.parse(_controllerCelsius.text.replaceAll(',', '.'));
      final fahrenheit = (celsius * 9/5) + 32;
      
      setState(() {
        _resultado = '${celsius.toStringAsFixed(1)}°C = ${fahrenheit.toStringAsFixed(1)}°F';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor Celsius para Fahrenheit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _controllerCelsius,
                decoration: InputDecoration(labelText: 'Temperatura em Celsius (°C)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a temperatura';
                  }
                  if (double.tryParse(value.replaceAll(',', '.')) == null) {
                    return 'Informe um número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _converter,
                child: Text('Converter'),
              ),
              SizedBox(height: 20),
              Text(
                _resultado,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
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