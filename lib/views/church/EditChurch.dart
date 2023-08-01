import 'package:flutter/services.dart';
import 'package:new_pib_app/controllers/ChurchController.dart';
import 'package:new_pib_app/main.dart';
import 'package:new_pib_app/models/User.dart';
import 'package:new_pib_app/models/membro.dart';
import 'package:new_pib_app/views/external.dart';
import 'package:new_pib_app/views/login.dart';
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/igreja.dart';

@immutable
class EditChurch extends StatefulWidget {
  EditChurch({
    super.key,
    required this.church,
    required this.membros,
  });
  Igreja church;
  List<Member> membros;
  @override
  _EditChurchState createState() => _EditChurchState();
}

class _EditChurchState extends State<EditChurch> {
  List<Member> membros = [];
  int lider_selecionado = 0;
  late Igreja church;
  @override
  void initState() {
    membros = widget.membros;
    church = widget.church;
    nomeInput.text = church.nome!;
    telefoneInput.text = church.telefone!;
    lider_selecionado = church.idPastor!;
    super.initState();
  }

  bool isLoading = false;
  String selecionado = "event";
  final _formKey = GlobalKey<FormState>();

  TextEditingController nomeInput = new TextEditingController();
  TextEditingController telefoneInput = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // print(getIt<UserCustom>().idUser);
    return Scaffold(
      bottomNavigationBar: BottomBar(
        selecionado: selecionado,
      ),
      backgroundColor: Color(0xFF131112),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              HeaderStandard(
                title: 'Editar igreja',
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Input(
                          validate: (value) {
                            if (value == null || value == '') {
                              return 'Obrigatório!';
                            }
                            return null;
                          },
                          onTap: () {},
                          onChange: () {},
                          controller: nomeInput,
                          nome: 'Nome',
                          icon: Icons.abc,
                          password: false),
                      Input(
                          validate: (value) {
                            if (value == null || value == '') {
                              return 'Obrigatório!';
                            }
                            return null;
                          },
                          onTap: () {},
                          onChange: () {},
                          controller: telefoneInput,
                          nome: 'Telefone',
                          icon: Icons.abc,
                          password: false),
                      DropdownButtonFormField(
                        enableFeedback: true,
                        decoration: DecorationVariables.decorationInput(
                            'Selecione o lider'),
                        dropdownColor: ColorsWhiteTheme.cardColor2,
                        value: lider_selecionado,
                        padding: EdgeInsets.all(8),
                        icon: Icon(
                          Icons.arrow_downward,
                          color: Colors.grey,
                        ),
                        isExpanded: true,
                        onChanged: (value) {},
                        iconEnabledColor: ColorsWhiteTheme.cardColor2,
                        items:
                            membros.map<DropdownMenuItem<int>>((Member membro) {
                          return DropdownMenuItem<int>(
                              onTap: () {
                                setState(() {
                                  lider_selecionado = membro.id!;
                                });
                              },
                              value: membro.id,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: ColorsWhiteTheme.cardColor2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: StatefulBuilder(
                                    builder: ((context, setState) {
                                  return Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: ColorsWhiteTheme.cardColor,
                                      ),
                                      Text(
                                        membro.nome!,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  );
                                })),
                              ));
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButtonCustom(
                          onPressed: () async {
                            showDialogue(context);
                            if (_formKey.currentState!.validate()) {
                              church.nome = nomeInput.text;
                              church.telefone = telefoneInput.text;
                              church.idPastor = lider_selecionado;
                              Map<String, dynamic> response =
                                  await ChurchController.EditChurch(
                                      widget.church);
                              if (response['success']) {
                                Navigator.of(context).pop();
                              }
                              messageToUser(
                                  context,
                                  response['message'],
                                  response['success']
                                      ? Colors.green
                                      : Colors.red,
                                  response['success']
                                      ? Icons.done
                                      : Icons.dangerous);
                            }
                            hideProgressDialogue(context);

                          },
                          name: 'Atualizar',
                          color: ColorsWhiteTheme.cardColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
