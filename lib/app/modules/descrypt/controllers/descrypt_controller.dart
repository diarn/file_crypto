import 'dart:developer';
import 'dart:io' as io;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_cryptor/file_cryptor.dart';

import '../../home/views/my_widget.dart';

class DescryptController extends GetxController {
  RxList<io.FileSystemEntity> file = <io.FileSystemEntity>[].obs;
  RxList<String> fileName = <String>[].obs;
  TextEditingController key = TextEditingController();
  TextEditingController inFileNameDescrypt = TextEditingController();
  TextEditingController outFileNameDescrypt = TextEditingController();
  RxBool isLoading = false.obs;
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

  openDescryptDialog(Size size, String filePath, String fileName) async {
    inFileNameDescrypt.text = fileName;
    Get.dialog(SimpleDialog(
      title: Text("Deskripsi File"),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: MyFormField(
            inputController: inFileNameDescrypt,
            label: "Nama File Original",
            textInputType: TextInputType.text,
            hintText: "hintText",
            readOnly: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: MyFormField(
            inputController: key,
            label: "Kunci Keamanan Anda",
            textInputType: TextInputType.text,
            hintText: "Masukkan kunci file yang dipilih",
            readOnly: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: MyFormField(
            inputController: outFileNameDescrypt,
            label: "Output Name",
            textInputType: TextInputType.text,
            hintText: "Silahkan masukkan file output terserah Anda",
            readOnly: false,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
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
                    child: Text("Batalkan"),
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
                    isLoading.value = true;
                    isLoading.refresh();
                    descryptFile(filePath).then((_) {
                      isLoading.value = false;
                      isLoading.refresh();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Deskripsi",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  descryptFile(String filePath) async {
    final directory = (await getExternalStorageDirectory())!.path;
    inspect(directory);
    final Directory _appDocDirFolder = Directory('$directory/output/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
    } else {
      //if folder not exists create folder and then return its path
      await _appDocDirFolder.create(recursive: true);
    }

    FileCryptor fileCryptor = FileCryptor(
      key: key.text,
      iv: 16,
      dir: "$directory/output",
    );
    try {
      File decryptedFile = await fileCryptor.decrypt(
          inputFile: filePath, outputFile: outFileNameDescrypt.text);

      inspect(decryptedFile.absolute);

      Get.showSnackbar(GetSnackBar(
        title: "Berhasil",
        message: "File berhasil dideskripsi",
        duration: 1500.milliseconds,
        backgroundColor: Colors.teal[400]!,
      ));
    } catch (e) {
      inspect(e);
      Get.showSnackbar(GetSnackBar(
        title: "Gagal",
        message:
            "Opps terjadi kunci tidak cocok atau pad lock rusak, harap pastikan kunci yang Anda masukkan sudah benar untuk file ini",
        duration: 1500.milliseconds,
        backgroundColor: Colors.red,
      ));
    }
  }
}
