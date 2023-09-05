import 'dart:math';

import 'package:flutter/material.dart';
import 'package:new_pib_app/controllers/EquipeController.dart';
import 'package:new_pib_app/views/utils/utils.dart';

import '../../models/Equipe.dart';

class EquipeIndex extends StatefulWidget {
  @override
  State<EquipeIndex> createState() => _EquipeIndexState();
}

class _EquipeIndexState extends State<EquipeIndex> {
  Future<Equipe> fetchData() async {
    Equipe? equipe = await EquipeController.getEquipeAtual();
    return equipe!;
  }

  Color _randomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  // Função para criar um gradiente aleatório.
  LinearGradient _randomGradient() {
    final startColor = _randomColor();
    final endColor = _randomColor();
    return LinearGradient(
      colors: [startColor, endColor],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  String generateRandomString() {
    const String charset =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    Random random = Random();
    List<int> charCodes = List.generate(10, (index) {
      int randomIndex = random.nextInt(charset.length);
      return charset.codeUnitAt(randomIndex);
    });
    return String.fromCharCodes(charCodes);
  }

  @override
  Widget build(BuildContext context) {
    final Color endColor = const Color(0xFF0041C3); // Cor final mais forte
    final Color startColor =
        endColor.withOpacity(0.7); // Cor inicial mais suave
    String randomString = generateRandomString();

    return FutureBuilder<Equipe>(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<Equipe> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Exibe um indicador de carregamento enquanto espera.
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left:14,right: 14),
                padding: const EdgeInsets.all(14),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: StandardTheme.homeColor,
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    Container(
                        width: 130.0,
                        height: 130.0,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://robohash.org/$randomString?set=set3'),
                          ),
                        )),
                    Text(
                      snapshot.data!.nome!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            snapshot.data!.descricao!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w200),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    // ignore: prefer_const_constructors
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 14),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                '30',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              Text(
                                'Músicas',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),       Column(
                            children: [
                              Text(
                                '30',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              Text(
                                'Músicas',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),       Column(
                            children: [
                              Text(
                                '30',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              Text(
                                'Músicas',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
