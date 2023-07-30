import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_pib_app/controllers/UserController.dart';
import 'package:new_pib_app/network/network.dart';
import 'package:new_pib_app/views/cadastro.dart';
import 'package:new_pib_app/views/external.dart';
import 'package:new_pib_app/views/homePage/home.dart';
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';

import '../controllers/ChurchController.dart';
import '../models/igreja.dart';
import 'church/ListChurch.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
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
                        'Login',
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
                    controller: controllerEmail,
                    icon: Icons.email,
                    nome: 'E-mail',
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
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                            child: const Text(
                              'Ainda não possuí conta? cadastre-se por aqui',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            onTap: () async {
                              List<Igreja> igrejas =
                                  await ChurchController.getChurchs();
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: Cadastro(igrejas: igrejas),
                                      type: PageTransitionType.fade));
                            })
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButtonCustom(
                          color: ColorsWhiteTheme.cardColor,
                          name: 'Entrar',
                          onPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            // showDialogue(context);
                            bool result = await UserController.login(
                                controllerEmail.text, controllerPassword.text);
                                print(result);
                            if (result == true) {
                  List<Igreja>churchs = await ChurchController.getChurchs();
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          child: ChurchList(
                            churchs: churchs,
                          ),
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 150)),
                      ModalRoute.withName('/'));
                            } else {
                              print('object');
                            }
                          },
                        ),
                        ElevatedButtonCustom(
                          onPressed: () async {
                            var cifrasOffline =
                                await getExternalStorageDirectory();
                            List<FileSystemEntity> cifras =
                                cifrasOffline!.listSync();
                          },
                          color: ColorsWhiteTheme.cardColor2,
                          name: 'Modo Offline',
                        )
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
}
