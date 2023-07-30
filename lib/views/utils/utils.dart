import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:new_pib_app/controllers/ChurchController.dart';
import 'package:new_pib_app/controllers/DepartmentController.dart';
import 'package:new_pib_app/models/Departamento.dart';
import 'package:new_pib_app/models/User.dart';
import 'package:new_pib_app/models/igreja.dart';
import 'package:new_pib_app/views/homePage/home.dart';
import 'package:page_transition/page_transition.dart';

import '../../main.dart';
import '../church/DetailChurch.dart';
import '../church/ListChurch.dart';
import '../department/ListDepartment.dart';

// import 'package:pibfin/main.dart';

class ColorsWhiteTheme {
  static Color homeColor = const Color(0xFFFAFAFA);
  static Color pibTheme = const Color.fromRGBO(255, 224, 12, 10);
  static Color cardColor = const Color(0xFFFFD54F);
  static Color cardColor2 = const Color(0xFF262425);
  static Color fontColor = const Color.fromRGBO(0, 0, 0, 10);
}

class ColorsDarkTheme {
  static Color homeColor = const Color.fromRGBO(31, 31, 31, 10);
  static Color pibTheme = const Color.fromRGBO(255, 224, 12, 10);
  static Color cardColor = const Color.fromRGBO(24, 24, 24, 10);
  static Color fontColor = const Color.fromRGBO(255, 255, 255, 10);
}

class CifrasIndexPage extends StatefulWidget {
  CifrasIndexPage(
      {super.key,
      required this.searchble,
      required this.cifra,
      this.path,
      required this.isLoadingPage,
      required this.updatePage,
      required this.parentContext});

  final bool searchble;
  final Function updatePage;
  final List<Function> isLoadingPage;
  final BuildContext parentContext;
  final path;
  final List<dynamic> cifra;

  @override
  State<CifrasIndexPage> createState() => _CifrasIndexPageState();
}

/**
 * {cifras: [{'nome':'','fullPathStorage':''},{},{}]}
 *
 */
class _CifrasIndexPageState extends State<CifrasIndexPage> {
  List<dynamic>? cifrasFiltradas = [];
  final controller = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    cifrasFiltradas = widget.cifra;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cifra.isEmpty) {
      return const NotFoundCifras();
    } else {
      return isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: const Color(0xFF131112),
              child: Column(
                children: [
                  widget.searchble
                      ? Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                              onChanged: (value) {
                                // setState(() {
                                //   cifrasFiltradas = List.from(widget.cifra)
                                //       .where((element) => element.nome
                                //           .toLowerCase()
                                //           .contains(value.toLowerCase()))
                                //       .cast<CifrasModel>()
                                //       .toList();
                                // });
                              },
                              decoration:
                                  DecorationVariables.inputPesquisaDecoration),
                        )
                      : Container(),
                  GridView.builder(
                    padding: const EdgeInsets.all(10),
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                    itemCount: cifrasFiltradas!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          // if (cifrasFiltradas![index].fileExist) {
                          //   await PdfController.displayPdf(
                          //     widget.parentContext,
                          //     cifrasFiltradas![index].nome!,
                          //     cifrasFiltradas![index].nome!,
                          //   );
                          // } else {
                          //   widget.isLoadingPage[0]();
                          //   Uint8List? pdfData =
                          //       await CifraController.readCifra(
                          //           cifrasFiltradas![index].fullPath);
                          //   // ignore: use_build_context_synchronously
                          //   await PdfController.displayPdfMemory(
                          //       widget.parentContext,
                          //       pdfData!,
                          //       cifrasFiltradas![index].nome);
                          //   widget.isLoadingPage[1]();
                          // }
                        },
                        child: PdfCard(
                          updatePage: widget.updatePage,
                          path: widget.path ?? '',
                          parentContext: context,
                          // cifra: cifrasFiltradas![index],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
    }
  }
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
                  color: Colors.grey),
              'Ops! Não foram encontradas cifras para esta pasta...Tente cadastrar uma :)'),
        ]),
      ),
    );
  }
}

class PdfCard extends StatefulWidget {
  const PdfCard({
    super.key,
    // required this.cifra,
    required this.parentContext,
    required this.updatePage,
    required this.path,
  });

  // final CifrasModel cifra;
  final Function updatePage;
  final String path;
  final BuildContext parentContext;

  @override
  State<PdfCard> createState() => _PdfCardState();
}

class _PdfCardState extends State<PdfCard> {
  var isDownloaded;
  bool _isLoading = false;

  void download() {
    setState(() {
      isDownloaded = true;
    });
  }

  void delete() {
    setState(() {
      isDownloaded = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    downloadPdf() async {
      // setState(() {
      //   _isLoading = true;
      // });
      // var pdf = await CifraController.downloadCifra(
      //     widget.cifra!.fullPath, widget.cifra!.nome + ".pdf");
      // download();
      // widget.cifra?.fileExist = pdf != null;
      // setState(() {
      //   _isLoading = false;
      // });
    }

    deletePdf() async {
      // bool deleted = await CifraController.deletePdfInternalStorage(
      //     widget.cifra!.nome + ".pdf");
      // if (deleted) {
      //   delete();
      //   widget.cifra?.fileExist = false;
      // } else {
      //   // ignore: use_build_context_synchronously
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Não foi possível excluir o arquivo'),
      //       backgroundColor: Colors.redAccent,
      //     ),
      //   );
      // }
    }

    deletePdfPasta() async {
      // setState(() {
      //   _isLoading = true;
      // });

      // if (widget.path != '') {
      //   await PastaController.deleteCifraPasta(
      //       widget.cifra!.nome, widget.cifra.fullPath, widget.path);
      // } else {
      //   await CifraController.deleteCifraPastaStorage(widget.cifra.fullPath);
      // }
      // await widget.updatePage();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     elevation: 2000,
      //     duration: Duration(seconds: 5),
      //     content: Row(children: [
      //       Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      //         child: Icon(
      //           Icons.done,
      //           color: Colors.white,
      //         ),
      //       ),
      //       Expanded(
      //         child: Text(
      //             'Que pena, essa música era tão legal... Mas foi excluída com sucesso!'),
      //       )
      //     ]),
      //     backgroundColor: Colors.green,
      //   ),
      // );
      // setState(() {
      //   _isLoading = false;
      // });
    }

    // isDownloaded = widget.cifra!.fileExist;

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                CifraCard(
                  filename: 'resa',
                  // filename: widget.cifra.nome,
                  isDownloaded: isDownloaded,
                ),
                DownloadButton(
                    updatePage: widget.updatePage,
                    isDownloaded: isDownloaded,
                    deletePdfPasta: deletePdfPasta,
                    downloadPdf: downloadPdf)
              ],
            ),
          );
  }
}

class CifraCard extends StatelessWidget {
  CifraCard({super.key, required this.filename, required this.isDownloaded});

  final filename;
  bool isDownloaded;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDownloaded
                ? const Color.fromRGBO(129, 199, 132, 1)
                : Colors.transparent,
          ),
          color: ColorsWhiteTheme.cardColor2,
          borderRadius: const BorderRadius.all(
              // left: Radius.circular(30)
              Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(
            //   Icons.my_library_music_outlined,
            //   size: 30,
            //   color: ColorsWhiteTheme.fontColor,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                ' $filename',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DownloadButton extends StatefulWidget {
  const DownloadButton(
      {super.key,
      required this.isDownloaded,
      required this.deletePdfPasta,
      required this.updatePage,
      required this.downloadPdf});

  final downloadPdf;
  final deletePdfPasta;
  final Function updatePage;
  final bool isDownloaded;

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool _isDownloaded = false;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _isDownloaded = widget.isDownloaded;
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.04,
          width: MediaQuery.of(context).size.width * 0.1,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: _isDownloaded ? Colors.green[300] : Colors.blueGrey[100],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Icon(
            _isDownloaded ? Icons.download_done : Icons.cloud_download_outlined,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.04,
          width: MediaQuery.of(context).size.width * 0.1,
          margin: const EdgeInsets.all(5),
          child: PopupMenuButton(
            tooltip: 'Opções',
            icon: const Icon(Icons.more_vert_rounded),
            iconSize: MediaQuery.of(context).size.width * 0.06,
            onSelected: (item) async {
              await item();
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<Function>(
                value: widget.downloadPdf,
                child: const Text('Baixar Cifra'),
              ),
              PopupMenuItem<Function>(
                value: widget.deletePdfPasta,
                child: const Text('Excluir cifra da pasta'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void showDialogue(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => Center(
        // /RefreshProgressIndicator()
        // child: CircularProgressIndicator(color: Color(0xFFFFD54F),semanticsLabel: 'Carregando',semanticsValue: 'Carregando',)),
        child: RefreshProgressIndicator(
      color: const Color(0xFFFFD54F),
      backgroundColor: ColorsWhiteTheme.cardColor2,
    )),
  );
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

void hideProgressDialogue(BuildContext context) {
  Navigator.of(context).pop(RefreshProgressIndicator(
    color: const Color(0xFFFFD54F),
    backgroundColor: ColorsWhiteTheme.cardColor2,
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
          color: ColorsWhiteTheme.cardColor2,
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
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              texto,
              style: const TextStyle(color: Colors.grey),
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
          color: ColorsWhiteTheme.cardColor2,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icone != null
                ? Icon(
                    icone,
                    color: ColorsWhiteTheme.cardColor,
                    size: 40,
                  )
                : Container(),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: fontColor != null ? fontColor : Colors.grey,
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
      this.action,
      required this.validate,
      required this.onChange,
      required this.onTap});

  final TextEditingController? controller;
  final nome;
  final icon;
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
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        textInputAction: action ?? TextInputAction.done,
        style: const TextStyle(color: Colors.grey),
        onChanged: (value) async {
          onChange(value);
        },
        obscureText: password,
        controller: controller,
        cursorHeight: 30,
        cursorColor: Colors.grey,
        maxLines: constLines ?? 1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 30, left: 30, right: 30),
          helperStyle: const TextStyle(color: Colors.grey),
          hintStyle: TextStyle(height: height ?? 1, color: Colors.grey),
          alignLabelWithHint: true,
          errorStyle: const TextStyle(fontWeight: FontWeight.bold),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.red)),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.red)),
          labelText: nome,
          floatingLabelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(color: Colors.white60),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                width: 3,
                color: ColorsWhiteTheme.cardColor,
              )),
          filled: true,
          fillColor: ColorsWhiteTheme.cardColor2,
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
      required this.onTap});

  final TextEditingController controller;
  final nome;
  final icon;
  final Function onTap; // nullable and optional
  final password;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: TextFormField(
        onTap: () {
          onTap();
        },
        style: const TextStyle(color: Colors.grey),
        obscureText: password,
        controller: controller,
        showCursor: false,
        readOnly: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 30, left: 30, right: 30),
          hintText: nome,
          helperText: nome,
          helperStyle: const TextStyle(color: Colors.grey),
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          prefixIcon: Icon(
            icon,
            color: const Color.fromRGBO(248, 213, 0, 1),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: Colors.black,
              )),
          filled: true,
          fillColor: ColorsWhiteTheme.cardColor2,
          hoverColor: Colors.black,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
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
      this.icon,
      required this.color});

  final Function onPressed;
  final String name;
  final IconData? icon;
  final Color color;
  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // ignore: prefer_if_null_operators
        backgroundColor:
            color != null ? color : const Color.fromRGBO(248, 213, 0, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onPressed: () async {
        onPressed();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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

class DecorationVariables {
  static InputDecoration inputPesquisaDecoration = const InputDecoration(
    contentPadding: EdgeInsets.all(20),
    filled: true,
    fillColor: Color(0xFF262425),
    hintText: 'Pesquisa',
    hintStyle: TextStyle(color: Colors.grey),
    suffixIcon: Icon(Icons.search, color: Colors.grey),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(40)),
    ),
  );

  static InputDecoration decorationInput(String label) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(top: 30, left: 30, right: 30),
      helperStyle: const TextStyle(color: Colors.grey),
      alignLabelWithHint: true,
      errorStyle: const TextStyle(fontWeight: FontWeight.bold),
      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.red)),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.red)),
      labelText: label,
      floatingLabelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: const TextStyle(color: Colors.white60),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 3,
            color: Color(0xFFFFD54F),
          )),
      filled: true,
      fillColor: const Color(0xFF262425),
    );
  }
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
            color: ColorsWhiteTheme.cardColor2,
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

  if (!context.mounted) return selectedDate;

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
      decoration: const BoxDecoration(color: Color(0xFF312F30)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                // if (widget.selecionado != 'home') {
                //   setState(() {
                //     widget.selecionado = 'home';
                //   });
                //   var eventos = await EventoController.getEventsByWeek(
                //       getIt<UserCustom>().ministerioSelecionado);
                //   List<Aviso> avisos =
                //       await AvisoController.getAvisosByMinisterioLimited(
                //           getIt<UserCustom>().ministerioSelecionado);
                //   // List<Pedido> pedidos = await PedidosController.getPedidos(getIt<UserCustom>().ministerioSelecionado);
                //   List<Pedido> pedidos = await PedidosController.getPedidos(
                //       getIt<UserCustom>().ministerioSelecionado);

                //   // ignore: use_build_context_synchronously
                await Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: Home(),
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 150)),
                    ModalRoute.withName('/'));
                // }
              },
              child: Column(
                children: [
                  Icon(Icons.home,
                      color: widget.selecionado == 'home'
                          ? Colors.amber[400]
                          : Colors.grey),
                  Expanded(
                    child: Text('Home',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: widget.selecionado == 'home'
                                ? Colors.amber[400]
                                : Colors.grey)),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                // if (widget.selecionado != 'event') {
                //   setState(() {
                //     widget.selecionado = 'event';
                //   });
                //   print(widget.idMinisterio);
                //   var eventos = await EventoController.getEvents(
                //       getIt<UserCustom>().ministerioSelecionado);
                //   // ignore: use_build_context_synchronously
                //   Navigator.pushAndRemoveUntil(
                //       context,
                //       PageTransition(
                //           child: EventsIndex(
                //             eventos: eventos,
                //           ),
                //           type: PageTransitionType.fade,
                //           duration: Duration(milliseconds: 150)),
                //       ModalRoute.withName('/'));
                // }
              },
              child: Column(
                children: [
                  Icon(Icons.calendar_month,
                      color: widget.selecionado == 'programation'
                          ? Colors.amber[400]
                          : Colors.grey),
                  Expanded(
                    child: Text('Programções',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: widget.selecionado == 'programation'
                                ? Colors.amber[400]
                                : Colors.grey)),
                  ),
                ],
              ),
            ),
            // InkWell(
            //   onTap: () async {
            //     // if (widget.selecionado != 'music') {
            //     //   setState(() {
            //     //     widget.selecionado = 'music';
            //     //   });
            //     //   // ignore: use_build_context_synchronously
            //     //   Navigator.pushAndRemoveUntil(
            //     //       context,
            //     //       PageTransition(
            //     //           child: MusicMenuIndex(),
            //     //           type: PageTransitionType.fade,
            //     //           duration: Duration(milliseconds: 150)),
            //     //       ModalRoute.withName('/'));
            //     // }
            //   },
            //   child: Column(
            //     children: [
            //       Icon(Icons.music_note,
            //           color: widget.selecionado == 'music'
            //               ? Colors.amber[400]
            //               : Colors.grey),
            //       Expanded(
            //         child: Text('Músicas',
            //             style: TextStyle(
            //                 fontSize: MediaQuery.of(context).size.width * 0.035,
            //                 color: widget.selecionado == 'music'
            //                     ? Colors.amber[400]
            //                     : Colors.grey)),
            //       )
            //     ],
            //   ),
            // ),
            // InkWell(
            //   onTap: () async {
            //     if (widget.selecionado != 'department') {
            //       setState(() {
            //         widget.selecionado = 'department';
            //       });
            //       showDialogue(context);
            //       List<Departamento> departamentos =
            //           await DepartmentController.getDepartmentsOfChurch(
            //               getIt<UserCustom>().igreja_selecionada!);
            //       await Navigator.pushAndRemoveUntil(
            //           context,
            //           PageTransition(
            //               child: DepartmentList(
            //                 departamentos: departamentos,
            //               ),
            //               type: PageTransitionType.fade,
            //               duration: Duration(milliseconds: 200)),
            //           ModalRoute.withName('/'));
            //       // hideProgressDialogue(context);
            //     }
            //   },
            //   child: Column(
            //     children: [
            //       Icon(Icons.groups_rounded,
            //           color: widget.selecionado == 'department'
            //               ? Colors.amber[400]
            //               : Colors.grey),
            //       Expanded(
            //         child: Text('Departamento',
            //             style: TextStyle(
            //                 fontSize: MediaQuery.of(context).size.width * 0.035,
            //                 color: widget.selecionado == 'department'
            //                     ? Colors.amber[400]
            //                     : Colors.grey)),
            //       )
            //     ],
            //   ),
            // ),
            InkWell(
              onTap: () async {
                if (widget.selecionado != 'department') {
                  setState(() {
                    widget.selecionado = 'department';
                  });
                  showDialogue(context);
                  Igreja igreja = await ChurchController.getChurch(
                      getIt<UserCustom>().igreja_selecionada!);
                  await Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          child: DetailIgreja(
                            igreja: igreja,
                          ),
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 200)),
                      ModalRoute.withName('/'));
                  // hideProgressDialogue(context);
                }
              },
              child: Column(
                children: [
                  Icon(Icons.groups_rounded,
                      color: widget.selecionado == 'department'
                          ? Colors.amber[400]
                          : Colors.grey),
                  Expanded(
                    child: Text('Igreja',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: widget.selecionado == 'department'
                                ? Colors.amber[400]
                                : Colors.grey)),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                // if (widget.selecionado != 'profile') {
                //   setState(() {
                //     widget.selecionado = 'profile';
                //   });
                //   var user = await FirebaseAuth.instance.currentUser;
                //   Navigator.pushAndRemoveUntil(
                //       context,
                //       PageTransition(
                //           child: ProfileIndex(
                //             user: user,
                //           ),
                //           type: PageTransitionType.fade,
                //           duration: Duration(milliseconds: 150)),
                //       ModalRoute.withName('/'));
                // }
              },
              child: Column(
                children: [
                  Icon(Icons.person,
                      color: widget.selecionado == 'profile'
                          ? Colors.amber[400]
                          : Colors.grey),
                  Expanded(
                    child: Text('Perfil',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            overflow: TextOverflow.fade,
                            color: widget.selecionado == 'profile'
                                ? Colors.amber[400]
                                : Colors.grey)),
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
        color: ColorsWhiteTheme.cardColor,
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
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Seja bem vindo,", style: TextStyle()),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${'Irmão da fé'}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
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
  const HeaderStandard({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05, left: 10, right: 10),
      decoration: BoxDecoration(
        color: ColorsWhiteTheme.cardColor,
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
        color: ColorsWhiteTheme.cardColor2,
        //background color of dropdown button
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        child: DropdownButton(
          padding: const EdgeInsets.all(5),
          dropdownColor: ColorsWhiteTheme.cardColor2,
          value: defaultValue,
          icon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_downward,
              color: Colors.grey,
            ),
          ),
          isExpanded: true,
          underline: Container(),
          onChanged: (value) {},
          iconEnabledColor: ColorsWhiteTheme.cardColor2,
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
            child: Icon(icon, color: ColorsWhiteTheme.cardColor),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                description != ''
                    ? Text(
                        description,
                        style: const TextStyle(color: Colors.grey),
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
                          : Colors.grey),
                  Expanded(
                    child: Text('Home',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: widget.selecionado == 'home'
                                ? Colors.amber[400]
                                : Colors.grey)),
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
                          : Colors.grey),
                  Expanded(
                    child: Text('Eventos',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: widget.selecionado == 'event'
                                ? Colors.amber[400]
                                : Colors.grey)),
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
                          : Colors.grey),
                  Expanded(
                    child: Text('Músicas',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: widget.selecionado == 'music'
                                ? Colors.amber[400]
                                : Colors.grey)),
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
