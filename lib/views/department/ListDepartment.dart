import 'package:flutter/services.dart';
import 'package:new_pib_app/controllers/ChurchController.dart';
import 'package:new_pib_app/main.dart';
import 'package:new_pib_app/models/Departamento.dart';
import 'package:new_pib_app/models/User.dart';
import 'package:new_pib_app/models/igreja.dart';
import 'package:new_pib_app/views/church/CreateChurch.dart';
import 'package:new_pib_app/views/department/CreateDepartment.dart';
import 'package:new_pib_app/views/department/DepartmentDetail.dart';
import 'package:new_pib_app/views/external.dart';
import 'package:new_pib_app/views/login.dart';
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/DepartmentController.dart';
import '../../models/membro.dart';
import '../homePage/home.dart';

class DepartmentList extends StatefulWidget {
  DepartmentList({super.key, required this.departamentos});
  List<Departamento> departamentos;
  @override
  _DepartmentListState createState() => _DepartmentListState();
}

class _DepartmentListState extends State<DepartmentList> {
  bool isLoading = false;
  String selecionado = "department";
  List<Departamento> departamentos = [];

  @override
  void initState() {
    departamentos = widget.departamentos;
    super.initState();
  }

  updatePage() async {
    List<Departamento> dpts = await DepartmentController.getDepartmentsOfChurch(
        getIt<UserCustom>().igreja_selecionada!);
    setState(() {
      departamentos = dpts;
    });
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
            List<Member> membros = await ChurchController.getMembers(
                getIt<UserCustom>().igreja_selecionada!);
            await Navigator.push(
                context,
                PageTransition(
                    child: CreateDepartment(
                      membros: membros,
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
                title: 'Departamentos',
              ),
              Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ColorsWhiteTheme.cardColor2,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: ListView.builder(
                  itemCount: departamentos.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                          Departamento departamento = await DepartmentController.getDepartment(departamentos[index].id!);
                          await Navigator.push(
                              context,
                              PageTransition(
                                  child: DepartmentDetail(departamento: departamento,),
                                  type: PageTransitionType.fade));
                        },
                        child: WideCard(
                          title: departamentos[index].nome!,
                          description: departamentos[index].descricao!,
                          icon: Icons.groups_rounded,
                          actions: [
                            InkWell(
                              child: Icon(
                                Icons.arrow_forward,
                                color: ColorsWhiteTheme.cardColor,
                              ),
                            )
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
