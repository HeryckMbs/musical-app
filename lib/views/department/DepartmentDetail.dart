// ignore_for_file: use_build_context_synchronously

import 'package:flutter/services.dart';
import 'package:new_pib_app/controllers/ChurchController.dart';
import 'package:new_pib_app/controllers/DepartmentFunctionController.dart';
import 'package:new_pib_app/main.dart';
import 'package:new_pib_app/models/Departamento.dart';
import 'package:new_pib_app/models/User.dart';
import 'package:new_pib_app/models/igreja.dart';
import 'package:new_pib_app/views/church/CreateChurch.dart';
import 'package:new_pib_app/views/department/CreateDepartment.dart';
import 'package:new_pib_app/views/external.dart';
import 'package:new_pib_app/views/login.dart';
import 'package:new_pib_app/views/membros/ListMembers.dart';
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/DepartmentController.dart';
import '../../models/Funcao.dart';
import '../../models/membro.dart';
import '../department/ListDepartment.dart';
import '../homePage/home.dart';
import 'ListIntegrantesDepartment.dart';
import 'functions/ListFuntions.dart';

class DepartmentDetail extends StatefulWidget {
  DepartmentDetail({super.key, required this.departamento});
  Departamento departamento;
  @override
  _DepartmentDetailState createState() => _DepartmentDetailState();
}

class _DepartmentDetailState extends State<DepartmentDetail> {
  bool isLoading = false;
  String selecionado = "department";
  late Departamento departamento;

  @override
  void initState() {
    departamento = widget.departamento;
    super.initState();
  }

  updatePage() async {
    // List<Departamento> dpts = await DepartmentController.getDepartmentsOfChurch(
    //     getIt<UserCustom>().igreja_selecionada!);
    // setState(() {
    //   departamentos = dpts;
    // });
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
            // List<Member> membros = await ChurchController.getMembers(
            //     getIt<UserCustom>().igreja_selecionada!);
            // await Navigator.push(
            //     context,
            //     PageTransition(
            //         child: CreateDepartment(
            //           membros: membros,
            //         ),
            //         duration: const Duration(milliseconds: 200),
            //         type: PageTransitionType.fade));

            await updatePage();
            hideProgressDialogue(context);
          },
          child: const Icon(Icons.add)),
      // bottomNavigationBar: BottomBar(
      //   selecionado: selecionado,
      // ),
      backgroundColor: const Color(0xFF131112),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const HeaderStandard(title: 'Igreja'),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  departamento.nome!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 250,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ColorsWhiteTheme.cardColor2,
                    borderRadius: const BorderRadius.all(Radius.circular(40))),
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  children: [
                    InkWell(
                      onTap: () async {
                        showDialogue(context);
                        List<Member> membros = await DepartmentController.getDepartmentMembers(departamento.id!);
                        List<Funcao> funcoes = await DepartmentFunctionController.getDepartmentFunctions(departamento.id!);
                        await Navigator.push(
                            context,
                            PageTransition(
                                child: DepartmentIntegranteList(
                                  funcoes: funcoes,
                                  membros: membros,
                                  idDepartament: departamento.id!,
                                ),
                                duration: const Duration(milliseconds: 200),
                                type: PageTransitionType.fade));

                        hideProgressDialogue(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 2))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.people_alt,
                                      color: ColorsWhiteTheme.cardColor,
                                    ),
                                  ),
                                  const Text(
                                    'Integrantes',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: ColorsWhiteTheme.cardColor,
                              )
                            ]),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        showDialogue(context);
                        List<Member> membros =
                            await ChurchController.getMembers(
                                getIt<UserCustom>().igreja_selecionada!);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(color: Colors.black, width: 2),
                        )),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.today,
                                      color: ColorsWhiteTheme.cardColor,
                                    ),
                                  ),
                                  const Text(
                                    'Eventos',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: ColorsWhiteTheme.cardColor,
                              )
                            ]),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 2))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.notifications_active_outlined,
                                    color: ColorsWhiteTheme.cardColor,
                                  ),
                                ),
                                const Text(
                                  'Avisos para a igreja',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: ColorsWhiteTheme.cardColor,
                            )
                          ]),
                    ),
                    InkWell(
                      onTap: () async {
                        showDialogue(context);
                        List<Funcao> funcoes =
                            await DepartmentFunctionController
                                .getDepartmentFunctions(
                                    widget.departamento.id!);
                        await Navigator.push(
                            context,
                            PageTransition(
                                child: FunctionsList(
                                  funcoes: funcoes,
                                  idDepartament: widget.departamento.id!,
                                ),
                                duration: const Duration(milliseconds: 200),
                                type: PageTransitionType.fade));

                        hideProgressDialogue(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 2))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.list_alt,
                                      color: ColorsWhiteTheme.cardColor,
                                    ),
                                  ),
                                  const Text(
                                    'Funções',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: ColorsWhiteTheme.cardColor,
                              )
                            ]),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(2),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.calendar_month_outlined,
                                    color: ColorsWhiteTheme.cardColor,
                                  ),
                                ),
                                const Text(
                                  'Cultos',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: ColorsWhiteTheme.cardColor,
                            )
                          ]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
