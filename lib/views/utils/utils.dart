// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:new_pib_app/views/eventos/criarEvento.dart';
import 'package:page_transition/page_transition.dart';

import '../Equipe/details.dart';
import '../eventos/evento.dart';
import '../eventos/eventos.dart';
import '../home/home.dart';


class RouterCustom {

  late String currentIndex;
  late int idEventoSelecionado;
  late  Function notifyParent;

  void setIndex(String index) {
    currentIndex = index;
  }



  void setEvento(int idEventoo) {
    idEventoSelecionado = idEventoo;
    screens['evento'] = EventoIndex(
      idEvento: idEventoSelecionado,
    );
    currentIndex = 'evento';
  }

  void setRefresh(notify){
    notifyParent = notify;
  }

  RouterCustom(String index,) {
    currentIndex = index;
    idEventoSelecionado = 0;
    notifyParent = (){};
    screens['evento'] = EventoIndex(
      idEvento: idEventoSelecionado,
    );
  }

  Map<String, Widget> screens = {
    'home': FirstScreen(),
    'eventos': EventosList(),
    'third': ThirdScreen(),
    'equipe': EquipeIndex(),
    'createEvento': EventoCreate()
  };
}

class StandardTheme {
  static Color homeColor = const Color(0xFF0f3870);
  static Color disabledPrimary = const Color(0xFFd8e3f5);
  static Color cardColor = const Color(0xFFfed428);

  // static Color cardColor = const Color(0xFFFFD54F);
  static Color badge = const Color(0xFFcad8f5);
  static Color cardColor2 = const Color(0xFFfff9fc);

  // static Color cardColor2 = const Color(0xFF262425);
  static Color fontColor = const Color.fromRGBO(0, 0, 0, 10);
}

class ColorsDarkTheme {
  static Color homeColor = const Color.fromRGBO(31, 31, 31, 10);
  static Color pibTheme = const Color.fromRGBO(255, 224, 12, 10);
  static Color cardColor = const Color.fromRGBO(24, 24, 24, 10);
  static Color fontColor = const Color.fromRGBO(255, 255, 255, 10);
}

class Traducao {
  static List<String> meses = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];

  static List<String> diasSemana = [
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado',
    'Domingo'
  ];
}

class NotFoundCifras extends StatelessWidget {
  const NotFoundCifras({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Image.asset('assets/not-found.png'),
          const Text(
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
              'Ops! Não foram encontradas cifras para esta pasta...Tente cadastrar uma :)'),
        ]),
      ),
    );
  }
}

class NotFound extends StatelessWidget {
  NotFound({
    super.key,
    required this.texto,
  });

  String texto;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Image.asset('assets/not-found.png'),
          Text(
            texto,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20, fontStyle: FontStyle.italic, color: Colors.white),
          ),
        ]),
      ),
    );
  }
}

void showDialogue(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) => Center(
        // /RefreshProgressIndicator()
        // child: CircularProgressIndicator(color: Color(0xFFFFD54F),semanticsLabel: 'Carregando',semanticsValue: 'Carregando',)),
        child: RefreshProgressIndicator(
      color: const Color(0xFFFFD54F),
      backgroundColor: StandardTheme.cardColor2,
    )),
  );
}

void hideProgressDialogue(BuildContext context) {
  Navigator.of(context).pop(RefreshProgressIndicator(
    color: const Color(0xFFFFD54F),
    backgroundColor: StandardTheme.cardColor2,
  ));
}

class CardConteudo extends StatelessWidget {
  const CardConteudo({super.key, required this.title, required this.texto});

  final String title;
  final texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: StandardTheme.cardColor2,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              texto,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class CardAcoes extends StatelessWidget {
  const CardAcoes(
      {super.key,
      required this.title,
      required this.icone,
      this.fontColor,
      required this.iconColor});

  final String title;
  final icone;
  final fontColor;
  final iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: StandardTheme.cardColor2,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icone != null
                ? Icon(
                    icone,
                    color: iconColor,
                    size: 40,
                  )
                : Container(),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: fontColor != null ? fontColor : Colors.white,
                  fontSize: icone != null ? 16 : 16,
                  fontWeight:
                      icone != null ? FontWeight.normal : FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class Input extends StatelessWidget {
  Input(
      {super.key,
      this.controller,
      required this.nome,
      required this.icon,
      required this.password,
      this.height,
      this.constLines,
      this.dica,
      this.dark,
      this.action,
      required this.validate,
      required this.onChange,
      this.enabled,
      required this.onTap});

  final TextEditingController? controller;
  final nome;
  final icon;
  bool? enabled;
  bool? dark;
  final Function validate;
  final String? dica;
  final double? height;
  final TextInputAction? action;
  final int? constLines;
  final Function onTap; // nullable and optional
  final Function onChange; // nullable and optional
  final password;

  @override
  Widget build(BuildContext context) {
    Color colorText =
        dark != null && dark! == true ? Colors.black : Colors.white;
    return Container(
      child: TextFormField(
        textInputAction: action ?? TextInputAction.done,
        style: TextStyle(color: Colors.black),
        onChanged: (value) async {
          onChange!(value) ?? print('ruim');
        },
        obscureText: password,
        controller: controller,
        cursorHeight: 30,
        enabled: enabled,
        cursorColor: Colors.black,
        maxLines: constLines ?? 1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 30, left: 30, right: 30),
          helperStyle: TextStyle(color: colorText),
          hintStyle: TextStyle(height: height ?? 1, color: colorText),
          alignLabelWithHint: true,
          errorStyle: const TextStyle(fontWeight: FontWeight.bold),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.red)),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.red)),
          labelText: nome,
          floatingLabelStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                width: 3,
                color: dark != null && dark! == true
                    ? Colors.white
                    : StandardTheme.homeColor,
              )),
          filled: true,
          fillColor: Color(0xFFfff9fc),
        ),
        validator: (value) {
          return validate(value);
        },
      ),
    );
  }
}

class InputDate extends StatelessWidget {
  InputDate(
      {super.key,
      required this.controller,
      required this.nome,
      required this.icon,
      required this.password,
       this.dark,
      required this.onTap});

  final TextEditingController controller;
  final nome;
  final icon;
  final Function onTap; // nullable and optional
  final password;
  bool? dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: TextFormField(
        onTap: () {
          onTap();
        },
        style: const TextStyle(color: Colors.black),
        obscureText: password,
        controller: controller,
        showCursor: false,
        readOnly: true,
        decoration:  InputDecoration(
          contentPadding: const EdgeInsets.only(top: 30, left: 30, right: 30),
          
          
          alignLabelWithHint: true,
          errorStyle: const TextStyle(fontWeight: FontWeight.bold),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.red)),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.red)),
          labelText: nome,
          floatingLabelStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                width: 3,
                color: dark != null && dark! == true
                    ? Colors.white
                    : StandardTheme.homeColor,
              )),
          filled: true,
          fillColor: Color(0xFFfff9fc),
        ),
         ),
    );
  }
}

class ElevatedButtonCustom extends StatelessWidget {
  const ElevatedButtonCustom(
      {super.key,
      required this.onPressed,
      required this.name,
      this.colorText,
      this.full,
      this.icon,
      required this.color});

  final Function onPressed;
  final bool? full;
  final String name;
  final IconData? icon;
  final Color color;
  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // ignore: prefer_if_null_operators
        backgroundColor: color != null ? color : StandardTheme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onPressed: () async {
        onPressed();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: full != null ? MainAxisSize.max : MainAxisSize.min,
          children: [
            icon != null
                ? Icon(
                    icon,
                    color: colorText ?? Colors.black,
                  )
                : Container(),
            Text(
              name,
              style: TextStyle(color: colorText ?? Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class OfflineBar extends StatelessWidget {
  const OfflineBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child:  Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.wifi_off,
              color: Colors.white,
            ),
          ),
          Text(
            'Modo offline ativado',
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class DecorationVariables {
  static InputDecoration inputPesquisaDecoration = InputDecoration(
    contentPadding: const EdgeInsets.all(20),
    filled: true,
    fillColor: StandardTheme.badge,
    hintText: 'Pesquisa',
    hintStyle: const TextStyle(color: Colors.white),
    suffixIcon: const Icon(Icons.search, color: Colors.white),
    border: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(40)),
    ),
  );
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.iconColor,
  });

  final Function onTap;
  final Color iconColor;
  final icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: StandardTheme.cardColor2,
            borderRadius: const BorderRadius.all(Radius.circular(100))),
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}

Future<DateTime?> showDateTimePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  initialDate ??= DateTime.now();
  firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
  lastDate ??= firstDate.add(const Duration(days: 365 * 200));

  final DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  if (selectedDate == null) return null;


  final TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(selectedDate),
  );

  return selectedTime == null
      ? selectedDate
      : DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
}

class CustomTag extends StatefulWidget {
  CustomTag({
    super.key,
    required this.text,
    required this.selecionado,
    this.onTap,
    required this.icon,
    required this.tagColor,
  });

  final Function? onTap;
  final Color tagColor;
  bool selecionado;
  final String text;
  final icon;

  @override
  State<CustomTag> createState() => _CustomTagState();
}

class _CustomTagState extends State<CustomTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: widget.tagColor),
      padding: const EdgeInsets.all(10),
      child: InkWell(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                    color: widget.selecionado ? Colors.black : Colors.white),
              ),
              Icon(widget.icon)
            ],
          ),
          onTap: () async {
            widget.onTap!();
          }),
    );
  }
}

class BottomBar extends StatefulWidget {
  BottomBar({super.key, required this.selecionado, this.idMinisterio});

  String selecionado;
  String? idMinisterio;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(color: StandardTheme.homeColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                if (widget.selecionado != 'home') {
                  showDialogue(context);

                  // ignore: use_build_context_synchronously
                  // await Navigator.pushAndRemoveUntil(
                  //     context,
                  //     PageTransition(
                  //       child: ModernPage(
                  //         pedidos: pedidos,
                  //         eventos: eventos,
                  //         avisos: avisos,
                  //       ),
                  //       type: PageTransitionType.fade,
                  //       duration: const Duration(milliseconds: 450),
                  //       reverseDuration: const Duration(milliseconds: 450),
                  //     ),
                  //     ModalRoute.withName('/'));
                  hideProgressDialogue(context);
                  setState(() {
                    widget.selecionado = 'home';
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: widget.selecionado == 'home'
                        ? StandardTheme.badge
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(Icons.home,
                          color: widget.selecionado == 'home'
                              ? Colors.amber[400]
                              : Colors.white),
                    ),
                    Text(widget.selecionado == 'home' ? 'Home' : '',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: widget.selecionado == 'home'
                                ? Colors.amber[400]
                                : Colors.white))
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if (widget.selecionado != 'event') {
                  showDialogue(context);
                  // var eventos = await EventoController.getEvents(
                  //     getIt<UserCustom>().ministerioSelecionado);
                  // // ignore: use_build_context_synchronously
                  // await Navigator.pushAndRemoveUntil(
                  //     context,
                  //     PageTransition(
                  //         child: EventsIndex(
                  //           eventos: eventos,
                  //         ),
                  //         type: PageTransitionType.fade,
                  //         duration: const Duration(milliseconds: 450),
                  //         reverseDuration: const Duration(milliseconds: 450)
                  //     ),
                  //     ModalRoute.withName('/'));

                  hideProgressDialogue(context);
                  setState(() {
                    widget.selecionado = 'event';
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: widget.selecionado == 'event'
                        ? StandardTheme.badge
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(Icons.calendar_month,
                          color: widget.selecionado == 'event'
                              ? Colors.amber[400]
                              : Colors.white),
                    ),
                    Text(widget.selecionado == 'event' ? 'Eventos' : '',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: widget.selecionado == 'event'
                                ? Colors.amber[400]
                                : Colors.white)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if (widget.selecionado != 'music') {
                  showDialogue(context);
                  // // ignore: use_build_context_synchronously
                  // await Navigator.pushAndRemoveUntil(
                  //     context,
                  //     PageTransition(
                  //         child: MusicMenuIndex(),
                  //         type: PageTransitionType.fade,
                  //         duration: const Duration(milliseconds: 450),
                  //         reverseDuration: const Duration(milliseconds: 450)
                  //     ),
                  //     ModalRoute.withName('/'));
                  // hideProgressDialogue(context);
                  setState(() {
                    widget.selecionado = 'music';
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: widget.selecionado == 'music'
                        ? StandardTheme.badge
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(Icons.music_note,
                          color: widget.selecionado == 'music'
                              ? Colors.amber[400]
                              : Colors.white),
                    ),
                    Text(widget.selecionado == 'music' ? 'Músicas' : '',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: widget.selecionado == 'music'
                                ? Colors.amber[400]
                                : Colors.white))
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if (widget.selecionado != 'integrante') {
                  showDialogue(context);
                  // Ministerio? ministerio =
                  // await MinisterioController.getMinisterioById(
                  //     getIt<UserCustom>().ministerioSelecionado);
                  // await Navigator.pushAndRemoveUntil(
                  //     context,
                  //     PageTransition(
                  //         child: MinisterioIndex(
                  //           ministerio: ministerio!,
                  //         ),
                  //         type: PageTransitionType.fade,
                  //         duration: const Duration(milliseconds: 450),
                  //         reverseDuration: const Duration(milliseconds: 450)
                  //     ),
                  //     ModalRoute.withName('/'));
                  hideProgressDialogue(context);
                  setState(() {
                    widget.selecionado = 'integrante';
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: widget.selecionado == 'integrante'
                        ? StandardTheme.badge
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(Icons.people,
                          color: widget.selecionado == 'integrante'
                              ? Colors.amber[400]
                              : Colors.white),
                    ),
                    Text(widget.selecionado == 'integrante' ? 'Ministério' : '',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: widget.selecionado == 'integrante'
                                ? Colors.amber[400]
                                : Colors.white))
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if (widget.selecionado != 'profile') {
                  showDialogue(context);
                  // var user = await FirebaseAuth.instance.currentUser;
                  // await Navigator.pushAndRemoveUntil(
                  //     context,
                  //     PageTransition(
                  //         child: ProfileIndex(
                  //           user: user,
                  //         ),
                  //         type: PageTransitionType.fade,
                  //         duration: const Duration(milliseconds: 450),
                  //         reverseDuration: const Duration(milliseconds: 450)
                  //     ),
                  //     ModalRoute.withName('/'));
                  hideProgressDialogue(context);
                  setState(() {
                    widget.selecionado = 'profile';
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: widget.selecionado == 'profile'
                        ? StandardTheme.badge
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(Icons.person,
                          color: widget.selecionado == 'profile'
                              ? Colors.amber[400]
                              : Colors.white),
                    ),
                    Text(widget.selecionado == 'profile' ? 'Perfil' : '',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            overflow: TextOverflow.fade,
                            color: widget.selecionado == 'profile'
                                ? Colors.amber[400]
                                : Colors.white))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05, left: 10, right: 10),
      decoration: BoxDecoration(
        color: StandardTheme.cardColor,
        borderRadius: const BorderRadius.all(
            // left: Radius.circular(30)
            Radius.circular(20)),
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Seja bem vindo,", style: TextStyle()),
                  Row(
                    children: [
                      // Expanded(
                      //   child: Text(
                      //     "${getIt<UserCustom>().UserAuthenticaded.displayName ?? 'Irmão da fé'}",
                      //     style: const TextStyle(fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              // widget.title,
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Image.asset('assets/logo.png'),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderStandard extends StatelessWidget {
  const HeaderStandard({super.key, required this.title, this.margin});

  final String title;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      margin: margin ??
          EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              left: 10,
              right: 10),
      decoration: BoxDecoration(
        color: StandardTheme.cardColor,
        borderRadius: const BorderRadius.all(
            // left: Radius.circular(30)
            Radius.circular(20)),
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle()),
                ],
              ),
            ),
            SizedBox(
              // widget.title,
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Image.asset('assets/logo.png'),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownCheckbox extends StatelessWidget {
  DropdownCheckbox(
      {super.key,
      required this.objetosEncontrados,
      required this.objetosSelecionados,
      required this.defaultValue});

  List<DropdownMenuItem<Object>> objetosEncontrados;
  var defaultValue;
  final List<dynamic> objetosSelecionados;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: StandardTheme.cardColor2,
        //background color of dropdown button
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        child: DropdownButton(
          dropdownColor: StandardTheme.cardColor2,
          value: defaultValue,
          icon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_downward,
              color: Colors.white,
            ),
          ),
          isExpanded: true,
          underline: Container(),
          onChanged: (value) {},
          iconEnabledColor: StandardTheme.cardColor2,
          items: objetosEncontrados,
        ),
      ),
    );
  }
}

class WideCard extends StatelessWidget {
  WideCard(
      {super.key,
      required this.title,
      required this.description,
      this.icon,
      this.extraDetails,
      this.actions});

  List<Widget>? actions;
  List<Widget>? extraDetails;
  IconData? icon;
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black26, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: StandardTheme.cardColor),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                description != ''
                    ? Text(
                        description,
                        style: const TextStyle(color: Colors.white),
                      )
                    : Container(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: extraDetails ?? [],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: actions ?? [],
          ),
        ],
      ),
    );
  }
}

class ExternalBottomBar extends StatefulWidget {
  ExternalBottomBar({super.key, required this.selecionado});

  String selecionado;

  @override
  State<ExternalBottomBar> createState() => _ExternalBottomBarState();
}

class _ExternalBottomBarState extends State<ExternalBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: const BoxDecoration(color: Color(0xFF312F30)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                if (widget.selecionado != 'home') {
                  setState(() {
                    widget.selecionado = 'home';
                  });

                  // ignore: use_build_context_synchronously
                  // await Navigator.pushAndRemoveUntil(
                  //     context,
                  //     PageTransition(
                  //         child: ModernPage(
                  //           eventos: eventos,
                  //           avisos: avisos,
                  //         ),
                  //         type: PageTransitionType.fade,
                  //         duration: Duration(milliseconds: 150)),
                  //     ModalRoute.withName('/'));
                }
              },
              child: Column(
                children: [
                  Icon(Icons.home,
                      color: widget.selecionado == 'home'
                          ? Colors.amber[400]
                          : Colors.white),
                  Expanded(
                    child: Text('Home',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: widget.selecionado == 'home'
                                ? Colors.amber[400]
                                : Colors.white)),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                if (widget.selecionado != 'event') {
                  setState(() {
                    widget.selecionado = 'event';
                  });

                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     PageTransition(
                  //         child: EventsIndex(
                  //           eventos: eventos,
                  //         ),
                  //         type: PageTransitionType.fade,
                  //         duration: Duration(milliseconds: 150)),
                  //     ModalRoute.withName('/'));
                }
              },
              child: Column(
                children: [
                  Icon(Icons.calendar_month,
                      color: widget.selecionado == 'event'
                          ? Colors.amber[400]
                          : Colors.white),
                  Expanded(
                    child: Text('Eventos',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: widget.selecionado == 'event'
                                ? Colors.amber[400]
                                : Colors.white)),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                if (widget.selecionado != 'music') {
                  setState(() {
                    widget.selecionado = 'music';
                  });
                  // ignore: use_build_context_synchronously
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     PageTransition(
                  //         child: MusicMenuIndex(),
                  //         type: PageTransitionType.fade,
                  //         duration: Duration(milliseconds: 150)),
                  //     ModalRoute.withName('/'));
                }
              },
              child: Column(
                children: [
                  Icon(Icons.music_note,
                      color: widget.selecionado == 'music'
                          ? Colors.amber[400]
                          : Colors.white),
                  Expanded(
                    child: Text('Músicas',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: widget.selecionado == 'music'
                                ? Colors.amber[400]
                                : Colors.white)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


void messageToUser(
    BuildContext context, String message, Color color, IconData icon) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 2000,
      content: Row(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Text(message),
        )
      ]),
      backgroundColor: color,
    ),
  );
}
