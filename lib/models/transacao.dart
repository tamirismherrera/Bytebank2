import 'contato.dart';

class Transacao {
  final double valor;
  final Contato contato;

  Transacao(
      this.valor,
      this.contato,
      );

  @override
  String toString() {
    return 'Transacao{value: $valor, contact: $contato}';
  }

}