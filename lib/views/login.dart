import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_pib_app/controllers/UserController.dart';
import 'package:new_pib_app/views/Equipe/EscolhaEquipe.dart';
import 'package:page_transition/page_transition.dart';

import 'utils/utils.dart';

class Login extends StatefulWidget {
  Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = new TextEditingController();
  TextEditingController senha = new TextEditingController();
  @override
  void dispose() {
    // Limpa os controladores quando o widget for descartado
    email.dispose();
    senha.dispose();
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
                    'Login',
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
                    'Seja bem vindo de volta!',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'É sempre bom ter você aqui! ',
                  ),
                  // InputElement(type: )
                Padding(
                  padding: const EdgeInsets.only(bottom: 28.0,top: 24),
                    child: Input(
                      nome: 'E-mail',
                      onChange: (value) {},
                      onTap: () {},
                      password: false,
                      validate: (value) {},
                      icon: null,
                      action: TextInputAction.next,
                      controller: email,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 38.0),
                    child: Input(
                      onTap: () {},
                      validate: (value) {},
                      action: TextInputAction.done,
                      onChange: (value) {


                      },
                      controller: senha,
                      icon: Icons.password,
                      nome: 'Senha',
                      password: true,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async{
                      if(email.text.isEmpty && senha.text.isEmpty ){
                        messageToUser(context, 'Todos os campos são obrigatórios', Colors.red, Icons.dangerous);
                      }else{
                        bool result = await UserController.login(email.text, senha.text);
                        if(result){
                          Navigator.of(context).push(PageTransition(child: EscolhaEquipe(),type: PageTransitionType.fade));
                        }
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(color: email.text.isEmpty && senha.text.isEmpty ? StandardTheme.disabledPrimary : StandardTheme.homeColor,borderRadius:BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      child: Text(
                        'Login',
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
