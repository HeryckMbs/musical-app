// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:new_pib_app/controllers/UserController.dart';
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:page_transition/page_transition.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/ChurchController.dart';
import '../models/igreja.dart';
import 'church/ListChurch.dart';

class Cadastro extends StatefulWidget {
 Cadastro({super.key, required this.igrejas});
  List<Igreja> igrejas;
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  bool loading = false;
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  List<Igreja> igrejas = [];
  int idIgrejaSelecionada = 0;
  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    igrejas= widget.igrejas;
    idIgrejaSelecionada = igrejas.first.id!;
    super.initState();
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
                    DropdownButtonFormField(
                        enableFeedback: true,
                        decoration: DecorationVariables.decorationInput('Igreja'),
                        dropdownColor: ColorsWhiteTheme.cardColor2,
                        value: idIgrejaSelecionada,
                        padding: EdgeInsets.all(8),
                        icon: Icon(
                          Icons.arrow_downward,
                          color: Colors.grey,
                        ),
                        isExpanded: true,
                        onChanged: (value) {},

                        iconEnabledColor: ColorsWhiteTheme.cardColor2,
                        items:
                            igrejas.map<DropdownMenuItem<int>>((Igreja igreja) {
                          return DropdownMenuItem<int>(
                              onTap: () {
                                setState(() {
                                  idIgrejaSelecionada = igreja.id!;
                                });
                              },
                              value: igreja.id,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: ColorsWhiteTheme.cardColor2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: StatefulBuilder(
                                    builder: ((context, setState) {
                                  return Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: ColorsWhiteTheme.cardColor,
                                      ),
                                      Expanded(
                                        child: Text(
                                          igreja.nome!,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  );
                                })),
                              ));
                        }).toList(),
                      ),
                     
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButtonCustom(
                          color: ColorsWhiteTheme.cardColor,
                          name: 'Cdastrar',
                          onPressed: () async {
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
                              Map<String, dynamic> result =
                                  await UserController.register(
                                      controllerEmail.text,
                                      controllerPassword.text,
                                      controllerNome.text,idIgrejaSelecionada);
                              if (result['success']) {
                                bool logged = await UserController.login(
                                    controllerEmail.text,
                                    controllerPassword.text);
                                if (logged) {

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      PageTransition(
                                          child: ChurchList(
                                            churchs: igrejas,
                                          ),
                                          type: PageTransitionType.fade,
                                          duration:
                                              Duration(milliseconds: 150)),
                                      ModalRoute.withName('/'));
                                }
                              } else {
                                // ignore: use_build_context_synchronously
                                messageToUser(
                                    context,
                                    result['message'],
                                    result['success']
                                        ? Colors.green
                                        : Colors.red,
                                    result['success']
                                        ? Icons.done
                                        : Icons.dangerous);
                              }
                            }
                          },
                        ),
                      ]),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
