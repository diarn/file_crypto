import 'package:get/get.dart';

import 'package:file_encryptor/app/modules/about_app/bindings/about_app_binding.dart';
import 'package:file_encryptor/app/modules/about_app/views/about_app_view.dart';
import 'package:file_encryptor/app/modules/beranda/bindings/beranda_binding.dart';
import 'package:file_encryptor/app/modules/beranda/views/beranda_view.dart';
import 'package:file_encryptor/app/modules/descrypt/bindings/descrypt_binding.dart';
import 'package:file_encryptor/app/modules/descrypt/views/descrypt_view.dart';
import 'package:file_encryptor/app/modules/home/bindings/home_binding.dart';
import 'package:file_encryptor/app/modules/home/views/home_view.dart';
import 'package:file_encryptor/app/modules/how_to_use/bindings/how_to_use_binding.dart';
import 'package:file_encryptor/app/modules/how_to_use/views/how_to_use_view.dart';
import 'package:file_encryptor/app/modules/splash/bindings/splash_binding.dart';
import 'package:file_encryptor/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.DESCRYPT,
      page: () => DescryptView(),
      binding: DescryptBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.BERANDA,
      page: () => BerandaView(),
      binding: BerandaBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.HOW_TO_USE,
      page: () => HowToUseView(),
      binding: HowToUseBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ABOUT_APP,
      page: () => AboutAppView(),
      binding: AboutAppBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
