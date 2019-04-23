import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: Home()
        );
  }
}

class Home extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  int _people = 0;
  String _info = "Pode entrar!!";
  void _changePeople(int delta)
  {
    setState(() {
      _people+=delta;
      if(_people < 0){
        _info="Não há pessoas!!";
        _people = 0;
      }else if(_people >=11)
      {
        _info="Esta Lotado";
      }else{
         _info="Pode entrar!!";
      }

      
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
            Container(color: Colors.deepOrange[200]),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Pessoas: $_people",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                        child: Text("+1",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25)),
                        onPressed: () {_changePeople(1);},
                      ),
                    ),
                    FlatButton(
                      child: Text("-1",
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                      onPressed: () {_changePeople(-1);},
                    ),
                  ],
                ),
                Text(
                  _info,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            )
          ],
        );
  }
}
