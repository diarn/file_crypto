import 'package:get/get.dart';

import '../controllers/descrypt_controller.dart';

class DescryptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DescryptController>(
      () => DescryptController(),
    );
  }
}
