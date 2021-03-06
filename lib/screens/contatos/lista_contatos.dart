import 'package:bytebank2/components/progress.dart';
import 'package:bytebank2/database/dao/contact_dao.dart';
import 'package:bytebank2/models/contato.dart';
import 'package:bytebank2/screens/contatos/formulario.dart';
import 'package:bytebank2/screens/transacoes/formulario.dart';
import 'package:flutter/material.dart';

const _tittuloAppBar = 'Transferir';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tittuloAppBar),
      ),
      body: FutureBuilder<List<Contato>>(
        initialData: [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress(
                message: 'Carregando',
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contato> contatos = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contato contato = contatos[index];
                  return _ContactItem(
                    contato,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransactionForm(contato),
                        ),
                      );
                    },
                  );
                },
                itemCount: contatos.length,
              );
              break;
          }
          return Text('Erro ao carregar lista');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ContactForm(),
                ),
              )
              .then(
                (value) => setState(() {}),
              );
        },
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contato contato;
  final Function onClick;

  _ContactItem(this.contato, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contato.nomeContato,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          contato.numeroContaContato.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
