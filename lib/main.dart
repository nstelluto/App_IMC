import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cálculo IMC",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'Cálculo IMC'),
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
  var _ctrPeso = new TextEditingController();
  var _ctrAltura = new TextEditingController();
  String _retorno = '';
  Color _corTexto = Colors.purple;
  IconData _icon = Icons.person_pin;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: limparCampo),
        ],
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Center(
                  child: Icon(
                    _icon,
                    color: Theme.of(context).primaryColor,
                    size: 100,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 20),
                  child: TextFormField(
                    controller: _ctrPeso,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Peso (Kg)',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '*Informe seu Peso.';
                      }
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 20),
                  child: TextFormField(
                    controller: _ctrAltura,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '*Informe sua Altura.';
                      }
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 10,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          calculaIMC();
                        }
                      },
                      child: Text(
                        'CALCULAR',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Center(
                  child: Text(
                    _retorno,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: _corTexto),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  limparCampo() {
    setState(() {
      _formKey.currentState.reset();
      _ctrPeso = new TextEditingController();
      _ctrAltura = new TextEditingController();
      _retorno = '';
      _icon = Icons.person_pin;
    });
  }

  calculaIMC() {
    // IMC = peso/(Altura*Altura)
    var peso =
        double.parse(_ctrPeso.text.replaceAll('.', '').replaceAll(',', ''));
    var altura =
        double.parse(_ctrAltura.text.replaceAll('.', '').replaceAll(',', '')) /
            100;
    var resultado = peso / (altura * altura);

    setState(() {
      if (resultado < 18.5) {
        _retorno = 'Abaixo do Peso';
        _corTexto = Colors.pink;
        _icon = Icons.fastfood;
      }
      if (resultado >= 18.5 && resultado <= 24.9) {
        _retorno = 'Peso Normal';
        _corTexto = Colors.green;
        _icon = Icons.cake;
      }
      if (resultado >= 25 && resultado <= 29.9) {
        _retorno = 'Sobrepeso';
        _corTexto = Colors.teal;
        _icon = Icons.pan_tool;
      }
      if (resultado >= 30 && resultado <= 39.9) {
        _retorno = 'Obesidade';
        _corTexto = Colors.orange;
        _icon = Icons.mood_bad;
      }
      if (resultado >= 40) {
        _retorno = 'Obesidade Grave';
        _corTexto = Colors.red;
        _icon = Icons.airline_seat_individual_suite;
      }
    });
  }
}

// 18.5 Magro
// 18.5 <= 24.9 normal
// 25 <=29.9 sobrepeso
// <=30 <= 39.9 obesidade
//  >40 obesidade morbida
