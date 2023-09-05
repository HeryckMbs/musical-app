// import 'dart:convert';
//
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart';
// import 'package:new_pib_app/main.dart';
// import 'package:new_pib_app/models/Funcao.dart';
// import 'package:http/http.dart' as http;
// import '../models/User.dart';
//
// class DepartmentIntegranteController {
//   static Future<Map<String, dynamic>> updateFunctionOfMember(
//       int idMembro,int idDepartament, int? idNovaFuncao) async {
//     Map<String, dynamic> data = {};
//     try {
//       var fullUrl = Uri.http(
//         dotenv.env['host']!,
//         'api/department/${idDepartament}/updateFuncaoMember',
//       );
//       String? token = getIt<UserCustom>().access_token;
//       var response = await http.put(fullUrl,
//           body: json.encode({'id_nova_funcao': idNovaFuncao,'id_membro':idMembro}),
//           headers: {
//             'Content-type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization': 'Bearer $token'
//           });
//
//       data = jsonDecode(response.body);
//     } on Exception catch (e) {
//       print(e);
//     }
//     return data;
//   }
//    static Future<Map<String, dynamic>> deleteMemberOfDepartment(
//       int idIntegrante,int idDepartament) async {
//     Map<String, dynamic> data = {};
//     try {
//       var fullUrl = Uri.http(
//         dotenv.env['host']!,
//         'api/department/deleteMember',
//       );
//       String? token = getIt<UserCustom>().access_token;
//       var response = await http.delete(fullUrl,
//       body: json.encode({
//         'id_membro' : idIntegrante,'id_departamento' : idDepartament
//       }),
//           headers: {
//             'Content-type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization': 'Bearer $token'
//           });
//
//       data = jsonDecode(response.body);
//     } on Exception catch (e) {
//       print(e);
//     }
//     return data;
//   }
// }
