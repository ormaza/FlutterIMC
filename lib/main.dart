import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculadora IMC",
    home: Home(),
  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _textInfo = "";
  String _path = "";
  void _resetCampos() {
    _formKey.currentState.reset();
    pesoController.clear();
    alturaController.clear();
    setState(() {
      _textInfo = "";
      _path = "";
    });
  }
  void _calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text);
      altura/=100;
      double imc = peso / (altura * altura);

      if(imc < 18.6){
        _textInfo = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
        _path = "Imagens/faixa1.jpg";
      }
      else if(imc >= 18.6 && imc < 24.9) {
        _textInfo = "Peso ideal (${imc.toStringAsPrecision(4)})";
        _path = "Imagens/faixa2.jpg";
      }
      else if(imc >= 24.9 && imc < 29.9){
        _textInfo = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
        _path = "Imagens/faixa3.jpg";
      }
      else if(imc >= 29.9 && imc < 34.9){
        _textInfo = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
        _path = "Imagens/faixa4.jpg";
      }
      else if(imc >= 40){
        _textInfo = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
        _path = "Imagens/faixa5.jpg";
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetCampos,
          )
        ], //<Widget>[]
      ), // app bar
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.red)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 25.0),
                controller: pesoController,
                validator: (value) {
                  if (value.isEmpty) return "Insira seu peso!";
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.red)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 25.0),
                controller: alturaController,
                validator: (value) {
                  if (value.isEmpty) return "Insira sua altura!";
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: ButtonTheme(
                    height: 50.0,
                    highlightColor: Colors.amber,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) _calcular();
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.red,
                    )),
              ),
              Text(
                _textInfo,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 25.0),
              ),
              Image.asset(
                _path,
                fit: BoxFit.contain,
                height: 400.0,
              )
            ], //<widget>[]
          ),
        ),
      ),
    );
  }
}