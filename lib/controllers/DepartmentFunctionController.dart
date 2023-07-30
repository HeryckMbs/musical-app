import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:new_pib_app/main.dart';
import 'package:new_pib_app/models/Funcao.dart';
import 'package:http/http.dart' as http;

import '../models/User.dart';

class DepartmentFunctionController {
  static Future<List<Funcao>> getDepartmentFunctions(int idDepartament) async {
    List<Funcao> funcoes = [];
    try {
      var fullUrl = Uri.http(
        dotenv.env['host']!,
        'api/department/$idDepartament/funcoes',
      );
      String? token = getIt<UserCustom>().access_token;
      var response = await http.get(fullUrl, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization' : 'Bearer $token'
      });

      var responseData = jsonDecode(response.body);
      if (responseData['success'] == true) {
        for (var item in responseData['funcoes']) {
          funcoes.add(Funcao.fromJson(item));
        }
      }
    } on Exception catch (e) {
      print(e);
    }
    return funcoes;
  }

  static Future<Map<String,dynamic>> createFunction(String nome, String descricao,int idDepartament) async{
        String? accessToken = getIt<UserCustom>().access_token;
    var fullUrl = Uri.http(
      dotenv.env['host']!,
      '/api/department/$idDepartament/addFuncao',
    );
    late Response response;
     Map<String, dynamic> data = {'s':'sd'};
           String? token = getIt<UserCustom>().access_token;

    try{
      response = await http.post(fullUrl,body: jsonEncode({
        'nome': nome,
        'descricao': descricao,
        'id_departamento' : idDepartament
      }),headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization' : 'Bearer $token'
      });

      data = json.decode(response.body);

    }on Exception catch(e){
      print(e);
    }

    return data;

  }


}
