import 'package:flutter/material.dart';
import 'TemperaturaScreen.dart';
import 'historico_screen.dart';
import 'database_helper.dart';
import 'preferencias_helper.dart';
import 'conversion.dart';

class ConversorPage extends StatefulWidget {
  const ConversorPage({super.key});

  @override
  _ConversorPageState createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage> with SingleTickerProviderStateMixin {
  final TextEditingController _realController = TextEditingController();
  double? _resultado;
  double _taxaDolar = 5.63;

  late AnimationController _resultAnimationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _resultAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _resultAnimationController, curve: Curves.easeOut),
    );

    // Carregar taxa salva do SharedPreferences
    PreferenciasHelper.carregarTaxa().then((valor) {
      setState(() {
        _taxaDolar = valor; // valor nunca é null
      });
    });
  }

  void _converter() {
    final texto = _realController.text;
    if (texto.isEmpty) return;

    final real = double.tryParse(texto.replaceAll(',', '.'));
    if (real == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um número válido.')),
      );
      return;
    }

    setState(() {
      _resultado = real / _taxaDolar;
    });

    if (_resultado != null) {
      final conv = Conversion(
        real: real,
        dolar: _resultado!,
        timestamp: DateTime.now().toString().substring(0, 16),
      );
      DatabaseHelper.instance.insertConversion(conv);
    }

    _resultAnimationController.forward(from: 0.0);
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
        title: const Text('Conversor Real para Dólar'),
        backgroundColor: const Color(0xFF64B5F6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _realController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Valor em Reais (R\$)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _converter,
              icon: const Icon(Icons.currency_exchange),
              label: const Text('Converter para Dólar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 30),
            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: _resultado != null
                      ? Text(
                          'Resultado: \$${_resultado!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(221, 57, 59, 52),
                          ),
                        )
                      : Container(),
                );
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: _navegarParaTemperatura,
              icon: const Icon(Icons.thermostat),
              label: const Text('Converter Temperatura'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoricoScreen()),
                );
              },
              icon: const Icon(Icons.history),
              label: const Text('Ver Histórico'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _realController.dispose();
    _resultAnimationController.dispose();
    super.dispose();
  }
}
