import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:new_pib_app/models/User.dart';
import 'package:new_pib_app/views/external.dart';
import 'package:new_pib_app/views/homePage/home.dart';
import 'package:new_pib_app/views/login.dart';
import 'package:new_pib_app/views/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  await dotenv.load(fileName: "assets/.env");

  if (!getIt.isRegistered<UserCustom>() &&
      localStorage.containsKey('UserCustom')) {
    var userStored = localStorage.getString('UserCustom');

    UserCustom usuario = UserCustom.fromJson(json.decode(userStored!));
    getIt.registerSingleton(usuario);
  }
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

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

            timePickerTheme: TimePickerThemeData(

              backgroundColor: ColorsWhiteTheme.cardColor2,
              hourMinuteTextColor: Colors.white,
              entryModeIconColor: ColorsWhiteTheme.cardColor,
              dialTextColor: Colors.white,
              hourMinuteColor: ColorsWhiteTheme.cardColor2,
              helpTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            datePickerTheme: DatePickerThemeData(
                backgroundColor: ColorsWhiteTheme.cardColor2,
                dayForegroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                yearForegroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                todayForegroundColor: MaterialStateColor.resolveWith(
                    (states) => ColorsWhiteTheme.cardColor),
                yearOverlayColor: MaterialStateColor.resolveWith(
                    (states) => ColorsWhiteTheme.cardColor),
                headerHeadlineStyle:
                    const TextStyle(color: Colors.white, fontSize: 25),
                headerHelpStyle: const TextStyle(
                  color: Colors.white,
                ),
                headerForegroundColor: Colors.white,
                rangePickerHeaderForegroundColor: Colors.white,
                rangeSelectionBackgroundColor: Colors.white,
                yearStyle: const TextStyle(color: Colors.red),
                yearBackgroundColor: MaterialStateColor.resolveWith(
                    (states) => ColorsWhiteTheme.cardColor2),
                weekdayStyle: TextStyle(color: ColorsWhiteTheme.cardColor),
                dayStyle: const TextStyle(color: Colors.white))),
        debugShowCheckedModeBanner: false,
        home: HomePublic());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.isLogged, required this.title});

  bool isLogged;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: widget.isLogged
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                ],
              ),
            )
          : const Text('data'),
    );
  }
}
