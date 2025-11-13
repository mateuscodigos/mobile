// historico_screen.dart
import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'conversion.dart'; // Importa o model Conversion

class HistoricoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Conversões'),
        backgroundColor: Color(0xFF64B5F6),
      ),
      body: FutureBuilder<List<Conversion>>(
        future: DatabaseHelper.instance.getLastConversions(), // Agora retorna List<Conversion>
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar histórico.'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma conversão realizada ainda.'));
          }

          final List<Conversion> dados = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: dados.length,
            itemBuilder: (context, index) {
              final item = dados[index];

              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigoAccent,
                    child: Icon(Icons.currency_exchange, color: Colors.white, size: 20),
                  ),
                  title: Text(
                    'R\$ ${item.real.toStringAsFixed(2)} → \$${item.dolar.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Data: ${item.timestamp}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          final controllers = {
                            'real': TextEditingController(text: item.real.toStringAsFixed(2)),
                            'dolar': TextEditingController(text: item.dolar.toStringAsFixed(2)),
                          };

                          final updated = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Editar conversão'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: controllers['real'],
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    decoration: InputDecoration(labelText: 'Valor em Reais (R\$)'),
                                  ),
                                  TextField(
                                    controller: controllers['dolar'],
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    decoration: InputDecoration(labelText: 'Valor em Dólar (\$)'),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: Text('Cancelar'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    final newReal = double.tryParse(controllers['real']!.text.replaceAll(',', '.'));
                                    final newDolar = double.tryParse(controllers['dolar']!.text.replaceAll(',', '.'));
                                    if (newReal == null || newDolar == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Valores inválidos')),
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
                                  child: Text('Salvar'),
                                ),
                              ],
                            ),
                          );

                          if (updated == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Conversão atualizada')),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HistoricoScreen()),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Excluir conversão?'),
                              content: Text('Deseja realmente excluir esta conversão?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Não')),
                                ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text('Sim')),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            await DatabaseHelper.instance.deleteConversion(item.id!);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Conversão excluída')));
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
              title: Text('Limpar histórico?'),
              content: Text('Deseja remover todas as conversões do histórico?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Não')),
                ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text('Sim')),
              ],
            ),
          );

          if (confirm == true) {
            await DatabaseHelper.instance.deleteAllConversions();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Histórico limpo com sucesso!')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HistoricoScreen()),
            );
          }
        },
        icon: Icon(Icons.delete_outline),
        label: Text('Limpar'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
