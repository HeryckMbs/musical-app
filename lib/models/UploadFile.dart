import 'dart:io';

class UploadFile {
  late String filename;
  late File pdf;

  UploadFile(fileNameUpload, fileUpload) {
    pdf = fileUpload;
    filename = fileNameUpload;
  }
}
