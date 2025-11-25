import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../resources/assets/image_assets.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Center(
            child: Image.asset(
              ImageAssets.splashScreen,
              width: controller.animation.value * 200,
              height: controller.animation.value * 200,
            ),
          );
        },
      ),
    );
  }
}
