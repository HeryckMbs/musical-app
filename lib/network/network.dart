import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = '192.168.1.105:8000/api/';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token')!)['token'];
  }

  getAcess(String username, String password) async {
    var fullUrl = Uri.http(
      '192.168.1.105:8000',
      '/oauth/token',
    );
    var response = await http.post(fullUrl,
        body: jsonEncode({
          "grant_type": "password",
          "client_id": "99c02f67-0080-45cb-9a3f-db3799086232",
          "client_secret": "F5kBlsvaeAujNUyi1AAD4xpRKlaF03O57bUQs1RD",
          "username": username,
          "password": password,
          "scope": ""
        }),
        headers: _setHeaders());
    var responseToken = jsonDecode(response.body);
    print(responseToken);
    if (responseToken['error'] == null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(
          'access_token', json.encode(responseToken['access_token']));
      localStorage.setString(
          'refresh_token', json.encode(responseToken['refresh_token']));
      return true;
    }
    return false;
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
