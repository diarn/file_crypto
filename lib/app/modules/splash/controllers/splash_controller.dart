import 'dart:io';

import 'package:file_encryptor/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkDir().then((value) {
      Future.delayed(5000.milliseconds, () {
        Get.offAllNamed(Routes.BERANDA);
      });
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<dynamic> checkDir() async {
    var storageStatus = await Permission.storage.status;
    var manageStatus = await Permission.manageExternalStorage.status;
    if (storageStatus.isDenied) {
      await Permission.storage.request().then((_) async {
        if (manageStatus.isDenied) {
          await Permission.manageExternalStorage.request();
        }
      });
    }

    Directory enFile =
        Directory("/storage/emulated/0/File Encryptor/Encrypted File/");
    Directory descFile =
        Directory("/storage/emulated/0/File Encryptor/Descrypted File/");
    if (await enFile.exists()) {
      //
    } else {
      await enFile.create(recursive: true).then((_) async {
        if (await descFile.exists()) {
          //
        } else {
          await descFile.create(recursive: true);
        }
      });
    }
  }
}
