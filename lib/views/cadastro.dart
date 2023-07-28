import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:new_pib_app/views/utils/utils.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  bool loading = false;
  TextEditingController controllerNome= TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //new line
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(245, 224, 12, 1),
                  Color.fromRGBO(255, 184, 0, 1),
                ],
              ),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    // widget.title,
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Image.asset('assets/logo.png'),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Color(0xFF131112),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Cadastre-se',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Input(
                    onTap: () {},
                    validate: (value) {},
                    onChange: (value) {},
                    controller: controllerNome,
                    icon: Icons.email,
                    nome: 'Nome',
                    password: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Input(
                    onTap: () {},
                    validate: (value) {},
                    onChange: (value) {},
                    controller: controllerEmail,
                    icon: Icons.password,
                    nome: 'Email',
                    password: false,
                  ),
                ),         
                       Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Input(
                    onTap: () {},
                    validate: (value) {},
                    onChange: (value) {},
                    controller: controllerPassword,
                    icon: Icons.password,
                    nome: 'Senha',
                    password: true,
                  ),
                ),
  
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButtonCustom(
                          color: ColorsWhiteTheme.cardColor,
                          name: 'Cdastrar',
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (controllerEmail.text == '' ||
                                controllerPassword.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Credenciais inválidas'),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            } else {
                              Cadastro();
                            }
                          },
                        ),

                      ]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.05,
                      horizontal: MediaQuery.of(context).size.width * 0.07),
                  child: const Center(
                    child: Text(
                      'Louvarei ao Senhor em todo o tempo o seu louvor estará continuamente na minha boca. Salmo 34:1',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Cadastro() async {
        var fullUrl = Uri.http(
      '192.168.1.105:8000',
      '/api/register',
    );
  

                                
    var response = await http.post(fullUrl,
        body: jsonEncode({
          "email": controllerEmail.text,
          "password": controllerPassword.text,
          'name': controllerNome.text
        }),headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',});
        print(jsonDecode(response.body));
        // headers:{
        //   'Authorization' : 'Bearer ${localStorage.getString('access_token')!}',
        //   'Accept' : 'application/json'
        // });

  }
}
