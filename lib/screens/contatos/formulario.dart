import 'package:bytebank2/components/editor.dart';
import 'package:bytebank2/database/dao/contact_dao.dart';
import 'package:bytebank2/models/contato.dart';
import 'package:flutter/material.dart';

const _tittuloAppBar = 'Novo Contato';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _controladorCampoNomeContato = TextEditingController();

  final TextEditingController _controladorCampoNumeroContaContato =
  TextEditingController();
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tittuloAppBar),
      ),
      body: Column(
        children: [
          Editor(
            rotulo: 'Nome Completo',
            icone: Icons.person,
            controlador: _controladorCampoNomeContato,
          ),
          Editor(
            rotulo: 'Número da Conta',
            icone: Icons.wysiwyg,
            keyboardType: TextInputType.number,
            controlador: _controladorCampoNumeroContaContato,
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            child: Text('Adicionar'),
            onPressed: () {
              final String nomeContato = _controladorCampoNomeContato.text;
              final int numeroContaContato = int.tryParse(_controladorCampoNumeroContaContato.text);
              final Contato novoContato = Contato(0,nomeContato,numeroContaContato);
              _dao.save(novoContato).then((id)=>Navigator.pop(context));
            },
          ),
        ],
      ),
    );
  }
}
