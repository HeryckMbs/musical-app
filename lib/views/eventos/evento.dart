import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_pib_app/controllers/EquipeController.dart';
import 'package:new_pib_app/main.dart';
import 'package:new_pib_app/views/utils/utils.dart';

import '../../models/Equipe.dart';

class EventoIndex extends StatefulWidget {
  EventoIndex({
    required this.idEvento,
  });
  int idEvento;

  @override
  State<EventoIndex> createState() => _EventoIndexState();
}

class _EventoIndexState extends State<EventoIndex> {
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
          child: Text(widget.idEvento.toString())),
    );
  }
}
