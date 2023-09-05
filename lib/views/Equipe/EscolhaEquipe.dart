import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_pib_app/controllers/EquipeController.dart';
import 'package:new_pib_app/controllers/UserController.dart';
import 'package:new_pib_app/main.dart';
import 'package:new_pib_app/views/Equipe/cadastroEquipe.dart';
import 'package:new_pib_app/views/Equipe/listEquipe.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/Equipe.dart';
import '../../models/sessao.dart';
import '../home/home.dart';
import '../utils/utils.dart';

class EscolhaEquipe extends StatefulWidget {
  EscolhaEquipe({
    super.key,
  });

  @override
  State<EscolhaEquipe> createState() => _EscolhaEquipeState();
}

class _EscolhaEquipeState extends State<EscolhaEquipe> {
  @override
  void dispose() {
    // Limpa os controladores quando o widget for descartado

    super.dispose();
  }

  bool enterCode = false;
  TextEditingController code = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // title:  GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).pop();
            //   },
            //   child: Icon(
            //     Icons.arrow_back,
            //     color: Colors.white,
            //     size: 28,
            //   ),
            // ),
            actions: [],
            backgroundColor: StandardTheme.homeColor),
        backgroundColor: StandardTheme.homeColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Escolha uma opção',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: CadastroEquipe(),
                          type: PageTransitionType.fade));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.add,
                        ),
                      ),
                      Text(
                        'Criar nova equipe',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    enterCode = false;
                  });

                  List<Equipe> equipes = await EquipeController.getEquipes();
                  await Navigator.push(
                      context,
                      PageTransition(
                          child: ListEquipe(
                            equipes: equipes,
                          ),
                          type: PageTransitionType.fade));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.add),
                      ),
                      Text(
                        'Escolher equipe',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    enterCode = !enterCode;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.edit),
                      ),
                      Text(
                        'Inserir código de equipe',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: enterCode,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Input(
                    nome: 'Código da equipe',
                    onChange: (value) async {
                      // showDial
                      if (value.toString().length == 8) {
                        showDialogue(context);
                        Map<String, dynamic> result =
                            await EquipeController.associarEquipe(value);
                        print(result);
                        messageToUser(context, result['message'], Colors.cyan,
                            Icons.construction);
                        if (result['success'] != null &&
                            result['success'] == true) {

                          getIt<Sessao>().setEquipe(result['data']['id']);
                          await Navigator.push(
                              context,
                              PageTransition(
                                  child: Home(),
                                  type: PageTransitionType.fade));
                        }
                        hideProgressDialogue(context);
                      }
                    },
                    dark: true,
                    onTap: () {},
                    password: false,
                    validate: (value) {},
                    icon: null,
                    action: TextInputAction.next,
                    controller: code,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
