// ignore_for_file: use_build_context_synchronously

import 'package:flutter/services.dart';
import 'package:new_pib_app/controllers/ChurchController.dart';
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
import '../../models/membro.dart';
import '../department/ListDepartment.dart';
import '../homePage/home.dart';

class DetailIgreja extends StatefulWidget {
  DetailIgreja({super.key, required this.igreja});
  Igreja igreja;
  @override
  _DetailIgrejaState createState() => _DetailIgrejaState();
}

class _DetailIgrejaState extends State<DetailIgreja> {
  bool isLoading = false;
  String selecionado = "department";
  late Igreja igreja;

  @override
  void initState() {
    igreja = widget.igreja;
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
                padding: const EdgeInsets.all(10),
                child: Text(
                  igreja.nome!,
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
                        List<Departamento> departamentos =
                            await DepartmentController.getDepartmentsOfChurch(
                                getIt<UserCustom>().igreja_selecionada!);

                        // List<Member> membros = await ChurchController.getMembers(
                        //     getIt<UserCustom>().igreja_selecionada!);
                        await Navigator.push(
                            context,
                            PageTransition(
                                child: DepartmentList(
                                    departamentos: departamentos),
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
                                      Icons.folder_shared_sharp,
                                      color: ColorsWhiteTheme.cardColor,
                                    ),
                                  ),
                                  const Text(
                                    'Departamentos',
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
                      onTap: () async{
                        showDialogue(context);
                                                                        List<Member> membros =
                            await ChurchController.getMembers(
                                getIt<UserCustom>().igreja_selecionada!);

                        await Navigator.push(
                            context,
                            PageTransition(
                                child: MemberList(membros: membros),
                                duration: const Duration(milliseconds: 200),
                                type: PageTransitionType.fade));
                                hideProgressDialogue(context);
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
                                      Icons.people_alt,
                                      color: ColorsWhiteTheme.cardColor,
                                    ),
                                  ),
                                  const Text(
                                    'Membros',
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
                                    Icons.track_changes_sharp,
                                    color: ColorsWhiteTheme.cardColor,
                                  ),
                                ),
                                const Text(
                                  'Campanhas',
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
                                    Icons.list_alt,
                                    color: ColorsWhiteTheme.cardColor,
                                  ),
                                ),
                                const Text(
                                  'Pedidos de oração',
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
