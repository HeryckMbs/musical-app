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
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/DepartmentController.dart';
import '../../models/membro.dart';
import '../homePage/home.dart';

class MemberList extends StatefulWidget {
  MemberList({super.key, required this.membros});
  List<Member> membros;
  @override
  _MemberListState createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  bool isLoading = false;
  String selecionado = "department";
    List<Member> membros = [];

  @override
  void initState() {
    membros = widget.membros;
    super.initState();
  }

  updatePage() async {
    // List<Departamento> dpts = await DepartmentController.getDepartmentsOfChurch(
    //     getIt<UserCustom>().igreja_selecionada!);
    // setState(() {
    //   membros = dpts;
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

                        },
                        child: WideCard(
                          title: membros[index].nome!,
                          description: membros[index].nome!,
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
