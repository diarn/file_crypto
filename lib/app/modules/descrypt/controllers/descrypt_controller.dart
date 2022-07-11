import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_cryptor/file_cryptor.dart';

class DescryptController extends GetxController {
  RxList<io.FileSystemEntity> file = <io.FileSystemEntity>[].obs;
  RxList<String> fileName = <String>[].obs;
  TextEditingController key = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getFiles() async {
    final directory = (await getExternalStorageDirectory())!.path;
    // setState(() {
    file.value = io.Directory("$directory/data/")
        .listSync(); //use your folder name insted of resume.
    // });
    // inspect(file);
    for (var i = 0; i < file.length; i++) {
      var x = file[i].path.split("/");
      fileName.add(x[9]);
      fileName.refresh();
      // inspect(fileName);
    }
  }

  descryptFile() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    FileCryptor fileCryptor = FileCryptor(
      key: key.text,
      iv: 16,
      dir: "$directory/data",
      // useCompress: true,
    );
    io.File decryptedFile = await fileCryptor.decrypt(
        inputFile: "file.aes", outputFile: "file.txt");
    print(decryptedFile.absolute);
  }
}
