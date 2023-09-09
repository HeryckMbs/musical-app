import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:new_pib_app/controllers/EquipeController.dart';
import 'package:new_pib_app/main.dart';
import 'package:new_pib_app/models/Integrante.dart';
import 'package:new_pib_app/views/eventos/evento.dart';
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/Equipe.dart';

class EventoCreate extends StatefulWidget {
  @override
  State<EventoCreate> createState() => _EventoCreateState();
}

class _EventoCreateState extends State<EventoCreate> {
  TextEditingController descricao = new TextEditingController();
  TextEditingController dtInicio = new TextEditingController();
  TextEditingController nome = new TextEditingController();
  getIntegrantes() async {
    List<Integrante?> equipe =
        await EquipeController.getIntegrantesEquipeAtual();
    setState(() {
      integrantes = equipe;
    });
  }

  void setIntegrantes(int index) {
    if (!integrantesSelecionados.contains(integrantes[index]!.id)) {
      setState(() {
        integrantesSelecionados.add(integrantes[index]!.id!);
      });
    } else {
      setState(() {
        integrantesSelecionados.remove(integrantes[index]!.id!);
      });
    }
    setState(() {
      integrantes[index]!.checked =
          integrantesSelecionados.contains(integrantes[index]!.id);
    });
  }

  List<Integrante?> integrantes = [];
  List<int> integrantesSelecionados = [];
  @override
  void initState() {
    getIntegrantes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          getIt<RouterCustom>().setIndex('eventos');
        });
        getIt<RouterCustom>().notifyParent();
        return false;
      },
      child: Container(
        margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 28.0, top: 24),
              child: Input(
                nome: 'Nome',
                dark: false,
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
              padding: const EdgeInsets.only(bottom: 28.0),
              child: Input(
                nome: 'Descrição/Observação',
                onChange: (value) {},
                onTap: () {},
                dark: false,
                password: false,
                constLines: 3,
                validate: (value) {},
                icon: null,
                action: TextInputAction.next,
                controller: descricao,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 38.0),
                child: InputDate(
                  controller: dtInicio,
                  nome: 'Início em',
                  onTap: () async {
                    DateTime? dataHora =
                        await showDateTimePicker(context: context);
                    if (dataHora == null) {
                      dtInicio.text =
                          DateFormat('dd/MM/y HH:mm').format(DateTime.now());
                    } else {
                      dtInicio.text =
                          DateFormat('dd/MM/y HH:mm').format(dataHora);
                    }
                  },
                  password: false,
                  icon: null,
                )),
            integrantes.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Participantes'),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFe3e6e8),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        height: 150,
                        child: Scrollbar(
                          trackVisibility: true,
                          thumbVisibility: true,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            padding: EdgeInsets.all(5),
                            itemCount: integrantes.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setIntegrantes(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.all(5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            integrantes[index]!.nome!,
                                          ),
                                        ),
                                        Checkbox(
                                            value: integrantes[index]!.checked,
                                            onChanged: (value) {
                                              setIntegrantes(index);
                                            })
                                      ]),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
