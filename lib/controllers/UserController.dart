import 'dart:convert';

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
      if (!localStorage.containsKey('access_token')) {
        await Network().getAcess(username, password);
      }
      String? accessToken = jsonDecode(localStorage.getString('access_token')!);

      var fullUrl = Uri.http(
        '192.168.1.105:8000',
        '/api/mount_user',
      );
      print('Bearer ' + accessToken!);
      var response = await http.post(fullUrl,
          body: jsonEncode({
            "email": username,
            "password": password,
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': "Bearer " + accessToken!
          });
      var responseData = jsonDecode(response.body);
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
        print(!getIt.isRegistered<UserCustom>());
        if (!getIt.isRegistered<UserCustom>()) {
          getIt.registerSingleton<UserCustom>(
              UserCustom(responseData['user']['id'].toString(), permissoes,
                  responseData['user']),
              signalsReady: true);
        } else {
          // getIt<UserCustom>().UpdateUser(user);
          // getIt<UserCustom>().updatePermissions(permissao!);
          // getIt<UserCustom>().updateMinisterios([usuario!['idMinisterio']]);
        }
      }
    } on Exception catch (e) {
      print(e);
    }

    return true;
  }
}
