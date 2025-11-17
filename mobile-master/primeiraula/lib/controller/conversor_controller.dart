import 'dart:convert';
import 'package:http/http.dart' as http;

class ConversorController {
  Future<double?> obterTaxaAtual() async {
    try {
      final url = Uri.parse(
        "https://api.exchangerate.host/latest?base=USD&symbols=BRL"
      );

      final resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        final json = jsonDecode(resposta.body);

        double taxa = json["rates"]["BRL"] * 1.0;
        return taxa;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
