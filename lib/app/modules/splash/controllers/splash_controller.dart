import 'dart:developer';
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
    if (storageStatus.isDenied) {
      await Permission.storage.request();
    }
    var manageStatus = await Permission.storage.status;
    if (manageStatus.isDenied) {
      await Permission.manageExternalStorage.request();
    }

    inspect(storageStatus);
    inspect(manageStatus);
    Directory enFile =
        Directory("/storage/emulated/0/File Encryptor/Encrypted File/");
    Directory descFile =
        Directory("/storage/emulated/0/File Encryptor/Descripted File/");
    if (await enFile.exists()) {
      //
    } else {
      await enFile.create(recursive: true);
    }
    if (await descFile.exists()) {
      //
    } else {
      await descFile.create(recursive: true);
    }
  }
}
