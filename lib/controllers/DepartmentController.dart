import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:new_pib_app/main.dart';
import 'package:new_pib_app/models/Departamento.dart';
import 'package:new_pib_app/models/Permission.dart';
import 'package:new_pib_app/network/network.dart';
import 'package:http/http.dart' as http;
import 'package:new_pib_app/views/department/CreateDepartment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';
import '../models/membro.dart';

class DepartmentController {
  static Future<List<Departamento>> getDepartmentsOfChurch(int idChurch) async {
    List<Departamento> departamentos = [];
    try {
      String? accessToken = getIt<UserCustom>().access_token;

      var fullUrl = Uri.http(
        dotenv.env['host']!,
        '/api/department/getDepartmentsOfChurch/$idChurch',
      );

      var response = await http.get(fullUrl, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Bearer " + accessToken!
      });

      if (response.statusCode == 401) {
        await Network().refreshToken();
      }
      var responseData = jsonDecode(response.body);
      if (responseData['success']) {
        for (var item in responseData['departmens']) {
          departamentos.add(Departamento.fromJson(item));
        }
      }
    } on Exception catch (e) {
      print(e);
    }
    return departamentos;
  }

  static Future<Map<String, dynamic>> createDepartment(String nome,
      String descricao, String objetivo, int idLider, bool isLouvor) async {
    String? accessToken = getIt<UserCustom>().access_token;
    var fullUrl = Uri.http(
      dotenv.env['host']!,
      '/api/department/store',
    );
    late Response response;
    late Map<String, dynamic> data;

    try {
      response = await http.post(fullUrl,
          body: json.encode({
            'nome': nome,
            'descricao': descricao,
            'objetivo': objetivo,
            'id_lider': idLider,
            'id_igreja': getIt<UserCustom>().igreja_selecionada,
            'louvor': isLouvor
          }),
          headers: {
            'Authorization': "Bearer " + accessToken!,
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });

      data = jsonDecode(response.body);
    } on Exception catch (e) {
      print(e);
    }
    return data;
  }

  static Future<Departamento> getDepartment(int idDepartament) async {
    String? accessToken = getIt<UserCustom>().access_token;
    var fullUrl = Uri.http(
      dotenv.env['host']!,
      '/api/department/$idDepartament',
    );
    late Response response;
    late Departamento departamento;
    Map<String, dynamic> data = {'': ''};

    try {
      response = await http.get(fullUrl, headers: {
        'Authorization': "Bearer " + accessToken!,
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      data = jsonDecode(response.body);
      departamento = Departamento.fromJson(data['department']);
    } on Exception catch (e) {
      print(e);
    }
    return departamento;
  }

  static Future<List<Member>> getDepartmentMembers(int idDepartament) async {
    String? accessToken = getIt<UserCustom>().access_token;

    var fullUrl = Uri.http(
      dotenv.env['host']!,
      '/api/department/$idDepartament/membros',
    );
    late Response response;
    List<Member> membros = [];
    Map<String, dynamic> data = {'': ''};

    try {
      response = await http.get(fullUrl, headers: {
        'Authorization': "Bearer ${accessToken!}",
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      data = jsonDecode(response.body);
      for (var item in data['members']) {
        membros.add(Member.fromJson(item));
      }
    } on Exception catch (e) {
      print(e);
    }
    return membros;
  }

  static Future<Map<String, dynamic>> addMembers(
      List<Member> membros, int idDepartament) async {
    String? accessToken = getIt<UserCustom>().access_token;
    var fullUrl = Uri.http(
      dotenv.env['host']!,
      '/api/department/$idDepartament/addMembros',
    );
    List<int> idMembros = [];
    // ignore: unused_local_variable
    for (Member membro in membros) {
      idMembros.add(membro.id!);
    }
    late Response response;
    Map<String, dynamic> data = {'': ''};

    try {
      response = await http.post(fullUrl, body:json.encode( {
        'members': idMembros,
        'id_departmento': idDepartament
      }), headers: {
        'Authorization': "Bearer ${accessToken!}",
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      data = jsonDecode(response.body);
    } on Exception catch (e) {
      print(e);
    }
    return data;
  }

    static Future<List<Member>> getMembersWithoutDeparment(int idDepartamento,int id_igreja) async {
    List<Member> membros = [];
    try {
      String? accessToken = getIt<UserCustom>().access_token;
      var fullUrl =
          Uri.http(dotenv.env['host']!, '/api/department/$id_igreja/membrosWithoutDepartment/$idDepartamento');
      var response = await http.get(fullUrl, 
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Bearer " + accessToken!
      });

      var responseData = jsonDecode(response.body);

      if (responseData['success'] == true) {
        for (var item in responseData['members']) {
          membros.add(Member.fromJson(item));
        }
      }
    } on Exception catch (e) {
      print(e);
    }
    return membros;
  }

  static Future<Map<String,dynamic>> EditDepartament(Departamento departamento) async{
    String? accessToken = getIt<UserCustom>().access_token;
    var fullUrl = Uri.http(
      dotenv.env['host']!,
      '/api/department/${departamento.id}/updateDepartamento',
    );
    late Response response;
    Map<String, dynamic> data = {'': ''};

    try {
      response = await http.put(fullUrl, body:json.encode( {
        'departamento': departamento.toJson(),
      }), headers: {
        'Authorization': "Bearer ${accessToken!}",
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      data = jsonDecode(response.body);
      if(data['erros'] != null){
        data['success'] = false;
        data['message'] = json.decode(data['erros']).toString();
      }
    } on Exception catch (e) {
      print(e);
    }
    return data;
  }
}
