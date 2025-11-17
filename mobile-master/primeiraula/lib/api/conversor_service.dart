// TODO Implement this library.import 'dart:convert';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/TaxaModel.dart';
import 'endpoint.dart';


class ConversorService {
  // Endpoint público sem token
  static const String url =
      "https://api.exchangerate.host/latest?base=USD&symbols=BRL";

  Future<double?> buscarTaxa() async {
    try {
      final resposta = await http.get(Uri.parse(url));

      if (resposta.statusCode == 200) {
        final json = jsonDecode(resposta.body);
        double taxa = json["rates"]["BRL"];
        return taxa;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
