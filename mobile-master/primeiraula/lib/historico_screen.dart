// historico_screen.dart
import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'conversion.dart'; // Importa o model Conversion

class HistoricoScreen extends StatelessWidget {
  const HistoricoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Conversões'),
        backgroundColor: const Color(0xFF64B5F6),
      ),
      body: FutureBuilder<List<Conversion>>(
        future: DatabaseHelper.instance.getLastConversions(), // Agora retorna List<Conversion>
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar histórico.'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma conversão realizada ainda.'));
          }

          final List<Conversion> dados = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: dados.length,
            itemBuilder: (context, index) {
              final item = dados[index];

              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.indigoAccent,
                    child: Icon(Icons.currency_exchange, color: Colors.white, size: 20),
                  ),
                  title: Text(
                    'R\$ ${item.real.toStringAsFixed(2)} → \$${item.dolar.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Data: ${item.timestamp}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          final controllers = {
                            'real': TextEditingController(text: item.real.toStringAsFixed(2)),
                            'dolar': TextEditingController(text: item.dolar.toStringAsFixed(2)),
                          };

                          final updated = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Editar conversão'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: controllers['real'],
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                    decoration: const InputDecoration(labelText: 'Valor em Reais (R\$)'),
                                  ),
                                  TextField(
                                    controller: controllers['dolar'],
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                    decoration: const InputDecoration(labelText: 'Valor em Dólar (\$)'),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Cancelar'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    final newReal = double.tryParse(controllers['real']!.text.replaceAll(',', '.'));
                                    final newDolar = double.tryParse(controllers['dolar']!.text.replaceAll(',', '.'));
                                    if (newReal == null || newDolar == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Valores inválidos')),
                                      );
                                      return;
                                    }

                                    final updatedConversion = Conversion(
                                      id: item.id,
                                      real: newReal,
                                      dolar: newDolar,
                                      timestamp: DateTime.now().toString().substring(0, 16),
                                    );

                                    await DatabaseHelper.instance.updateConversion(updatedConversion);
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('Salvar'),
                                ),
                              ],
                            ),
                          );

                          if (updated == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Conversão atualizada')),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HistoricoScreen()),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Excluir conversão?'),
                              content: const Text('Deseja realmente excluir esta conversão?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Não')),
                                ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Sim')),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            await DatabaseHelper.instance.deleteConversion(item.id!);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Conversão excluída')));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HistoricoScreen()),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Limpar histórico?'),
              content: const Text('Deseja remover todas as conversões do histórico?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Não')),
                ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Sim')),
              ],
            ),
          );

          if (confirm == true) {
            await DatabaseHelper.instance.deleteAllConversions();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Histórico limpo com sucesso!')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HistoricoScreen()),
            );
          }
        },
        icon: const Icon(Icons.delete_outline),
        label: const Text('Limpar'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
