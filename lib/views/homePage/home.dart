import 'package:flutter/services.dart';
import 'package:new_pib_app/main.dart';
import 'package:new_pib_app/models/User.dart';
import 'package:new_pib_app/views/login.dart';
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Home extends StatefulWidget {
  Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  String selecionado = "event";


  @override
  Widget build(BuildContext context) {
    print(getIt<UserCustom>().idUser);
    return Scaffold(
      bottomNavigationBar: BottomBar(
        selecionado: selecionado,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
            await      prefs.remove('access_token');

      Navigator.pushReplacement(context, PageTransition(child: Login(), type: PageTransitionType.fade));

      },child: Icon(Icons.logout)),
      backgroundColor: Color(0xFF131112),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              HeaderStandard( title: 'HOME',),

            ],
          ),
        ),
      ),
    );
  }
}

