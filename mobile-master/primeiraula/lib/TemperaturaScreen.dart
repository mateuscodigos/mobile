import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';


Widget botaoAnimado({
  required IconData icone,
  required String texto,
  required Color cor1,
  required Color cor2,
  required VoidCallback onPressed,
  required AnimationController controller,
}) {
  return GestureDetector(
    onTapDown: (_) => controller.reverse(),
    onTapUp: (_) => controller.forward(),
    onTapCancel: () => controller.forward(),
    child: AnimatedScale(
      scale: 0.97,
      duration: const Duration(milliseconds: 150),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [cor1, cor2]),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: cor2.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icone, color: Colors.white, size: 26),
                const SizedBox(width: 10),
                Text(
                  texto,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class TemperaturaScreen extends StatefulWidget {
  const TemperaturaScreen({super.key});

  @override
  _TemperaturaScreenState createState() => _TemperaturaScreenState();
}

class _TemperaturaScreenState extends State<TemperaturaScreen>
    with SingleTickerProviderStateMixin {
  
  final _controllerFahrenheit = TextEditingController();

  double? temperaturaAPI; 
  String _resultado = '';

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );

    buscarTemperaturaAPI();
  }

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

    _animController.forward(from: 0.0); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor Fahrenheit → Celsius (API)'),
        backgroundColor: Colors.deepOrange,
      ),
      body: 
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: temperaturaAPI == null
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      "Temperatura atual (API): ${temperaturaAPI!.toStringAsFixed(1)}°F",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: _controllerFahrenheit,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+[\.,]?\d*')),
              ],
              decoration: InputDecoration(
                labelText: 'Temperatura em Fahrenheit (°F)',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      const BorderSide(color: Colors.deepOrange, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 20),

            botaoAnimado(
              icone: Icons.swap_vert,
              texto: "Converter para Celsius",
              cor1: Colors.deepOrange,
              cor2: Colors.orangeAccent,
              onPressed: _converter,
              controller: _animController,
            ),

            const SizedBox(height: 30),

            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: _resultado.isNotEmpty
                      ? Text(
                          _resultado,
                          style: const TextStyle(
                            fontSize: 24,
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
