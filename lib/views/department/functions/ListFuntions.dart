import 'package:flutter/services.dart';
import 'package:new_pib_app/controllers/DepartmentFunctionController.dart';
import 'package:new_pib_app/models/Funcao.dart';
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:flutter/material.dart';

class FunctionsList extends StatefulWidget {
  FunctionsList(
      {super.key, required this.funcoes, required this.idDepartament});
  List<Funcao> funcoes;
  int idDepartament;
  @override
  _FunctionsListState createState() => _FunctionsListState();
}

class _FunctionsListState extends State<FunctionsList> {
  bool isLoading = false;
  String selecionado = "department";
  List<Funcao> funcoes = [];

  @override
  void initState() {
    funcoes = widget.funcoes;
    super.initState();
  }

  TextEditingController nomeFuncao = new TextEditingController();
  TextEditingController descricao = new TextEditingController();
  updatePage() async {
    List<Funcao> funcoesUpdated =
        await DepartmentFunctionController.getDepartmentFunctions(
            widget.idDepartament);
    setState(() {
      funcoes = funcoesUpdated;
    });
  }

  final _formKey = GlobalKey<FormState>();
  Future modalFuncao(Funcao? funcao) {
    return showDialog(
      context: context,
      builder: (contextDialog) {
        return AlertDialog(
          backgroundColor: ColorsWhiteTheme.cardColor2,
          title: const Text(
            'Criar nova função',
            style: TextStyle(color: Colors.grey),
          ),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                    controller: nomeFuncao,
                    icon: Icons.abc,
                    nome: 'Nome da função',
                    password: false,
                  ),
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
                    icon: Icons.abc,
                    nome: 'Descrição',
                    password: false,
                    constLines: 3,
                  ),
                ],
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
                if (_formKey.currentState!.validate()) {
                  showDialogue(context);
                  Map<String, dynamic> response = {};
                  if (funcao != null) {
                    response = await DepartmentFunctionController.updateFuncao(
                        funcao.id!, nomeFuncao.text, descricao.text);
                  } else {
                    response =
                        await DepartmentFunctionController.createFunction(
                            nomeFuncao.text,
                            descricao.text,
                            widget.idDepartament);
                  }
                  if (response['success']) {
                    nomeFuncao.clear();
                    descricao.clear();
                    Navigator.of(context).pop();
                  }
                  hideProgressDialogue(context);
                  // ignore: use_build_context_synchronously
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
            await modalFuncao(null);
            await updatePage();
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
                title: 'Departamentos',
              ),
              Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.only(left:10,right: 10, top: 10, bottom: MediaQuery.of(context).size.height * 0.1),
                decoration: BoxDecoration(
                    color: ColorsWhiteTheme.cardColor2,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: ListView.builder(
                  itemCount: funcoes.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom:20),
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {},
                        child: WideCard(
                          title: funcoes[index].nome!,
                          description: funcoes[index].descricao!,
                          icon: Icons.groups_rounded,
                          actions: [
                            Container(
                              child: PopupMenuButton(
                                constraints: BoxConstraints.tight(Size(
                                    MediaQuery.of(context).size.width,
                                    MediaQuery.of(context).size.height * 0.2)),
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
                                        Expanded(
                                          child: Text(
                                            ' ${funcoes[index].nome!}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem<Function>(
                                    value: () async {
                                      nomeFuncao.text = funcoes[index].nome!;
                                      descricao.text =
                                          funcoes[index].descricao!;
                                      await modalFuncao(funcoes[index]);
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
                                            'Editar',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem<Function>(
                                    value: () async {
                                      Map<String, dynamic> response = {};

                                      response =
                                          await DepartmentFunctionController
                                              .deleteFuncao(funcoes[index].id!);

                                     await updatePage();
                                      // ignore: use_build_context_synchronously
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
                                              Icons.dangerous,
                                              color: ColorsWhiteTheme.cardColor,
                                            ),
                                          ),
                                          Text(
                                            'Excluir',
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
