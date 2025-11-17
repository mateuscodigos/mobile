import 'package:bd2/historico_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controller/conversor_controller.dart';
import '../TemperaturaScreen.dart';

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

class ConversorPage extends StatefulWidget {
  const ConversorPage({super.key});

  @override
  State<ConversorPage> createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage>
    with SingleTickerProviderStateMixin {
  final controller = ConversorController();
  final TextEditingController realController = TextEditingController();

  double? taxaAtual;
  double? resultado;

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_animController);
    carregarTaxa();
  }

  Future<void> carregarTaxa() async {
    final taxa = await controller.obterTaxaAtual();
    setState(() => taxaAtual = taxa);
  }

  void converter() async {
    if (realController.text.isEmpty || taxaAtual == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite um valor válido.')),
      );
      return;
    }

    final real = double.tryParse(realController.text.replaceAll(",", "."));
    if (real == null || real <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Valor inválido.')),
      );
      return;
    }

    final dolar = real / taxaAtual!;
    setState(() => resultado = dolar);

    _animController.forward(from: 0);

    await controller.salvarConversao(real: real, dolar: dolar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7FF),
      appBar: AppBar(
        title: const Text("Conversor API"),
        backgroundColor: Colors.indigo,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (taxaAtual == null)
              const Center(child: CircularProgressIndicator())
            else
              AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 600),
                child: Text(
                  "Cotação atual do dolar em reais: R\$ ${taxaAtual!.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
            const SizedBox(height: 25),
            TextField(
              controller: realController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9\.,]"))
              ],
              decoration: InputDecoration(
                labelText: "Valor em Reais (R\$)",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            botaoAnimado(
              icone: Icons.currency_exchange,
              texto: "Converter",
              cor1: Colors.indigo,
              cor2: Colors.indigoAccent,
              onPressed: converter,
              controller: _animController,
            ),
            const SizedBox(height: 35),
            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (_, __) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: resultado != null
                      ? Text(
                          "Resultado: \$${resultado!.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        )
                      : const SizedBox(),
                );
              },
            ),
            const SizedBox(height: 30),
            botaoAnimado(
              icone: Icons.thermostat,
              texto: "Converter Temperatura",
              cor1: Colors.deepOrange,
              cor2: Colors.orangeAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const TemperaturaScreen()),
                );
              },
              controller: _animController,
            ),
            const SizedBox(height: 15),
            botaoAnimado(
              icone: Icons.history,
              texto: "Ver Histórico",
              cor1: Colors.green,
              cor2: Colors.lightGreen,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoricoScreen()),
                );
              },
              controller: _animController,
            ),
          ],
        ),
      ),
    );
  }
}
