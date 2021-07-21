import 'dart:convert';

import 'package:bytebank2/http/webcliente.dart';
import 'package:bytebank2/models/contato.dart';
import 'package:bytebank2/models/transacao.dart';
import 'package:http/http.dart';

class TransactionWebClient{

  Future<List<Transacao>> findAll() async {
    final Response response =
    //await client.get(Uri.http('192.168.0.9:8081', 'transactions'));
    await client.get(baseUrl);
    // ip errado await client.get(Uri.http('192.168.0.95:8081', 'transactions')).timeout(Duration(seconds: 5));
    List<Transacao> transacoes = _toTransactions(response);
    return transacoes;
  }

  List<Transacao> _toTransactions(Response response) { // conversao que gera uma lista de transferencias
    final List<dynamic> decodedJson =
    jsonDecode(response.body); //decodificando o json
    final List<Transacao> transacoes = []; //criando uma lista de transações vazia
    for (Map<String, dynamic> transactionJson in decodedJson) {

      transacoes.add(Transacao.fromJson(transactionJson));
    }
    return transacoes;
  }

  Future<Transacao> save(Transacao transacao) async{
    final String transactionJson = jsonEncode(transacao.toJson());
    final Response response = await client.post(
        baseUrl,
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: transactionJson
    );
    return _toTransaction(response);

  }

  Transacao _toTransaction(Response response) { //convertendo um Json para a uma transacao
    Map<String, dynamic> json = jsonDecode(response.body);
    return Transacao.fromJson(json);
  }


}