import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class TemperaturaScreen extends StatefulWidget {
  const TemperaturaScreen({super.key});

  @override
  _TemperaturaScreenState createState() => _TemperaturaScreenState();
}

class _TemperaturaScreenState extends State<TemperaturaScreen>
    with SingleTickerProviderStateMixin {
  final _controllerFahrenheit = TextEditingController();

  double? temperaturaAPI; // Temperatura real em Fahrenheit vinda da API
  String _resultado = '';

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 🔥 Configuração da animação
    _animController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );

    buscarTemperaturaAPI();
  }

  // 🔥 BUSCAR TEMPERATURA DA API
  Future<void> buscarTemperaturaAPI() async {
    const url =
        "https://api.open-meteo.com/v1/forecast?latitude=-27.2142&longitude=-49.6431&hourly=temperature_2m&models=metno_seamless&current=temperature_2m&temperature_unit=fahrenheit";

    try {
      final resposta = await http.get(Uri.parse(url));

      if (resposta.statusCode == 200) {
        final json = jsonDecode(resposta.body);

        final temp = json["current"]["temperature_2m"].toDouble();

        setState(() {
          temperaturaAPI = temp;
        });
      } else {
        setState(() => temperaturaAPI = null);
      }
    } catch (e) {
      setState(() => temperaturaAPI = null);
    }
  }

  // 🔥 CONVERTER Fahrenheit → Celsius
  void _converter() {
    final text = _controllerFahrenheit.text;

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe uma temperatura válida.')),
      );
      return;
    }

    final fahrenheit = double.tryParse(text.replaceAll(',', '.'));

    if (fahrenheit == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Número inválido.')),
      );
      return;
    }

    final celsius = (fahrenheit - 32) * 5 / 9;

    setState(() {
      _resultado =
          '${fahrenheit.toStringAsFixed(1)}°F = ${celsius.toStringAsFixed(1)}°C';
    });

    _animController.forward(from: 0.0); // animação
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor Fahrenheit → Celsius (API)'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 Temperatura atual da API
            temperaturaAPI == null
                ? const Center(child: CircularProgressIndicator())
                : Text(
                    "Temperatura atual (API): ${temperaturaAPI!.toStringAsFixed(1)}°F",
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),

            const SizedBox(height: 25),

            // 🔵 Campo de entrada Fahrenheit
            TextField(
              controller: _controllerFahrenheit,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+[\.,]?\d*')),
              ],
              decoration: const InputDecoration(
                labelText: 'Temperatura em Fahrenheit (°F)',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // 🔘 Botão Converter
            ElevatedButton(
              onPressed: _converter,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Converter para Celsius'),
            ),

            const SizedBox(height: 30),

            // ✨ Resultado com animação
            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: _resultado.isNotEmpty
                      ? Text(
                          _resultado,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        )
                      : const SizedBox(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerFahrenheit.dispose();
    _animController.dispose();
    super.dispose();
  }
}
