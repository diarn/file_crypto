import 'package:get/get.dart';

class AboutAppController extends GetxController {
  final RxString aboutApp =
      "Aplikasi ini merupakan aplikasi berbasis Android, dimana aplikasi ini berfungsi untuk mengamankan sebuah file dokumen agar file dokumen tidak dapat terbaca oleh pihak yang tidak berkenan.\nAdapun proses dalam aplikasi ini terdapat dua proses yaitu proses enkripsi dan dekripsi\n\nAplikasi ini dikembangkan oleh\nRita Bonita (24052218086)\nProgram Studi Teknik Elektro\nFakultas Teknik\nUniversitas Garut\nEmail ritabonita1312@gmail.com"
          .obs;
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
}
