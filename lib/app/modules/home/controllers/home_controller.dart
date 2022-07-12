import 'dart:developer';
import 'dart:io' as io;
import 'dart:io';

import 'package:file_cryptor/file_cryptor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/my_widget.dart';

class HomeController extends GetxController {
  TextEditingController key = TextEditingController();
  TextEditingController inFileNameEncrypt = TextEditingController();
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

  pickFile(Size size) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      inFileNameEncrypt.text = file.name;
      Get.dialog(
        Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            height: size.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyFormField(
                  inputController: inFileNameEncrypt,
                  label: "Original File Name",
                  textInputType: TextInputType.text,
                  hintText: "hintText",
                  readOnly: true,
                ),
                MyFormField(
                  inputController: key,
                  label: "Your Security Key",
                  textInputType: TextInputType.text,
                  hintText:
                      "Please remember this key for unlock the file later",
                  readOnly: false,
                ),
                MyFormField(
                  inputController: outFileNameEncrypt,
                  label: "Output Name",
                  textInputType: TextInputType.text,
                  hintText: "Feel free to take anything you want",
                  readOnly: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      color: Colors.teal[300],
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text("Cancel"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Material(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Encrypt",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      // .then((value) {
      //   encryptFile(file.path!).then((_) {
      //     fileName.clear();
      //     getFiles();
      //   });
      // });
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
