import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:new_pib_app/models/token.dart';

import '../main.dart';
import '../models/Equipe.dart';
import '../models/sessao.dart';

class EquipeController{
  static Future<Map<String, dynamic>> createEquipe(String nome,
      String descricao, bool open) async {
    String? accessToken = getIt<Token>().accessToken;
    var fullUrl = Uri.http(
      dotenv.env['host']!,
      '/api/equipe',
    );
    late Response response;
    late Map<String, dynamic> data;

    try {
      response = await http.post(fullUrl,
          body: json.encode({
            'nome': nome,
            'descricao': descricao,
            'open' : open,
          }),
          headers: {
            'Authorization': "Bearer " + accessToken!,
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });

      data = jsonDecode(response.body);
      getIt<Sessao>().setEquipe(data['data']['id']);
    } on Exception catch (e) {
      print(e);
    }
    return data;
  }
  static Future<List<Equipe>> getEquipes() async {
    String? accessToken = getIt<Token>().accessToken;
    var fullUrl = Uri.http(
      dotenv.env['host']!,
      '/api/listEquipe',
    );
    late Response response;
    late Map<String, dynamic> data;
    List<Equipe> equipes = [];
    try {
      response = await http.get(fullUrl,
          headers: {
            'Authorization': "Bearer " + accessToken!,
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });

      data = jsonDecode(response.body);
      if(data['success'] != null && data['success'] == true){
            for(var equipe in data['data'] ){
              equipes.add(Equipe.fromJson(equipe));
            }
      }
    } on Exception catch (e) {
      print(e);
    }
    return equipes;
  }

  static Future<Map<String, dynamic>> associarEquipe(String code) async {
    String? accessToken = getIt<Token>().accessToken;
    var fullUrl = Uri.http(
      dotenv.env['host']!,
      '/api/getEquipe/$code',
    );
    late Response response;
    late Map<String, dynamic> data;
    try {
      response = await http.get(fullUrl,
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

  static Future<Equipe?> getEquipeAtual() async{
    String? accessToken = getIt<Token>().accessToken;
    int codeEquipe = getIt<Sessao>().idEquipe_selecionada;
    var fullUrl = Uri.http(
      dotenv.env['host']!,
      '/api/equipe/$codeEquipe',
    );
    late Response response;
    late Map<String, dynamic> data;
    Equipe? equipe = null;
    try {
      response = await http.get(fullUrl,
          headers: {
            'Authorization': "Bearer " + accessToken!,
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });

      data = jsonDecode(response.body);
      print(data);

      equipe= Equipe.fromJson(data['data']);
    } on Exception catch (e) {
      print(e);
    }
    return equipe;
  }


}