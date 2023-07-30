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

class AddIntegrantes extends StatefulWidget {
  AddIntegrantes(
      {super.key, required this.integrantes, required this.idDepartament});
  List<Member> integrantes;
  int idDepartament;
  @override
  _AddIntegrantesState createState() => _AddIntegrantesState();
}

class _AddIntegrantesState extends State<AddIntegrantes> {
  bool isLoading = false;
  String selecionado = "department";
  List<Member> integrantes = [];

  @override
  void initState() {
    integrantes = widget.integrantes;
    super.initState();
  }

  updatePage() async {
    // List<Departamento> dpts = await DepartmentController.getDepartmentsOfChurch(
    //     getIt<UserCustom>().igreja_selecionada!);
    // setState(() {
    //   integrantes = dpts;
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
                title: 'Adicionar integrantes',
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Selecione os integrantes',
                  style: TextStyle(color: Colors.grey, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ColorsWhiteTheme.cardColor2,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(5),
                  itemCount: integrantes.length,
                  itemBuilder: (_, i) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.black26),
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: ColorsWhiteTheme.cardColor,
                        checkColor: Colors.black,
                        fillColor: MaterialStateProperty.all(
                            ColorsWhiteTheme.cardColor),
                        title: Text(
                          integrantes[i].nome!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        value: integrantes[i].checked,
                        onChanged: (bool? valueCheck) {
                          setState(() {
                            integrantes[i].checked = valueCheck!;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButtonCustom(
                  onPressed: () async {
                    showDialogue(context);
                    Map<String,dynamic> response = await DepartmentController.addMembers(
                        integrantes
                            .where((element) => element.checked == true)
                            .toList(),
                        widget.idDepartament);
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

                    hideProgressDialogue(context);
                  },
                  name: 'Cadastrar',
                  color: ColorsWhiteTheme.cardColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
