import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:new_pib_app/main.dart';
import 'package:new_pib_app/network/network.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class UserController {
  static Future<bool> login(String username, String password) async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = '';
      if (!localStorage.containsKey('token')) {
        token = await Network().getAcess(username, password);
      } else {
        token = jsonDecode(localStorage.getString('token')!);
      }

return true;

      //
      // var fullUrl = Uri.http(
      //   dotenv.env['host']!,
      //   '/api/mount_user',
      // );
      // var response = await http.post(fullUrl,
      //     body: jsonEncode({
      //       "email": username,
      //       "password": password,
      //     }),
      //     headers: {
      //       'Content-type': 'application/json',
      //       'Accept': 'application/json',
      //       'Authorization': "Bearer " + token!
      //     });
      // var responseData = jsonDecode(response.body);
      //
      // if (responseData['success'] == true) {
      //
      //     if (!getIt.isRegistered<UserCustom>() && !localStorage.containsKey('UserCustom')) {
      //       UserCustom usuario = UserCustom(responseData['user']['id'],
      //           permissoes, responseData['user'], token, null);
      //       getIt.registerSingleton(usuario, signalsReady: true);
      //     } else {
      //       // getIt<UserCustom>().UpdateUser(user);
      //       // getIt<UserCustom>().updatePermissions(permissao!);
      //       // getIt<UserCustom>().updateMinisterios([usuario!['idMinisterio']]);
      //     }
      //
      //   return true;
      // }
    } on Exception catch (e) {
      print(e);
    }
    return false;
  }

  static Future<Map<String, dynamic>> register(
      String email, String password, String name,) async {
    var fullUrl = Uri.http(
      dotenv.env['host']!,
      '/api/register',
    );
    print(fullUrl);
    late Map<String, dynamic> data;
    late Response response;

    try {
      var response = await http.post(fullUrl,
          body:
              jsonEncode({"email": email, "password": password, 'name': name}),
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
