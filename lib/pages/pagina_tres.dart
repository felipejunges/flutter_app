import 'package:flutter/services.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/mangos_api_service.dart';
import 'package:flutter_app/utils/connection.dart';
import 'package:flutter_app/widgets/campo_form.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class PaginaTres extends StatefulWidget {
  @override
  _PaginaTresState createState() => _PaginaTresState();
}

class _PaginaTresState extends State<PaginaTres> {
  final _tLogin = TextEditingController(text: "felipejunges@yahoo.com.br");
  final _tSenha = TextEditingController(text: "felipe123");

  final _formKey = GlobalKey<FormState>();

  var _processandoLogin = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Página 3"),
          bottom: _tabBar(),
        ),
        body: TabBarView(
          children: [
            _body(context),
            _body2(context),
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return TabBar(
      tabs: [
        Tab(text: "Tab 1"),
        Tab(text: "Tab 2"),
      ],
    );
  }

  _body2(context) {
    return Column(children: <Widget>[
      Expanded(
        flex: 7,
        child: Container(
          color: Colors.yellow[300],
        ),
      ),
      Expanded(
        flex: 3,
        child: Container(
          color: Colors.red[300],
        ),
      ),
    ]);
  }

  _body(context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(8),
        color: Colors.blue[300],
        child: ListView(
          children: [
            CampoForm(
              "Login",
              "Digite o login",
              controller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 10),
            CampoForm(
              "Senha",
              "Digite a senha",
              controller: _tSenha,
              password: true,
              validator: _validateSenha,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _processandoLogin ? null : () => _login(context),
              child: Text(_processandoLogin ? "Logando..." : "Login"),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () => _refresh(),
              child: Text("Refresh"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logout(),
              child: Text("Logout"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _contas(),
              child: Text("Contas"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _jwt(),
              child: Text("JWT"),
            ),
          ],
        ),
      ),
    );
  }

  String _validateLogin(String login) {
    if (login.isEmpty) return "O login deve ser informado";
    return null;
  }

  String _validateSenha(String senha) {
    if (senha.isEmpty) return "A senha deve ser informada";
    if (senha.length < 3) return "A senha deve ser pelo menos três caracteres";
    return null;
  }

  _login(context) async {
    if (!await Connection.isConnected()) {
      _toast("Não conectado");
      return;
    }

    bool formOk = _formKey.currentState.validate();
    if (!formOk) return;

    FocusScope.of(context).unfocus();

    setState(() {
      _processandoLogin = true;
    });

    if (await MangosApiService.login(_tLogin.text, _tSenha.text))
      _toast("Sucesso!");
    else
      _toast("Falhou");

    setState(() {
      _processandoLogin = false;
    });
  }

  _logout() async {
    new AuthService().clear();
  }

  _refresh() async {
    if (!await Connection.isConnected()) {
      _toast("Não conectado");
      return;
    }
    if (await MangosApiService.refresh())
      _toast("Sucesso no refresh!");
    else
      _toast("Refresh falhou");
  }

  _contas() async {
    if (!await Connection.isConnected()) {
      _toast("Não conectado");
      return;
    }

    var retorno = await MangosApiService.getContas();

    _toast(retorno);
  }

  _jwt() async {
    await new AuthService().getNome();
  }

  _toast(mensagem) {
    Fluttertoast.showToast(
        msg: mensagem,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
