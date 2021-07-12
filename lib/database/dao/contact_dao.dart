import 'package:bytebank2/database/app_database.dart';
import 'package:bytebank2/models/contato.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao{

  static final String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<int> save(Contato contato) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contato);
    return db.insert(_tableName, contactMap);
    // return getDatabase().then((db) {
    //   final Map<String, dynamic> contactMap = Map();
    //   contactMap['name'] = contato.nomeContato;
    //   contactMap['account_number'] = contato.numeroContaContato;
    //   return db.insert('contacts', contactMap);
    // });
  }

  Map<String, dynamic> _toMap(Contato contato) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contato.nomeContato;
    contactMap[_accountNumber] = contato.numeroContaContato;
    return contactMap;
  }

  Future<List<Contato>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contato> contatos = _toList(result);
    return contatos;
    // return getDatabase().then((db) {
    //   return db.query('contacts').then((maps) {
    //     final List<Contato> contatos = [];
    //     for (Map<String, dynamic> map in maps) {
    //       final Contato contato =
    //           Contato(map['id'], map['name'], map['account_number']);
    //       contatos.add(contato);
    //     }
    //     return contatos;
    //   });
    // });
  }

  List<Contato> _toList(List<Map<String, dynamic>> result) {
    final List<Contato> contatos = [];
    for (Map<String, dynamic> row in result) {
      final Contato contato = Contato(
        row[_id],
        row[_name],
        row[_accountNumber],
      );
      contatos.add(contato);
    }
    return contatos;
  }
}