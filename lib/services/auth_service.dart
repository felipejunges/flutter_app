import 'dart:convert';

import 'package:flutter_app/models/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService {
  final _key = "jwt331";

  Future<Auth> get() async {
    final storage = new FlutterSecureStorage();

    if (await storage.containsKey(key: _key)) {
      var value = await storage.read(key: _key);

      return Auth.fromJson(json.decode(value));
    }

    return null;
  }

  save(Auth auth) async {
    var authEncode = json.encode(auth.toJson(), toEncodable: myEncode);

    final storage = new FlutterSecureStorage();
    await storage.write(key: _key, value: authEncode);
  }

  Future<String> getToken() async {
    var auth = await get();

    if (auth != null) return auth.token;
    return null;
  }

  Future<String> getNome() async {
    var token = await getToken();
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    print(payload);
    print(payload["grupo_id"]);
    print(payload["email"]);
    print(payload["given_name"]);

    return payload["given_name"];
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  clear() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: _key);
  }
}
