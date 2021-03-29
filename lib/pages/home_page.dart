import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/app_drawer.dart';
import 'package:flutter_app/pages/pagina_dois.dart';
import 'package:flutter_app/pages/pagina_tres.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        color: Colors.yellow[200],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _abrirPagina(context, new PaginaDois()),
                    child: Text("Botão 1"),
                  ),
                  ElevatedButton(
                    onPressed: () => _abrirPagina(context, new PaginaTres()),
                    child: Text("Botão 2"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Um"),
                    Text("Dois"),
                    Text("Três"),
                    Text("Quatro"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Future _abrirPagina(BuildContext context, Widget pagina) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext cx) => pagina));
  }
}
