import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context?.height ?? 0;
  static double screenWidth = Get.context?.width ?? 0;
  // margin height
  static double height5 = Get.context!.height / 156.6545454;
  // margin width
  static double width5 = Get.context!.width / 78.545454545;
  // text and icons size
  static double size20 =
      (Get.context!.width * Get.context!.height) / 15380.628093818;
}
