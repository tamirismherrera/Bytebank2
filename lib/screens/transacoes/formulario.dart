import 'package:bytebank2/http/webclients/transaction_webclient.dart';
import 'package:bytebank2/models/contato.dart';
import 'package:bytebank2/models/transacao.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Contato contato;

  TransactionForm(this.contato);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Transferência'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contato.nomeContato,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contato.numeroContaContato.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.cyan[900],),
                    child: Text('Transferir'), onPressed: () {
                    final double value = double.tryParse(_valueController.text);
                    final transactionCreated = Transacao(value, widget.contato);
                    _webClient.save(transactionCreated).then((transacao){
                      if(transacao !=null){
                        Navigator.pop(context);
                      }
                    });
                  },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
