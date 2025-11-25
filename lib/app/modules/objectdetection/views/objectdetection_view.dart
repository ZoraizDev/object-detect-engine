import 'dart:io';
import 'package:detectai/app/modules/chatbot/controllers/chatbot_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import '../../../resources/colors/app_colors.dart';
import '../controllers/objectdetection_controller.dart';

class ObjectDetectionView extends GetView<ObjectdetectionController> {
  ObjectDetectionView({super.key});
   final chatController = Get.find<ChatbotController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 34.0,
          left: 12,
          right: 12,
          bottom: 12,
        ),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: Get.width * 0.9,
                height: Get.height * 0.5,
                child: Obx(() {
                  if (controller.imagePath.value.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.photo_album,
                          color: AppColor.textformFieldColor,
                          size: 73,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'No Image Selected',
                          style: TextStyle(color: AppColor.textformFieldColor),
                        ),
                      ],
                    );
                  }

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(controller.imagePath.value),
                      fit: BoxFit.cover,
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.imagePath.value.isEmpty) {
                  return const SizedBox();
                }

                if (controller.detectedObjects.isEmpty) {
                  return const Center(
                    child: Text(
                      "Detecting objects...",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Detected Objects:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        ...controller.detectedObjects.map(
                          (obj) => Text(
                            "- $obj",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),

                        const SizedBox(height: 20),
                        Obx(() {
                          if (chatController.isTypeing.value) {
                            return const Text(
                              "Generating description...",
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            );
                          }
                          bool hasRealObjects =
                              controller.detectedObjects.isNotEmpty &&
                              !controller.detectedObjects.contains(
                                "No objects detected",
                              );

                          return hasRealObjects
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Description",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    GptMarkdown(
                                      chatController.decResponseText.value,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink();
                        }),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
