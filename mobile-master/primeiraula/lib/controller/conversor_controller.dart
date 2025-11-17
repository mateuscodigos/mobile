import 'dart:convert';
import 'package:http/http.dart' as http;
import '../database_helper.dart';
import '../conversion.dart';

class ConversorController {
  // API sem token
  final String apiUrl =
      "https://open.er-api.com/v6/latest/USD";

  Future<double?> obterTaxaAtual() async {
    try {
      final resposta = await http.get(Uri.parse(apiUrl));

      if (resposta.statusCode == 200) {
        final json = jsonDecode(resposta.body);
        return json["rates"]["BRL"]?.toDouble();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> salvarConversao({
    required double real,
    required double dolar,
  }) async {
    final conv = Conversion(
      real: real,
      dolar: dolar,
      timestamp: DateTime.now().toString().substring(0, 16),
    );

    await DatabaseHelper.instance.insertConversion(conv);
  }
}
