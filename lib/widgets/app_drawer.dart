import 'package:flutter/material.dart';
import 'package:flutter_app/pages/pagina_dois.dart';
import 'package:flutter_app/pages/pagina_tres.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Felipe Junges"),
              accountEmail: Text("felipejunges@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "F",
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.directions_car),
              title: Text("Veículos"),
              subtitle: Text("Uhmmm que interessante!"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => {
                Navigator.pop(context),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaDois()),
                ),
              },
            ),
            ListTile(
              leading: Icon(Icons.local_gas_station),
              title: Text("Abastecimentos"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => {
                Navigator.pop(context),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaTres()),
                ),
              },
            ),
            Divider(),
            Expanded(
              child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: new Text('Bottom'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
