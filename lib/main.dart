import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=abec0467";

void main() => runApp(MyApp());

Future<Map> apiGet() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          hintColor: Colors.amber,
          primaryColor: Colors.grey,
          primarySwatch: Colors.deepOrange,
        ),
        home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dolar, euro;
  final realcontroler = TextEditingController();
  final dolarcontroler = TextEditingController();
  final eurocontroler = TextEditingController();

  void _realChanged(String text)
  {
      double real = double.parse(text);
      dolarcontroler.text = (real/dolar).toStringAsFixed(2);
      eurocontroler.text = (real/euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text)
  {
      double dolar = double.parse(text);
      realcontroler.text = (dolar*this.dolar).toStringAsFixed(2);
      eurocontroler.text = ((dolar*this.dolar)/euro).toStringAsFixed(2);
  }

  void _euroChanged(String text)
  {
      double euro = double.parse(text);
      realcontroler.text = (euro*this.euro).toStringAsFixed(2);
      dolarcontroler.text = ((euro*this.euro)/dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Conversor de moedas",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.amber[200],
        ),
        body: FutureBuilder<Map>(
          future: apiGet(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando dados",
                    style: TextStyle(color: Colors.black12, fontSize: 25),
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Algo deu errado!",
                      style: TextStyle(color: Colors.red, fontSize: 25),
                    ),
                  );
                } else {
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(children: <Widget>[
                      Icon(Icons.monetization_on,
                          size: 150, color: Colors.amber[200]),
                      buildTextField("Real", "R\$", realcontroler, _realChanged),
                      Divider(),
                      buildTextField("Dólar", "\$", dolarcontroler, _dolarChanged),
                      Divider(),
                      buildTextField("Euro", "€" , eurocontroler, _euroChanged),
                    ], crossAxisAlignment: CrossAxisAlignment.stretch),
                  );
                }
            }
          },
        ));
  }
}

Widget buildTextField(String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    onChanged: f,
    decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.amber),
        labelText: label,
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amber, fontSize: 25),
    keyboardType: TextInputType.numberWithOptions(),
  );
}
