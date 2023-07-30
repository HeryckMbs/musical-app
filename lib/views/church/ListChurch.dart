import 'package:flutter/services.dart';
import 'package:new_pib_app/controllers/ChurchController.dart';
import 'package:new_pib_app/main.dart';
import 'package:new_pib_app/models/User.dart';
import 'package:new_pib_app/models/igreja.dart';
import 'package:new_pib_app/views/church/CreateChurch.dart';
import 'package:new_pib_app/views/external.dart';
import 'package:new_pib_app/views/login.dart';
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homePage/home.dart';

class ChurchList extends StatefulWidget {
  ChurchList({super.key, required this.churchs});
  List<Igreja> churchs;
  @override
  _ChurchListState createState() => _ChurchListState();
}

class _ChurchListState extends State<ChurchList> {
  bool isLoading = false;
  String selecionado = "department";
  List<Igreja> churchs = [];

  @override
  void initState() {
    churchs = widget.churchs;
    super.initState();
  }

  updatePage() async {
    List<Igreja> churchsUpdated = await ChurchController.getChurchs();
    setState(() {
      churchs = churchsUpdated;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ColorsWhiteTheme.cardColor,
          onPressed: () async {
            showDialogue(context);
            await Navigator.push(
                context,
                PageTransition(
                    child: CreateChurch(
                      churchs: churchs,
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
                title: 'Selecione sua igreja',
              ),
              Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                color: ColorsWhiteTheme.cardColor2,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: ListView.builder(
                  itemCount: churchs.length,
                                    padding: EdgeInsets.all(0),

                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                          getIt<UserCustom>().setIgrejaSelecionada(churchs[index].id!);
                          await Navigator.push(
                              context,
                              PageTransition(
                                  child: Home(),
                                  type: PageTransitionType.fade));
                        },
                        child: WideCard(
                          title: churchs[index].nome!,
                          description: churchs[index].telefone!,
                          icon: Icons.church_outlined,
                          actions: [InkWell(child: Icon(Icons.arrow_forward,color: ColorsWhiteTheme.cardColor,),)],
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
