import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:new_pib_app/models/token.dart';
import 'package:new_pib_app/views/cadastro.dart';
import 'package:new_pib_app/views/external.dart';
import 'package:new_pib_app/views/login.dart';
import 'package:new_pib_app/views/Equipe/EscolhaEquipe.dart';
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'models/sessao.dart';
import 'views/home/home.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  await dotenv.load(fileName: "assets/.env");
  bool logged = false;
  if(localStorage.containsKey('access_token') && !getIt.isRegistered<Token>()){
    String access_token = localStorage.getString('access_token')!;
    String refresh_token = localStorage.getString('refresh_token')!;
    String valid_until = localStorage.getString('valid_until')!;


    if(access_token != null &&
    refresh_token != null &&
    valid_until != null){
      getIt.registerSingleton(Token(accessToken: access_token,refreshToken:  refresh_token,validUntil:  DateTime.parse(valid_until)));
      logged = true;
    }
  }

  if(!getIt.isRegistered<Sessao>()){
    getIt.registerSingleton(Sessao(idEquipe_selecionada: 0));
  }

  runApp(MyApp(logged: logged,));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key,required this.logged});
  bool logged;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('pt', 'BR')
        ],

        title: 'PIB Finsocial',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Montserrat',
       ),
        debugShowCheckedModeBanner: false,
        home: logged  ? EscolhaEquipe(): MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StandardTheme.homeColor,
      body: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: 30,
            right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(child: SvgPicture.asset('assets/login.svg', fit: BoxFit.contain,height: MediaQuery.of(context).size.height * 0.33,)),
            Padding(
              padding: const EdgeInsets.only(top:0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [  const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Bem vindo!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Integre sua equipe de maneira fácil e prática com "abcde"',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, PageTransition(child: Cadastro(), type: PageTransitionType.fade));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 40),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Cadastre-se',
                          style: TextStyle(
                              color: StandardTheme.homeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, PageTransition(child: Login(), type: PageTransitionType.fade));
                  },                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        color: StandardTheme.homeColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.white, width: 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Entrar',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),],),
            )
          ],
        ),
      ),
    );
  }
}
