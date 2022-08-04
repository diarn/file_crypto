import 'package:get/get.dart';

import '../controllers/how_to_use_controller.dart';

class HowToUseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HowToUseController>(
      () => HowToUseController(),
    );
  }
}
