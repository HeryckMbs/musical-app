// import 'dart:convert';
//
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart';
// import 'package:new_pib_app/main.dart';
// import 'package:new_pib_app/models/Permission.dart';
// import 'package:new_pib_app/models/igreja.dart';
// import 'package:new_pib_app/models/membro.dart';
// import 'package:new_pib_app/network/network.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../models/User.dart';
//
// class ChurchController {
//   static Future<List<Igreja>> getChurchs() async {
//     List<Igreja> igrejas = [];
//     try {
//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//       // if (!localStorage.containsKey('access_token')) {
//       //   await Network().getAcess(username, password);
//       // }
//       var fullUrl = Uri.http(
//         dotenv.env['host']!,
//         'api/getChurchs',
//       );
//
//       var response = await http.get(fullUrl, headers: {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//       });
//
//       var responseData = jsonDecode(response.body);
//       if (responseData['success'] == true) {
//         for (var item in responseData['churchs']) {
//           igrejas.add(Igreja.fromJson(item));
//         }
//       }
//
//       return igrejas;
//     } on Exception catch (e) {
//       print(e);
//     }
//     return igrejas;
//   }
//
//   static Future<List<Member>> getMembers(int idChurch) async {
//     List<Member> membros = [];
//     try {
//       String? accessToken = getIt<UserCustom>().access_token;
//       var fullUrl =
//           Uri.http(dotenv.env['host']!, '/api/church/$idChurch/members');
//       var response = await http.get(fullUrl, headers: {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': "Bearer " + accessToken!
//       });
//
//       var responseData = jsonDecode(response.body);
//
//       if (responseData['success'] == true) {
//         for (var item in responseData['members']) {
//           membros.add(Member.fromJson(item));
//         }
//       }
//     } on Exception catch (e) {
//       print(e);
//     }
//     return membros;
//   }
//
//   static Future<Map<String, dynamic>> createChurch(
//       String nome, String telefone) async {
//     String? accessToken = getIt<UserCustom>().access_token;
//     var fullUrl = Uri.http(
//       dotenv.env['host']!,
//       '/api/church/store',
//     );
//     late Response response;
//
//     Map<String, dynamic> data = {'': ''};
//
//     try {
//       response = await http.post(fullUrl,
//           body: {'nome': nome, 'telefone': telefone},
//           headers: {'Authorization': "Bearer " + accessToken!});
//       data = jsonDecode(response.body);
//     } on Exception catch (e) {
//       print(e);
//     }
//     return data;
//   }
//
//   static Future<Map<String, dynamic>> EditChurch(Igreja igreja) async {
//     String? accessToken = getIt<UserCustom>().access_token;
//     var fullUrl = Uri.http(
//       dotenv.env['host']!,
//       '/api/church/${igreja.id}/updateChurch',
//     );
//     late Response response;
//
//     Map<String, dynamic> data = {'': ''};
//
//     try {
//       response = await http
//           .put(fullUrl, body: jsonEncode({'igreja': igreja}), headers: {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': "Bearer " + accessToken!
//       });
//       data = jsonDecode(response.body);
//     } on Exception catch (e) {
//       print(e);
//     }
//     return data;
//   }
//
//   static Future<Igreja> getChurch(int idIgreja) async {
//     String? accessToken = getIt<UserCustom>().access_token;
//     var fullUrl = Uri.http(
//       dotenv.env['host']!,
//       '/api/church/$idIgreja',
//     );
//     late Response response;
//     late Igreja igreja;
//     Map<String, dynamic> data = {'': ''};
//
//     try {
//       response = await http.get(fullUrl, headers: {
//         'Authorization': "Bearer " + accessToken!,
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//       });
//       data = jsonDecode(response.body);
//       igreja = Igreja.fromJson(data['church']);
//     } on Exception catch (e) {
//       print(e);
//     }
//     return igreja;
//   }
// }
