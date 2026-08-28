import 'safra.dart';
import 'unidade.dart';
import 'tipoinformacao.dart';

class Medicao {
final int id;
final Safra safra;
final Unidade unidade;
final TipoInformacao tipoinformacao;
final int valor;

Medicao({
required this.id,
required this.safra,
required this.unidade,
required this.tipoinformacao,
required this.valor,
});
}