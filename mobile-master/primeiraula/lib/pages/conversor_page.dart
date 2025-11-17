// TODO Implement this library.
import 'package:bd2/historico_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controller/conversor_controller.dart';
import '../TemperaturaScreen.dart';

class ConversorPage extends StatefulWidget {
  const ConversorPage({super.key});

  @override
  State<ConversorPage> createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage>
    with SingleTickerProviderStateMixin {

  final controller = ConversorController();

  final TextEditingController dolarController = TextEditingController();

  double? taxaAtual;     // taxa da API (R$ por 1 USD)
  double? resultado;     // valor convertido para reais

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

    carregarTaxa();
  }

  Future<void> carregarTaxa() async {
    double? taxa = await controller.obterTaxaAtual();
    if (taxa != null) {
      setState(() => taxaAtual = taxa);
    } else {
      setState(() => taxaAtual = 5.63);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha ao carregar taxa. Usando valor padrão.')),
      );
    }
  }

  // 🔵 Converter DÓLAR → REAL
  void converter() {
    if (dolarController.text.isEmpty || taxaAtual == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o valor em dólar.')),
      );
      return;
    }

    double? valorDolar = double.tryParse(dolarController.text.replaceAll(',', '.'));

    if (valorDolar == null || valorDolar <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insira um valor válido.')),
      );
      return;
    }

    setState(() {
      resultado = valorDolar * taxaAtual!;
    });

    _resultAnimationController.forward(from: 0.0);
  }

  void _navegarParaTemperatura() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TemperaturaScreen()),
    );
  }

  void _navegarParaHistorico() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoricoScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversor API"),
        backgroundColor: const Color(0xFF64B5F6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // Exibe taxa da API
            if (taxaAtual == null)
              const Center(child: CircularProgressIndicator())
            else
              Text(
                "Cotação do dólar (API): R\$${taxaAtual!.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

            const SizedBox(height: 20),

            // Campo para digitar valor em dólar
            TextField(
              controller: dolarController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+[\.,]?\d*')),
              ],
              decoration: const InputDecoration(
                labelText: "Valor em Dólar (\$)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: converter,
              icon: const Icon(Icons.currency_exchange),
              label: const Text("Converter para Reais"),
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
                  child: resultado != null
                      ? Text(
                          "Resultado: R\$${resultado!.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(221, 57, 59, 52),
                          ),
                        )
                      : const SizedBox(),
                );
              },
            ),

            const SizedBox(height: 15),

            ElevatedButton.icon(
              onPressed: _navegarParaTemperatura,
              icon: const Icon(Icons.thermostat),
              label: const Text("Converter Temperatura"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                foregroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton.icon(
              onPressed: _navegarParaHistorico,
              icon: const Icon(Icons.history),
              label: const Text("Ver Histórico"),
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
    dolarController.dispose();
    _resultAnimationController.dispose();
    super.dispose();
  }
}
