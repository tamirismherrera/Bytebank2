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
    final List<dynamic> decodedJson =
    jsonDecode(response.body); //decodificando o json
    final List<Transacao> transacoes = []; //criando uma lista de transações vazia
    for (Map<String, dynamic> transactionJson in decodedJson) {
      //varrendo o json decodificado e extraindo um elemento
      final Map<String, dynamic> contactJson = transactionJson['contact'];
      final Transacao transacao = Transacao(
        //para cada elemento, cria uma transação
        transactionJson['value'],
        Contato(
          0,
          contactJson['name'],
          contactJson['accountNumber'],
        ),
      );
      transacoes.add(transacao);
    }
    return transacoes;
  }

  Future<Transacao> save(Transacao transacao) async{
    final Map<String, dynamic> transactionMap = {
      'value' : transacao.valor,
      'contact' : {
        'name' : transacao.contato.nomeContato,
        'accountNumber' : transacao.contato.numeroContaContato,
      }
    };

    final String transactionJson = jsonEncode(transactionMap);

    final Response response = await client.post(
        baseUrl,
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: transactionJson
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    final Map<String, dynamic> contactJson = json['contact'];
    return Transacao(
      json['value'],
      Contato(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );

  }
}