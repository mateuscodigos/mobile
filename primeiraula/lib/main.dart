import 'package:flutter/material.dart';
import 'temperaturaScreen.dart';

void main() {
  runApp(ConversorApp());
}

class ConversorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor Real → Dólar',
      theme: ThemeData(
        primarySwatch: Colors.indigo, 
        scaffoldBackgroundColor: Color(0xFFE3F2FD), 
        elevatedButtonTheme: ElevatedButtonThemeData( 
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4FC3F7), 
            foregroundColor: Colors.white, 
          ),
        ),
        inputDecorationTheme: InputDecorationTheme( 
          filled: true,
          fillColor: Color(0xFFFFFFFF), 
          border: OutlineInputBorder(),
          labelStyle: TextStyle(color: const Color.fromARGB(255, 165, 56, 56)),
        ),
        textTheme: TextTheme( //
          bodyLarge: TextStyle(color: const Color.fromARGB(255, 165, 56, 56)),
          bodyMedium: TextStyle(color: const Color.fromARGB(255, 165, 56, 56)),
        ),
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
  double _taxaDolar = 5.63;

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
        backgroundColor: Color(0xFF64B5F6), 
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
                // o fundo agora é controlado globalmente no Theme
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _converter,
              child: Text('Converter para Dólar'),
              // estilo também vem do tema global
            ),
            SizedBox(height: 30),
            if (_resultado != null)
              Text(
                'Resultado: \$${_resultado!.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(221, 186, 255, 95),
                ),
              ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _navegarParaTemperatura,
              child: Text('Ir para Conversor de Temperatura'),
              // segue o tema global
            ),
          ],
        ),
      ),
    );
  }
}
