import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Alcool ou Gasolina?'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _gasCtrl = new MoneyMaskedTextController();
  var _alcCtrl = new MoneyMaskedTextController();
  var _result = "";

  void _calculate() {
    //Converter valores string para numeros
    double alc =
        double.parse(_alcCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;
    double gas =
        double.parse(_gasCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;
    double res = alc / gas;

    print(alc);
    print(gas);
    print(res);

    setState(() {
      if (res >= 0.7) {
        _result = "Melhor utilizar Gasolina!";
      } else {
        _result = "Melhor utilizar Álcool!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.number,
                controller: _gasCtrl,
                decoration: InputDecoration(
                    labelText: "Valor da Gasolina (Litro)",
                    labelStyle: TextStyle(color: Colors.deepPurple)),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Valor inválido";
                  }
                },
              ),
              Divider(),
              TextField(
                autofocus: true,
                keyboardType: TextInputType.number,
                controller: _alcCtrl,
                decoration: InputDecoration(
                    labelText: "Valor do Álcool (Litro)",
                    labelStyle: TextStyle(color: Colors.deepPurple)),
              ),
              Divider(),
              Text(
                _result,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.deepPurple),
              ),
              Divider(),
              RaisedButton(
                onPressed: _calculate,
                child: Text(
                  "Calcular",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.deepPurple,
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
