import 'dart:convert';

import 'package:flutter_app/models/auth.dart';
import 'package:flutter_app/models/conta_bancaria.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class MangosApiService {
  static String URL = "http://192.168.40.102:5000";

  static Future<bool> login(String email, String senha) async {
    final url = Uri.parse('$URL/api/Login');
    final headers = {"Content-Type": "application/json"};
    final body = {'email': email, 'senha': senha};

    try {
      print("Calling POST /Login...");

      var response = await http
          .post(
            url,
            headers: headers,
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 45));

      if (response.statusCode == 200) {
        Map jsonResponse = json.decode(response.body);

        var auth = Auth.fromJson(jsonResponse);
        print("Expires: ${auth.expiration}");

        final authService = new AuthService();
        await authService.save(auth);

        print("Body: ${response.body}");
        print("AuthToken: ${auth.token}");

        return true;
      } else {
        return false;
      }
    } catch (error) {
      print("Erro: $error");
      return false;
    }
  }

  static Future<bool> refresh() async {
    final url = Uri.parse('$URL/api/Login');
    final headers = {"Content-Type": "application/json"};

    final authService = new AuthService();
    final auth = await authService.get();

    final body = {
      'authenticationToken': auth?.token,
      'refreshToken': auth?.refreshToken
    };

    try {
      print("Calling PUT /Login...");

      var response = await http
          .put(
            url,
            headers: headers,
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 45));

      if (response.statusCode == 200) {
        Map jsonResponse = json.decode(response.body);

        var auth = Auth.fromJson(jsonResponse);

        await authService.save(auth);

        print("Body: ${response.body}");
        print("AuthToken: ${auth.token}");

        return true;
      } else {
        return false;
      }
    } catch (error) {
      print("Erro: $error");
      return false;
    }
  }

  static Future<String> getContas() async {
    final authService = new AuthService();
    final auth = await authService.get();

    final url = Uri.parse('$URL/api/ContaBancaria');
    var headers = {
      "Authorization": "Bearer ${auth?.token}",
    };

    try {
      print("Calling GET /ContaBancaria...");

      var response = await http
          .get(
            url,
            headers: headers,
          )
          .timeout(const Duration(seconds: 45));

      print("StatusCode: ${response.statusCode}");

      if (response.statusCode == 200) {
        print(response.body);

        List jsonResponse = json.decode(response.body);

        var contas = jsonResponse
            .map<ContaBancaria>((f) => ContaBancaria.fromJson(f))
            .toList();

        return "Obtidas ${contas.length} contas";
      } else {
        return "StatusCode: ${response.statusCode}";
      }
    } catch (error) {
      print("Erro: $error");
      return "Erro: $error";
    }
  }
}
