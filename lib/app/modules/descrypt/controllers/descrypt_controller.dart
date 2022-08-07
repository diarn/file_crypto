import 'dart:io' as io;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    getFiles();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getFiles() async {
    String dirPath = "/storage/emulated/0/File Encryptor/Descrypted File/";
    file.value = io.Directory(dirPath)
        .listSync(); //use your folder name insted of resume.
    for (var i = 0; i < file.length; i++) {
      var x = file[i].path.split("/");
      fileName.add(x[6]);
      fileName.refresh();
    }
  }

  openDownloadDialog(String fileName, String filePath) {
    Get.dialog(
      SimpleDialog(
        title: Text("Pilih Aksi"),
        contentPadding: EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                borderRadius: BorderRadius.circular(8),
                color: Colors.teal[300],
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    downloadFile(filePath, fileName);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text("Download"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  downloadFile(String filePath, String fileName) async {
    RxString tittle = "Mengunduh".obs;
    RxString message = "File Anda sedang diunduh".obs;
    Rx<dynamic> icon = Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.transparent,
      child: CircularProgressIndicator(),
    ).obs;
    Get.showSnackbar(GetSnackBar(
      backgroundColor: Colors.teal[800]!,
      titleText: Obx(() {
        return Text(tittle.value);
      }),
      messageText: Obx(() {
        return Text(message.value);
      }),
      mainButton: Obx(() {
        return icon.value;
      }),
    ));
    io.File downloadPath = io.File("/storage/emulated/0/Download/$fileName");
    io.File file = io.File(filePath);

    await file.readAsBytes().then((value) async {
      await downloadPath.writeAsBytes(value).then((vFile) {
        if (vFile.existsSync() == true) {
          tittle.value = "Berhasil";
          tittle.refresh();
          message.value = "File Anda telah diunduh";
          message.refresh();
          icon.value = Material(
            borderRadius: BorderRadius.circular(8),
            color: Colors.teal,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text("Selesai"),
              ),
            ),
          );
          icon.refresh();
        } else {
          tittle.value = "Gagal";
          tittle.refresh();
          message.value = "File Anda gagal diunduh";
          message.refresh();
          icon.value = Material(
            borderRadius: BorderRadius.circular(8),
            color: Colors.teal,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text("Selesai"),
              ),
            ),
          );
        }
        icon.refresh();
      });
    });
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
            label: "Nama File Output",
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
    // final directory = (await getExternalStorageDirectory())!.path;

    String dirPath = "/storage/emulated/0/File Encryptor/Descrypted File/";
    final io.Directory _appDocDirFolder = io.Directory(dirPath);

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
    } else {
      //if folder not exists create folder and then return its path
      await _appDocDirFolder.create(recursive: true);
    }

    FileCryptor fileCryptor = FileCryptor(
      key: key.text,
      iv: 16,
      dir: dirPath,
    );
    try {
      await fileCryptor
          .decrypt(inputFile: filePath, outputFile: outFileNameDescrypt.text)
          .then((_) {
        fileName.clear();
        getFiles();
      });

      Get.showSnackbar(GetSnackBar(
        title: "Berhasil",
        message: "File berhasil dideskripsi",
        duration: 1500.milliseconds,
        backgroundColor: Colors.teal[400]!,
      ));
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: "Gagal",
        message:
            "Opps kunci tidak cocok atau pad lock rusak, harap pastikan kunci yang Anda masukkan sudah benar untuk file ini",
        duration: 1500.milliseconds,
        backgroundColor: Colors.red,
      ));
    }
  }

  pickFile(Size size) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      if (file.extension! != "aes") {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            title: "Oops!",
            message: 'File yang didukung hanya format ".aes"',
            duration: 2500.milliseconds,
          ),
        );
      } else {
        openDescryptDialog(size, file.path!, file.name);
      }
      // inFileNameEncrypt.text = file.name;
      // Get.dialog(
      //   SimpleDialog(
      //     title: Text("Enkripsi File Baru"),
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.only(left: 16, right: 16),
      //         child: MyFormField(
      //           inputController: inFileNameEncrypt,
      //           label: "Nama File Original",
      //           textInputType: TextInputType.text,
      //           hintText: "hintText",
      //           readOnly: true,
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(left: 16, right: 16),
      //         child: MyFormField(
      //           inputController: key,
      //           label: "Kunci Kemanan Anda",
      //           textInputType: TextInputType.text,
      //           hintText:
      //               "Harap ingat atau simpan kunci yang Anda masukkan disini untuk digunakan nanti pada saat ingin membuka file kembali",
      //           readOnly: false,
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(left: 16, right: 16),
      //         child: MyFormField(
      //           inputController: outFileNameEncrypt,
      //           label: "Nama File Output",
      //           textInputType: TextInputType.text,
      //           hintText: "Silahkan masukkan nama file terserah Anda",
      //           readOnly: false,
      //         ),
      //       ),
      //       SizedBox(
      //         height: 8,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(left: 16, right: 16),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.end,
      //           children: [
      //             Material(
      //               color: Colors.teal[300],
      //               borderRadius: BorderRadius.circular(8),
      //               child: InkWell(
      //                 borderRadius: BorderRadius.circular(8),
      //                 onTap: () {
      //                   Get.back();
      //                 },
      //                 child: Container(
      //                   padding: EdgeInsets.all(8),
      //                   child: Text("Batalkan"),
      //                 ),
      //               ),
      //             ),
      //             SizedBox(
      //               width: 8,
      //             ),
      //             Material(
      //               color: Colors.teal,
      //               borderRadius: BorderRadius.circular(8),
      //               child: InkWell(
      //                 borderRadius: BorderRadius.circular(8),
      //                 onTap: () {
      //                   Get.back();
      //                   isLoaading.value = true;
      //                   isLoaading.refresh();
      //                   encryptFile(file.path!).then((_) {
      //                     fileName.clear();
      //                     isLoaading.value = false;
      //                     isLoaading.refresh();
      //                     getFiles();
      //                   });
      //                 },
      //                 child: Container(
      //                   padding: EdgeInsets.all(8),
      //                   child: Text(
      //                     "Enkripsi",
      //                     style: TextStyle(color: Colors.white),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // );
    } else {
      // User canceled the picker
    }
  }
}
