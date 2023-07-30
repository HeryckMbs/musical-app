// ignore_for_file: use_build_context_synchronously

import 'package:flutter/services.dart';
import 'package:new_pib_app/controllers/DepartmentIntegranteController.dart';
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../controllers/DepartmentController.dart';
import '../../models/Funcao.dart';
import '../../models/membro.dart';
import 'AddIntegrantes.dart';

// ignore: must_be_immutable
class DepartmentIntegranteList extends StatefulWidget {
  DepartmentIntegranteList(
      {super.key,
      required this.membros,
      required this.idDepartament,
      required this.funcoes});
  List<Member> membros;
  List<Funcao> funcoes;
  int idDepartament;

  @override
  _DepartmentIntegranteListState createState() =>
      _DepartmentIntegranteListState();
}

class _DepartmentIntegranteListState extends State<DepartmentIntegranteList> {
  bool isLoading = false;
  String selecionado = "department";
  List<Member> membros = [];
  List<Funcao> funcoes = [];

  @override
  void initState() {
    membros = widget.membros;
    funcoes = widget.funcoes;
    super.initState();
  }

  updatePage() async {
    List<Member> members =
        await DepartmentController.getDepartmentMembers(widget.idDepartament);
    setState(() {
      membros = members;
    });
  }

  final _formKey = GlobalKey<FormState>();
  Future modalFuncao(Member membro) {
    int idFuncaoSelecionada = funcoes.first.id!;
    return showDialog(
      context: context,
      builder: (contextDialog) {
        return AlertDialog(
          backgroundColor: ColorsWhiteTheme.cardColor2,
          title: Text(
            'Atribuir função para ${membro.nome}',
            style: TextStyle(
                color: Colors.grey,
                overflow: TextOverflow.ellipsis,
                fontSize: 16),
          ),
          content: Form(
            key: _formKey,
            child: SizedBox(
              child: DropdownButtonFormField(
                enableFeedback: true,
                decoration: DecorationVariables.decorationInput('Função'),
                dropdownColor: ColorsWhiteTheme.cardColor2,
                value: idFuncaoSelecionada,
                padding: EdgeInsets.all(8),
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.grey,
                ),
                isExpanded: true,
                onChanged: (value) {},
                iconEnabledColor: ColorsWhiteTheme.cardColor2,
                isDense: true,
                style: TextStyle(overflow: TextOverflow.ellipsis),
                items: funcoes.map<DropdownMenuItem<int>>((Funcao funcao) {
                  return DropdownMenuItem<int>(
                      onTap: () {
                        setState(() {
                          idFuncaoSelecionada = funcao.id!;
                        });
                      },
                      value: funcao.id,
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorsWhiteTheme.cardColor2,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: StatefulBuilder(builder: ((context, setState) {
                          return Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: ColorsWhiteTheme.cardColor,
                              ),
                              Expanded(
                                child: Text(
                                  funcao.nome!,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ],
                          );
                        })),
                      ));
                }).toList(),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(contextDialog).textTheme.labelLarge,
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(contextDialog).textTheme.labelLarge,
              ),
              child: Text(
                'Criar',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () async {
                showDialogue(context);
                if (_formKey.currentState!.validate()) {
                  Map<String, dynamic> response =
                      await DepartmentIntegranteController
                          .updateFunctionOfMember(
                              membro.id!, membro.pivot!.idDepartamento!,idFuncaoSelecionada);
                  Navigator.of(context).pop();
                  hideProgressDialogue(context);
                  messageToUser(
                      context,
                      response['message'],
                      response['success'] ? Colors.green : Colors.red,
                      response['success'] ? Icons.done : Icons.dangerous);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(
        selecionado: selecionado,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: ColorsWhiteTheme.cardColor,
          onPressed: () async {
            showDialogue(context);
            List<Member> membros =
                await DepartmentController.getMembersWithoutDeparment(
                    widget.idDepartament);
            await Navigator.push(
                context,
                PageTransition(
                    child: AddIntegrantes(
                      integrantes: membros,
                      idDepartament: widget.idDepartament,
                    ),
                    duration: const Duration(milliseconds: 200),
                    type: PageTransitionType.fade));

            await updatePage();
            hideProgressDialogue(context);
          },
          child: const Icon(Icons.add)),
      // bottomNavigationBar: BottomBar(
      //   selecionado: selecionado,
      // ),
      backgroundColor: Color(0xFF131112),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              HeaderStandard(
                title: 'Membros',
              ),
              Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ColorsWhiteTheme.cardColor2,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: ListView.builder(
                  itemCount: membros.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                          // Departamento departamento = await DepartmentController.getDepartment(departamentos[index].id!);
                          // await Navigator.push(
                          //     context,
                          //     PageTransition(
                          //         child: DepartmentDetail(departamento: departamento,),
                          //         type: PageTransitionType.fade));
                        },
                        child: WideCard(
                          title: membros[index].nome!,
                          description: membros[index].functions!.isNotEmpty
                              ? membros[index].functions!.first.nome!
                              : 'Sem função',
                          icon: Icons.groups_rounded,
                          actions: [
                            Container(
                              child: PopupMenuButton(
                                constraints: BoxConstraints.tight(Size(
                                    MediaQuery.of(context).size.width,
                                    MediaQuery.of(context).size.height * 0.3)),
                                color: ColorsWhiteTheme.cardColor2,
                                tooltip: 'Opções',
                                icon: Icon(
                                  Icons.menu,
                                  color: ColorsWhiteTheme.cardColor,
                                ),
                                onSelected: (item) async {
                                  await item();
                                },
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem<Function>(
                                    enabled: false,
                                    value: () async {},
                                    child: Row(
                                      children: [
                                        Text(
                                          'Alterando: ',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' ${membros[index].nome!}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem<Function>(
                                    value: () async {
                                      await modalFuncao(membros[index]);
                                      await updatePage();
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black,
                                                  width: 2))),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.badge,
                                              color: ColorsWhiteTheme.cardColor,
                                            ),
                                          ),
                                          Text(
                                            'Atribuir função',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem<Function>(
                                    value: () async {
                                      showDialogue(context);
                                        Map<String, dynamic> response =
                                            await DepartmentIntegranteController
                                                .updateFunctionOfMember(
                                                    membros[index].id!,membros[index].pivot!.idDepartamento!,
                                                    null);
                                                    await updatePage();
                                        hideProgressDialogue(context);
                                        messageToUser(
                                            context,
                                            response['message'],
                                            response['success']
                                                ? Colors.green
                                                : Colors.red,
                                            response['success']
                                                ? Icons.done
                                                : Icons.dangerous);
                                      
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black,
                                                  width: 2))),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.dangerous,
                                              color: ColorsWhiteTheme.cardColor,
                                            ),
                                          ),
                                          Text(
                                            'Excluir função atual de ${membros[index].nome}',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem<Function>(
                                    value: () async {
                                                                            showDialogue(context);
                                        Map<String, dynamic> response =
                                            await DepartmentIntegranteController
                                                .deleteMemberOfDepartment(membros[index].pivot!.id_membro!,membros[index].pivot!.idDepartamento!);
                                                    await updatePage();
                                        hideProgressDialogue(context);
                                        messageToUser(
                                            context,
                                            response['message'],
                                            response['success']
                                                ? Colors.green
                                                : Colors.red,
                                            response['success']
                                                ? Icons.done
                                                : Icons.dangerous);
                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.delete_forever,
                                              color: Colors.red,
                                            ),
                                          ),
                                          Text(
                                            'Excluir ${membros[index].nome} do departamento',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
