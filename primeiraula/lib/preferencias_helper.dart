import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasHelper {
  static const String _chaveTaxa = 'taxa_dolar';

  /// Salva a taxa no SharedPreferences (trata exceções)
  static Future<void> salvarTaxa(double valor) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_chaveTaxa, valor);
    } catch (e) {
      // opcional: log de erro para depuração
      // print('Erro ao salvar taxa: $e');
      rethrow;
    }
  }

  /// Carrega a taxa salva. Retorna um double (valor padrão caso não exista ou ocorra erro)
  static Future<double> carregarTaxa() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getDouble(_chaveTaxa) ?? 5.63; // valor padrão
    } catch (e) {
      // print('Erro ao carregar taxa: $e');
      return 5.63;
    }
  }

  /// Remove a taxa salva (opcional)
  static Future<void> limparTaxa() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_chaveTaxa);
    } catch (e) {
      // print('Erro ao limpar taxa: $e');
      rethrow;
    }
  }
}
