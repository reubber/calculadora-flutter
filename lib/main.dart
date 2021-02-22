import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Build metodo principal do flutter que vai montar a tela
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(), // o componente definido como primeiro pra renderizar
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isDouble = false;
  String operador = '';
  double num1 = 0.0;
  double num2 = 0.0;

  TextEditingController displayController = new TextEditingController();
  // componetizando o botao para evitar repeticao - Estilo React
  Widget componentButton(String text, Function handlePress) {
    return Expanded(
      child: RaisedButton(
        color: Colors.green[50],
        child: Text(text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        onPressed: handlePress,
      ),
    );
  }

  //-------logica das operacoes---------//
  void NumberHandle(String value) {
    displayController.text = displayController.text + value;
  }

  void dotHandle() {
    if (isDouble == false) {
      displayController.text = displayController.text + '.';
      isDouble = true;
    }
  }

  void delHandler() {
    String result = displayController.text;
    result.length > 0
        ? displayController.text = result.substring(0, result.length - 1)
        : displayController.clear();
  }

  void operandHandler(String value) {
    num1 = double.parse(displayController.text);
    switch (value) {
      case '%':
        operador = '%';
        break;

      case '-':
        operador = '-';
        break;

      case '/':
        operador = '/';
        break;

      case '*':
        operador = '*';
        break;

      case '+':
        operador = '+';
        break;
    }
    displayController.clear();
    print(num1);
    print(operador);
  }

  void resultHandler() {
    num2 = double.parse(displayController.text);
    displayController.clear();
    double result;

    switch (operador) {
      case '%':
        result = num1 % num2;
        break;

      case '-':
        result = num1 - num2;
        break;

      case '/':
        result = num1 / num2;
        break;

      case '*':
        result = num1 * num2;
        break;

      case '+':
        result = num1 + num2;
        break;
    }
    if (result == null) {
      return;
    }
    displayController.text = result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora Flutter'),
        ),
        body: Container(
          margin: EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: TextField(
                  textAlign: TextAlign.right,
                  readOnly: true,
                  controller: displayController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      componentButton('C', () => {displayController.clear()}),
                      SizedBox(width: 10),
                      componentButton('/', () => {operandHandler('/')}),
                      SizedBox(width: 10),
                      componentButton('DEL', () => {delHandler()}),
                      SizedBox(width: 10),
                      componentButton('-', () => {operandHandler('-')}),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      componentButton('7', () => {NumberHandle('7')}),
                      SizedBox(width: 10),
                      componentButton('8', () => {NumberHandle('8')}),
                      SizedBox(width: 10),
                      componentButton('9', () => {NumberHandle('9')}),
                      SizedBox(width: 10),
                      componentButton('+', () => {operandHandler('+')}),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      componentButton('4', () => {NumberHandle('4')}),
                      SizedBox(width: 10),
                      componentButton('5', () => {NumberHandle('5')}),
                      SizedBox(width: 10),
                      componentButton('6', () => {NumberHandle('6')}),
                      SizedBox(width: 10),
                      componentButton('*', () => {operandHandler('*')}),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      componentButton('1', () => {NumberHandle('1')}),
                      SizedBox(width: 10),
                      componentButton('2', () => {NumberHandle('2')}),
                      SizedBox(width: 10),
                      componentButton('3', () => {NumberHandle('3')}),
                      SizedBox(width: 10),
                      componentButton('%', () => {operandHandler('%')}),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      componentButton('0', () => {NumberHandle('0')}),
                      SizedBox(width: 10),
                      componentButton('=', () => {resultHandler()}),
                      SizedBox(width: 10),
                      componentButton('.', () => {dotHandle()}),
                    ],
                  )),
            ],
          ),
        ));
  }
}
