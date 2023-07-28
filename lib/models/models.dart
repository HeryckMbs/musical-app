// import 'dart:io';

// import 'package:path_provider/path_provider.dart';
// import 'package:pibfin/controller/CifraController.dart';



// class CifrasModel {
//   late String fullPath;
//   late String nome;
//   late String urlDownload;
//   bool fileExist = false;

//   Future setFileExist() async {
//     final dir = await getExternalStorageDirectory();
//     String? filename = this.nome;
//     String? filePath = '${dir?.path}/$filename.pdf';
//     fileExist =
//         FileSystemEntity.typeSync(filePath) != FileSystemEntityType.notFound;
//   }

//   CifrasModel(String fullPathFile, String nomeArquivo) {
//     fullPath = fullPathFile;
//     nome = nomeArquivo;
//   }

//   Future<bool> download() async {
//     var pdf = await CifraController.downloadCifra(fullPath, nome + ".pdf");
//     fileExist = pdf != null;
//     return fileExist;
//   }
// }
