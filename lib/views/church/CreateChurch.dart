import 'package:flutter/services.dart';
import 'package:new_pib_app/controllers/ChurchController.dart';
import 'package:new_pib_app/main.dart';
import 'package:new_pib_app/models/User.dart';
import 'package:new_pib_app/views/external.dart';
import 'package:new_pib_app/views/login.dart';
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/igreja.dart';

@immutable
class CreateChurch extends StatefulWidget {
  CreateChurch({super.key, required this.churchs});
  List<Igreja> churchs;
  @override
  _CreateChurchState createState() => _CreateChurchState();
}

class _CreateChurchState extends State<CreateChurch> {
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
                title: 'Criar Igreja',
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButtonCustom(
                          onPressed: () async {
                            showDialogue(context);
                            if (_formKey.currentState!.validate()) {
                              Map<String, dynamic> response =
                                  await ChurchController.createChurch(
                                      nomeInput.text, telefoneInput.text);
                              if (response['success']) {
                                Navigator.of(context).pop();
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  elevation: 2000,
                                  content: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4),
                                      child: Icon(
                                        response['success']
                                            ? Icons.done
                                            : Icons.dangerous,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(response['message']),
                                    )
                                  ]),
                                  backgroundColor: response['success']
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              );
                            }
                            hideProgressDialogue(context);
                          },
                          name: 'Cadastrar',
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
