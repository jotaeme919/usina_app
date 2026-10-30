
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/indicador.dart';

class IndicadorService {
  // Endereço da API Node-RED para Flutter Web (Chrome)
  static const String baseUrl =
    'http://10.0.2.2:1880/api/indicadores';

  // LISTAR INDICADORES
  Future<List<Indicador>> listar() async {
    final r = await http.get(Uri.parse(baseUrl));

    if (r.statusCode != 200) {
      throw Exception('GET: ${r.statusCode} - ${r.body}');
    }

    final dados = jsonDecode(utf8.decode(r.bodyBytes));

    if (dados is! List) {
      throw const FormatException('Esperada lista JSON');
    }

    return dados
        .map((e) => Indicador.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // CADASTRAR INDICADOR
  Future<void> criar(Indicador item) async {
    final r = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (r.statusCode != 200 &&
        r.statusCode != 201 &&
        r.statusCode != 204) {
      throw Exception('POST: ${r.statusCode} - ${r.body}');
    }
  }

  // ATUALIZAR INDICADOR
  Future<void> atualizar(Indicador item) async {
    final r = await http.put(
      Uri.parse('$baseUrl/${item.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (r.statusCode != 200 && r.statusCode != 204) {
      throw Exception('PUT: ${r.statusCode} - ${r.body}');
    }
  }

  // EXCLUIR INDICADOR
  Future<void> excluir(int id) async {
    final r = await http.delete(
      Uri.parse('$baseUrl/$id'),
    );

    if (r.statusCode != 200 &&
        r.statusCode != 202 &&
        r.statusCode != 204) {
      throw Exception('DELETE: ${r.statusCode} - ${r.body}');
    }
  }
}
