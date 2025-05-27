import 'package:flutter/material.dart';
import 'temperaturaScreen.dart'; // Certifique-se de que esse arquivo exista

void main() {
  runApp(ConversorApp());
}

class ConversorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor Real → Dólar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConversorPage(),
    );
  }
}

class ConversorPage extends StatefulWidget {
  @override
  _ConversorPageState createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage> {
  final TextEditingController _realController = TextEditingController();
  double? _resultado;
  double _taxaDolar = 5.20; // Cotação de exemplo

  void _converter() {
    final texto = _realController.text;
    if (texto.isEmpty) return;

    final real = double.tryParse(texto.replaceAll(',', '.'));
    if (real == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, insira um número válido.')),
      );
      return;
    }

    setState(() {
      _resultado = real / _taxaDolar;
    });
  }

  void _navegarParaTemperatura() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TemperaturaScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor Real para Dólar'), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _realController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Valor em Reais (R\$)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _converter,
              child: Text('Converter para Dólar'),
            ),
            SizedBox(height: 30),
            if (_resultado != null)
              Text(
                'Resultado: \$${_resultado!.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _navegarParaTemperatura,
              child: Text('Ir para Conversor de Temperatura'),
            ),
          ],
        ),
      ),
    );
  }
}
