import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/dashboard_bt.dart';

void main() {
  runApp(BytebankApp());

  //findAll().then((transacoes) => print('nova transação $transacoes'));
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyan[900],
        accentColor: Colors.blueGrey[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueGrey[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Dashboard(),
    );
  }
}


