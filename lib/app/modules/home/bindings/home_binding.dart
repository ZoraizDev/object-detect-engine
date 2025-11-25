import 'package:detectai/app/modules/chatbot/controllers/chatbot_controller.dart';
import 'package:detectai/app/modules/objectdetection/controllers/objectdetection_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ObjectdetectionController>(()=>ObjectdetectionController());
    Get.lazyPut<ChatbotController>(()=>ChatbotController());
  }
}
