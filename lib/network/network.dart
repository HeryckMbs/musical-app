import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_pib_app/main.dart';
import 'package:new_pib_app/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Network {
  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token')!)['token'];
  }

  getAcess(String username, String password) async {
    var fullUrl = Uri.http(
      dotenv.env['host']!,
      '/oauth/token',
    );
    var response = await http.post(fullUrl,
        body: jsonEncode({
          "grant_type": "password",
          "client_id": dotenv.env['client_id'],
          "client_secret": dotenv.env['client_secret'],
          "username": username,
          "password": password,
          "scope": ""
        }),
        headers: setHeaders());
    var responseToken = jsonDecode(response.body);
    print(responseToken);
    if (responseToken['error'] == null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();

    if( getIt.isRegistered<Token>()){
      getIt<Token>().updateData( responseToken['access_token'],  responseToken['refresh_token'], DateTime.now().add(Duration(seconds: responseToken['expires_in'])));
    }else{
      getIt.registerSingleton(Token(accessToken: responseToken['access_token'],refreshToken:  responseToken['refresh_token'],validUntil:  DateTime.now().add(Duration(seconds: responseToken['expires_in']))));
    }
      localStorage.setString('access_token',responseToken['access_token'] ) ;
      localStorage.setString('refresh_token', responseToken['refresh_token']) ;
      localStorage.setString('valid_until', DateTime.now().add(Duration(seconds: responseToken['expires_in'])).toString()) ;
      return responseToken['access_token'];
    }
    return false;
  }

  refreshToken() async {
    var fullUrl = Uri.http(
      dotenv.env['host']!,
      '/oauth/token',
    );
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(fullUrl,
        body: jsonEncode({
          "grant_type": "refresh_token",
          'refresh_token': json.decode(localStorage.getString('refresh_token')!),
          "client_id": dotenv.env['client_id'],
          "client_secret": dotenv.env['client_secret'],
          "scope": ""
        }),
        headers: setHeaders());
    var responseToken = jsonDecode(response.body);
    if (responseToken['error'] == null) {

      if( getIt.isRegistered<Token>()){
        getIt<Token>().updateData( responseToken['access_token'],  responseToken['refresh_token'], DateTime.now().add(Duration(seconds: responseToken['expires_in'])));
      }else{
        getIt.registerSingleton(Token(accessToken: responseToken['access_token'],refreshToken:  responseToken['refresh_token'],validUntil:  DateTime.now().add(Duration(seconds: responseToken['expires_in']))));
      }
      localStorage.setString('access_token',responseToken['access_token'] ) ;
      localStorage.setString('refresh_token', responseToken['refresh_token']) ;
      localStorage.setString('valid_until', DateTime.now().add(Duration(seconds: responseToken['expires_in'])).toString()) ;
      return true;
    }
    return false;
  }

  Map<String,String> setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
