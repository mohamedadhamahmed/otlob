import 'package:get/get.dart';

import '../controller/homeController.dart';


class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(),fenix: true);
   // Get.put(ParentClass());
  }
}