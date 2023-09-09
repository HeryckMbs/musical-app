import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          return Container(

            margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: StandardTheme.homeColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
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
                                  'https://robohash.org/${snapshot.data!.codigo}?set=set3'),
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
                        child:  Row(
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
                            ),
                            Column(
                              children: [
                                Text(
                                  '6',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                Text(
                                  'Membros',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '300',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                Text(
                                  'Eventos',
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
                Container(
                  padding: const EdgeInsets.all(14),
                  margin: const EdgeInsets.only(top: 14),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: StandardTheme.homeColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Text(
                        'Código da equipe: ' + snapshot.data!.codigo!,
                        style: TextStyle(color: Colors.white),
                      )),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                      text: snapshot.data!.codigo!))
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Código copiado para área de transferencia")));
                              });
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.content_copy,
                                  color: Colors.white,
                                )),
                          ),
                          Container(
                              child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 14,
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [

                      Card(title: 'Integrantes',fontSize: 17,iconSize: 40,fontColor: Colors.white,iconColor: Colors.white,icon: Icons.group,),
                      Card(title: 'Comunicados',fontSize: 17,iconSize: 40,fontColor: Colors.white,iconColor: Colors.white,icon: Icons.info,),
                      Card(title: 'Atribuições',fontSize: 17,iconSize: 40,fontColor: Colors.white,iconColor: Colors.white,icon: Icons.book,),
                      Card(title: 'Pedidos de Música',fontSize: 17,iconSize: 40,fontColor: Colors.white,iconColor: Colors.white,icon: Icons.emoji_people,),


                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

class Card extends StatelessWidget {
   Card({
    super.key,
    required this.iconSize,
    required this.fontSize,
     required this.title,
    required this.fontColor,
    required this.icon,
    required this.iconColor
  });
double iconSize;
double fontSize;
String title;
IconData icon;
Color iconColor;
Color fontColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
     color: StandardTheme.homeColor,
          border: Border.all(color: Colors.white),
          borderRadius:
              BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
          Text(title,style: TextStyle(fontSize: fontSize,color: fontColor),textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
