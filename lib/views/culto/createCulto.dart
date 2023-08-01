import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:new_pib_app/controllers/DepartmentController.dart';

import 'package:new_pib_app/views/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../models/membro.dart';

@immutable
class CreateCulto extends StatefulWidget {
  CreateCulto({
    super.key,
  });
  @override
  _CreateCultoState createState() => _CreateCultoState();
}

class _CreateCultoState extends State<CreateCulto> {
  bool isLoading = false;
  String selecionado = "department";
  final _formKey = GlobalKey<FormState>();
  int lider_selecionado = 0;
  TextEditingController nome = new TextEditingController();
  TextEditingController descricao = new TextEditingController();
  TextEditingController objetivo = new TextEditingController();
  TextEditingController dtInicio = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  updatePage() {}
  bool isLouvor = true;

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
                title: 'Criar culto',
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
                          controller: nome,
                          nome: 'Nome',
                          icon: Icons.abc,
                          password: false),
                      InputDate(
                          controller: dtInicio,
                          nome: 'Descrição',
                          icon: Icons.date_range,
                          password: false,
                          onTap: () async {
                            DateTime? dataHora =
                                await showDateTimePicker(context: context);
                            if (dataHora == null) {
                              dtInicio.text = DateFormat('dd/MM/y HH:mm')
                                  .format(DateTime.now());
                            } else {
                              dtInicio.text =
                                  DateFormat('dd/MM/y HH:mm').format(dataHora);
                            }

                            //set foratted date to TextField value.
                          }),
                      Input(
                          validate: (value) {
                            if (value == null || value == '') {
                              return 'Obrigatório!';
                            }
                            return null;
                          },
                          onTap: () {},
                          onChange: () {},
                          controller: objetivo,
                          constLines: 3,
                          nome: 'Descrição',
                          icon: Icons.abc,
                          password: false),
                      //      DropdownButtonFormField(
                      //   enableFeedback: true,
                      //   decoration: DecorationVariables.decorationInput('Selecione o lider'),
                      //   dropdownColor: ColorsWhiteTheme.cardColor2,
                      //   value: lider_selecionado,
                      //   padding: EdgeInsets.all(8),
                      //   icon: Icon(
                      //     Icons.arrow_downward,
                      //     color: Colors.grey,
                      //   ),
                      //   isExpanded: true,
                      //   onChanged: (value) {},
                      //   iconEnabledColor: ColorsWhiteTheme.cardColor2,
                      //   items:
                      //       membros.map<DropdownMenuItem<int>>((Member membro) {
                      //     return DropdownMenuItem<int>(
                      //         onTap: () {
                      //           setState(() {
                      //             lider_selecionado = membro.id!;
                      //           });
                      //         },
                      //         value: membro.id,
                      //         child: Container(
                      //           width: MediaQuery.of(context).size.width,
                      //           decoration: BoxDecoration(
                      //               color: ColorsWhiteTheme.cardColor2,
                      //               borderRadius:
                      //                   BorderRadius.all(Radius.circular(20))),
                      //           child: StatefulBuilder(
                      //               builder: ((context, setState) {
                      //             return Row(
                      //               children: [
                      //                 Icon(
                      //                   Icons.person,
                      //                   color: ColorsWhiteTheme.cardColor,
                      //                 ),
                      //                 Text(
                      //                   membro.nome!,
                      //                   style: TextStyle(color: Colors.grey),
                      //                 ),
                      //               ],
                      //             );
                      //           })),
                      //         ));
                      //   }).toList(),
                      // ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButtonCustom(
                          onPressed: () async {
                            showDialogue(context);
                            if (_formKey.currentState!.validate()) {
                              // Map<String, dynamic> response =
                              //     await DepartmentController.CreateCulto(
                              //         nome.text,
                              //         descricao.text,
                              //         objetivo.text,
                              //         lider_selecionado,
                              //         isLouvor
                              //         );
                              // if (response['success']) {
                              //   Navigator.of(context).pop();
                              // }
                              // messageToUser(
                              //     context,
                              //     response['message'],
                              //     response['success']
                              //         ? Colors.green
                              //         : Colors.red,
                              //     response['success']
                              //         ? Icons.done
                              //         : Icons.dangerous);
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
