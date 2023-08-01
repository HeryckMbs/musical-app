import 'package:flutter/services.dart';
import 'package:new_pib_app/controllers/DepartmentController.dart';

import 'package:new_pib_app/views/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../models/Departamento.dart';
import '../../models/membro.dart';

@immutable
class EditDepartament extends StatefulWidget {
  EditDepartament({super.key, required this.membros, required this.departamento});
  List<Member> membros;
  Departamento departamento;
  @override
  _EditDepartamentState createState() => _EditDepartamentState();
}

class _EditDepartamentState extends State<EditDepartament> {
  bool isLoading = false;
  String selecionado = "department";
  final _formKey = GlobalKey<FormState>();
  List<Member> membros = [];
  late Departamento departamento;
  int lider_selecionado = 0;
  TextEditingController nome = new TextEditingController();
  TextEditingController descricao = new TextEditingController();
  TextEditingController objetivo = new TextEditingController();

  @override
  void initState() {
    membros = widget.membros;
    departamento = widget.departamento;
    nome.text = departamento.nome!;
    objetivo.text= departamento.objetivo!;
    descricao.text = departamento.descricao!;
    isLouvor = departamento.louvor == 1;
    lider_selecionado = departamento.idLider!;
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
                title: 'Editar Departamento',
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Input(
                          validate: (value) {
                            // if (value == null || value == '') {
                            //   return 'Obrigatório!';
                            // }
                            // return null;
                          },
                          onTap: () {},
                          onChange: () {},
                          controller: nome,
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
                          controller: descricao,
                          constLines: 3,
                          nome: 'Descrição',
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
                          controller: objetivo,
                          constLines: 3,
                          nome: 'Objetivo',
                          icon: Icons.abc,
                          password: false),
                           DropdownButtonFormField(
                        enableFeedback: true,
                        decoration: DecorationVariables.decorationInput('Selecione o lider'),
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
                     
                      CheckboxListTile(
                        title: Text("É ministério de louvor?",style: TextStyle(color: Colors.grey),),
                        activeColor: ColorsWhiteTheme.cardColor,
                        checkColor: Colors.black,
                        subtitle: Text('Clique aqui!',style:TextStyle(color: Colors.grey)),
                        fillColor: MaterialStateProperty.all(ColorsWhiteTheme.cardColor),
                        value: isLouvor,
                        onChanged: (newValue) {
                          setState(() {
                            isLouvor = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButtonCustom(
                          onPressed: () async {
                            showDialogue(context);
                            if (_formKey.currentState!.validate()) {
                              departamento.nome= nome.text;
                              departamento.descricao = descricao.text;
                              departamento.objetivo = objetivo.text;
                              departamento.idLider = lider_selecionado;
                              departamento.louvor = isLouvor ? 1: 0;
                              // Map<String, dynamic> response =
                                 Map<String,dynamic> response = await DepartmentController.EditDepartament(departamento);
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
