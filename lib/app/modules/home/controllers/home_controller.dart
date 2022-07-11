import 'dart:developer';
import 'dart:io' as io;
import 'dart:io';

import 'package:file_cryptor/file_cryptor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TextEditingController key = TextEditingController();
  TextEditingController outFileNameEncrypt = TextEditingController();
  TextEditingController inFileNameDescrypt = TextEditingController();
  TextEditingController outFileNameDescrypt = TextEditingController();
  RxList<io.FileSystemEntity> file = <io.FileSystemEntity>[].obs;
  RxList<String> fileName = <String>[].obs;
  @override
  void onInit() {
    getFiles();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      Get.dialog(Dialog(
        child: Column(
          children: [
            TextFormField(
              controller: key,
            ),
            TextFormField(
              controller: outFileNameEncrypt,
            ),
          ],
        ),
      )).then((value) {
        encryptFile(file.path!).then((_) {
          fileName.clear();
          getFiles();
        });
      });
    } else {
      // User canceled the picker
    }
  }

  void getFiles() async {
    final directory = (await getExternalStorageDirectory())!.path;

    final Directory _appDocDirFolder = Directory('$directory/data/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
    } else {
      //if folder not exists create folder and then return its path
      await _appDocDirFolder.create(recursive: true);
    }

    file.value = io.Directory("$directory/data/")
        .listSync(); //use your folder name insted of resume.

    inspect(file);

    if (file.length > 0) {
      if (file.length < 10) {
        for (var i = 0; i < file.length; i++) {
          var x = file[i].path.split("/");
          fileName.add(x[9]);
          fileName.refresh();
          // inspect(fileName);
        }
      } else {
        for (var i = 0; i < 10; i++) {
          var x = file[i].path.split("/");
          fileName.add(x[9]);
          fileName.refresh();
        }
      }
    }
  }

  encryptFile(String fileName) async {
    final directory = (await getExternalStorageDirectory())!.path;
    inspect(directory);
    final Directory _appDocDirFolder = Directory('$directory/data/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
    } else {
      //if folder not exists create folder and then return its path
      await _appDocDirFolder.create(recursive: true);
    }
    FileCryptor fileCryptor = FileCryptor(
      key: key.text,
      iv: 16,
      dir: "$directory/data",
    );
    io.File encryptedFile = await fileCryptor.encrypt(
        inputFile: "$fileName", outputFile: "${outFileNameEncrypt.text}.aes");
    inspect(encryptedFile.absolute);
  }
}
