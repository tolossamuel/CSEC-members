import 'package:csec/homePage/Admin/Controller/controller.dart';
import 'package:csec/homePage/Admin/Controller/repository.dart';
import 'package:get/get.dart';

Future<void> init() async {
// admin repo
  Get.lazyPut(() => AdminRepo());

// admin controller
  Get.lazyPut(() => Controller(repository: Get.find()));
}
