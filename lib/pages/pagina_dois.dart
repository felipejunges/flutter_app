import 'package:flutter/material.dart';
import 'package:flutter_app/models/veiculo.dart';
import 'package:flutter_app/widgets/veiculo_card.dart';

class PaginaDois extends StatelessWidget {
  final List<Veiculo> veiculos = [
    Veiculo("Chevrolet", "Astra", "IQO 8939"),
    Veiculo("Honda", "Civic", "IRT 6F63"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página 2"),
        actions: [
          IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: () => _tapAppBar(context),
          ),
        ],
      ),
      body: _itens(),
    );
  }

  _itens() {
    return ListView.builder(
      itemCount: veiculos.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => {
          _tapItem(context),
        },
        child: VeiculoCard(veiculos[index]),
      ),
    );
  }

  _tapItem(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _tapAppBar(context) {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text("Flutter é topzera"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text("Cancelar"),
              ),
              TextButton(
                onPressed: () => {
                  Navigator.pop(context),
                  Navigator.pop(context),
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }
}
