import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:new_pib_app/main.dart';
import 'package:new_pib_app/models/Permission.dart';
import 'package:new_pib_app/network/network.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';

class UserController {
  static Future<bool> login(String username, String password) async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      String token = '';
      if (!localStorage.containsKey('access_token')) {
        token = await Network().getAcess(username, password);
      } else {
        token = jsonDecode(localStorage.getString('access_token')!);
      }

      var fullUrl = Uri.http(
        dotenv.env['host']!,
        '/api/mount_user',
      );
      var response = await http.post(fullUrl,
          body: jsonEncode({
            "email": username,
            "password": password,
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': "Bearer " + token!
          });
      var responseData = jsonDecode(response.body);

      if (responseData['success'] == true) {
        PermissionFirebase permissoes = PermissionFirebase(
            responseData['permissions']['igreja'],
            responseData['permissions']['campanha'],
            responseData['permissions']['campanha_culto'],
            responseData['permissions']['culto'],
            responseData['permissions']['evento_musicas'],
            responseData['permissions']['evento_integrantes'],
            responseData['permissions']['culto'],
            responseData['permissions']['departamento'],
            responseData['permissions']['departamento_integrantes'],
            responseData['permissions']['departamento_avisos'],
            responseData['permissions']['musicas'],
            responseData['permissions']['pedidos_oracao'],
            responseData['permissions']['pedidos_musica'],
            responseData['permissions']['pastas'],
            responseData['permissions']['cifras'],
            responseData['permissions']['categorias'],
            responseData['permissions']['membros'],
            null,
            null);

        if (responseData['permissions'] != null) {
          if (!getIt.isRegistered<UserCustom>() &&
              !localStorage.containsKey('UserCustom')) {
            UserCustom usuario = UserCustom(responseData['user']['id'],
                permissoes, responseData['user'], token, null);
            getIt.registerSingleton(usuario, signalsReady: true);
            localStorage.setString('UserCustom', json.encode(usuario.toJson()));
          } else {
            // getIt<UserCustom>().UpdateUser(user);
            // getIt<UserCustom>().updatePermissions(permissao!);
            // getIt<UserCustom>().updateMinisterios([usuario!['idMinisterio']]);
          }
        }
        return true;
      }
    } on Exception catch (e) {
      print(e);
    }
    return false;
  }

  static Future<Map<String, dynamic>> register(
      String email, String password, String name,int idIgrejaSelecionada) async {
    var fullUrl = Uri.http(
      dotenv.env['host']!,
      '/api/register',
    );
    late Map<String, dynamic> data;
    late Response response;

    try {
      var response = await http.post(fullUrl,
          body:
              jsonEncode({"email": email, "password": password, 'name': name,'id_igreja': idIgrejaSelecionada}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      data = jsonDecode(response.body);
    } on Exception catch (e) {
      print(e);
    }
    return data;
  }
}
