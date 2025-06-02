import 'package:get/get.dart';

import '../controllers/add_page_controller.dart';

class AddPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPageController>(
      () => AddPageController(),
    );
  }
}
