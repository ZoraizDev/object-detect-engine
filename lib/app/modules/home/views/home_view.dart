import 'package:detectai/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/colors/app_colors.dart';
import '../../chatbot/views/chatbot_view.dart';
import '../../objectdetection/views/objectdetection_view.dart';
import '../widgets/image_picker_sheet.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,

      body: Obx(() {
        final screens = [
          const ChatbotView(),
          ObjectDetectionView(),
          const Center(child: Text("Stats")),
        ];

        return screens[controller.currentIndex.value];
      }),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.changeTab(index);

            if (index == 1) {
              Future.microtask(() {
                Get.bottomSheet(
                  ImagePickerSheet(),
                  isScrollControlled: false,
                );
              });
            }
          },
          backgroundColor: AppColor.whiteColor,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              label: 'Chatbot',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_outlined),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_album_outlined),
              label: 'Gallery',
            ),
          ],
        ),
      ),
    );
  }
}
