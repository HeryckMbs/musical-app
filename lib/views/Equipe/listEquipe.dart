import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_pib_app/controllers/UserController.dart';
import 'package:new_pib_app/views/Equipe/cadastroEquipe.dart';
import 'package:page_transition/page_transition.dart';

import '../../main.dart';
import '../../models/Equipe.dart';
import '../../models/sessao.dart';
import '../home/home.dart';
import '../utils/utils.dart';

class ListEquipe extends StatefulWidget {
  ListEquipe({super.key, required this.equipes});

  List<Equipe> equipes;

  @override
  State<ListEquipe> createState() => _ListEquipeState();
}

class _ListEquipeState extends State<ListEquipe> {
  @override
  void dispose() {
    // Limpa os controladores quando o widget for descartado

    super.dispose();
  }

  List<Equipe> equipes = [];

  @override
  void initState() {
    equipes = widget.equipes;
    super.initState();
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
            // actions: [],
            backgroundColor: StandardTheme.homeColor),
        backgroundColor: StandardTheme.homeColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Escolha sua equipe',style: TextStyle(fontSize: 32,color: Colors.white,),),
              ListView.builder(
                itemCount: equipes.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      getIt<Sessao>().setEquipe(equipes[index].id!);
                      Navigator.push(context, PageTransition(child: Home(), type: PageTransitionType.fade));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween
                        ,
                        children: [
                          Text(equipes[index].nome!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Icon(Icons.arrow_forward,color: StandardTheme.homeColor,size: 28,)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
