import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_pib_app/controllers/EquipeController.dart';
import 'package:new_pib_app/controllers/UserController.dart';
import 'package:new_pib_app/views/Equipe/EscolhaEquipe.dart';
import 'package:page_transition/page_transition.dart';

import '../home/home.dart';
import '../utils/utils.dart';


class CadastroEquipe extends StatefulWidget {
  CadastroEquipe({
    super.key,
  });

  @override
  State<CadastroEquipe> createState() => _CadastroEquipeState();
}

class _CadastroEquipeState extends State<CadastroEquipe> {
  TextEditingController nome = new TextEditingController();
  TextEditingController descricao = new TextEditingController();
  bool open = false;
  @override
  void dispose() {
    // Limpa os controladores quando o widget for descartado
    nome.dispose();
    descricao.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: StandardTheme.homeColor,
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.73),
            padding: EdgeInsets.symmetric(horizontal: 38),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                    weight: 1,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 0),
                  child: Text(
                    'Cadastrar equipe',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(38.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seja bem vindo',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Crie sua equipe e tenha mais facilidade ao tocar em grupo!',
                  ),
                  // InputElement(type: )
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28.0,top: 24),
                    child: Input(
                      nome: 'Nome da equipe',
                      onChange: (value) {},
                      onTap: () {},
                      password: false,
                      validate: (value) {},
                      icon: null,
                      action: TextInputAction.next,
                      controller: nome,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28.0,),
                    child: Input(
                      nome: 'Descrição',
                      constLines: 3,
                      onChange: (value) {},
                      onTap: () {},
                      password: false,
                      validate: (value) {},
                      icon: null,
                      action: TextInputAction.next,
                      controller: descricao,
                    ),
                  ),
                  CheckboxListTile(
                    subtitle: Text('Qualquer pessoa com o código da equipe poderá ingressar nela.'),
                    title: const Text('Aberta externamente'),
                    value: open,
                    activeColor: StandardTheme.homeColor,
                    onChanged: (bool? value) {
                      setState(() {
                        open = value! ;
                      });
                    },
                    secondary: const Icon(Icons.door_front_door),
                  ),
                  GestureDetector(
                    onTap: () async{
                      showDialogue(context);
                      Map<dynamic,dynamic> result = await   EquipeController.createEquipe(nome.text, descricao.text, open);
                      print(result);
                      if(result['success']){
                      await  Navigator.push(context, PageTransition(child: Home(), type: PageTransitionType.fade));

                      }
                      hideProgressDialogue(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(color: nome.text.isEmpty ? StandardTheme.disabledPrimary : StandardTheme.homeColor,borderRadius:BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      child: Text(
                        'Cadastrar Equipe',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 17),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                  //   child: Text('Esqueceu sua senha?',style: TextStyle(color: StandardTheme.homeColor,fontWeight: FontWeight.bold,fontSize: 15),),
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
