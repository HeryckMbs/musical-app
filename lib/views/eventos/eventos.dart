import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_pib_app/controllers/EquipeController.dart';
import 'package:new_pib_app/main.dart';
import 'package:new_pib_app/views/eventos/evento.dart';
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/Equipe.dart';

class EventosList extends StatefulWidget {
  @override
  State<EventosList> createState() => _EventosListState();
}

class _EventosListState extends State<EventosList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: StandardTheme.homeColor,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              padding: EdgeInsets.all(7),
              child: Text(
                'Agosto - 2023',
                style: TextStyle(fontSize: 19, color: Colors.white),
              )),
          SizedBox(
            height: 80,
            child: ListView(
                children: [
                  DayOfCalendar(day: '10', firstLetter: 'S'),
                  DayOfCalendar(day: '11', firstLetter: 'T'),
                  DayOfCalendar(day: '12', firstLetter: 'Q'),
                  DayOfCalendar(day: '13', firstLetter: 'Q'),
                  DayOfCalendar(day: '14', firstLetter: 'S'),
                  DayOfCalendar(day: '15', firstLetter: 'S'),
                  DayOfCalendar(day: '16', firstLetter: 'D'),
                ],
                shrinkWrap: true,
                physics: ScrollPhysics(),
                scrollDirection: Axis.horizontal),
          ),
          InkWell(
            onTap: () {
              getIt<RouterCustom>().setIndex('createEvento');
              getIt<RouterCustom>().notifyParent();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: StandardTheme.homeColor,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Text(
                  'Adicionar evento',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ]),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  getIt<RouterCustom>().setEvento(index);
                  getIt<RouterCustom>().notifyParent();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  height: 125,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Cor da sombra
                        spreadRadius: 4, // Espalhamento da sombra
                        blurRadius: 8, // Desfoque da sombra
                        offset: Offset(0, 3), // Deslocamento da sombra
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 12,
                        decoration: BoxDecoration(
                            color: StandardTheme.homeColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.89,
                        height: 125,
                        decoration: BoxDecoration(
                            color: Color(0xFFe3e6e8),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.25,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '20',
                                    style: TextStyle(
                                        color: StandardTheme.homeColor,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    Traducao.diasSemana[6],
                                    style: TextStyle(
                                        color: StandardTheme.homeColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '18:30',
                                    style: TextStyle(
                                        color: StandardTheme.homeColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'BAR DO CHICÃO',
                                          style: TextStyle(
                                              color: StandardTheme.homeColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          'Avenida mangalo qd 145 bar do chicao na esquina do semaforo',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                        )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DayOfCalendar extends StatelessWidget {
  DayOfCalendar({
    super.key,
    required this.firstLetter,
    required this.day,
  });

  String firstLetter;
  String day;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: StandardTheme.homeColor,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            firstLetter,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            day,
            style: TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
