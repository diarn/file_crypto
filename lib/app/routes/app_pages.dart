import 'package:get/get.dart';

import 'package:file_encryptor/app/modules/descrypt/bindings/descrypt_binding.dart';
import 'package:file_encryptor/app/modules/descrypt/views/descrypt_view.dart';
import 'package:file_encryptor/app/modules/home/bindings/home_binding.dart';
import 'package:file_encryptor/app/modules/home/views/home_view.dart';
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
      transition: Transition.fade,
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
      transition: Transition.fade,
    ),
  ];
}
