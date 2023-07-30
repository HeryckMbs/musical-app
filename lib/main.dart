import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:new_pib_app/models/User.dart';
import 'package:new_pib_app/views/external.dart';
import 'package:new_pib_app/views/homePage/home.dart';
import 'package:new_pib_app/views/login.dart';
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
        title: 'Flutter Demo',
        theme: ThemeData(useMaterial3: true, fontFamily: 'Montserrat'),
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
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                ],
              ),
            )
          : Text('data'),
    );
  }
}
