import 'dart:io';
import 'package:detectai/app/modules/chatbot/controllers/chatbot_controller.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';

class ObjectdetectionController extends GetxController {
  RxString imagePath = ''.obs;
  RxList<String> detectedObjects = <String>[].obs;
  final ImagePicker _picker = ImagePicker();
  late final ImageLabeler _imageLabeler;
  final chatbotVM = Get.find<ChatbotController>();

  @override
  void onInit() {
    super.onInit();
    _imageLabeler = ImageLabeler(
      options: ImageLabelerOptions(
        confidenceThreshold: 0.85),
    );
  }

  Future pickImage(ImageSource source) async {
    final img = await _picker.pickImage(source: source);
    if (img != null) {
      Get.back();
      imagePath.value = img.path;
      await detectObjects(File(img.path));
    }
  }
  Future detectObjects(File imageFile) async {
    detectedObjects.clear();
    final inputImage = InputImage.fromFile(imageFile);
    final List<ImageLabel> labels = await _imageLabeler.processImage(inputImage);
    if (labels.isEmpty) {
      detectedObjects.add("No objects detected");
    } else {
      for (var label in labels) {
        detectedObjects.add(
            "${label.label} ");
      }
    }
    String detectermessage = "please describe it ${detectedObjects.first}";
    await chatbotVM.sendDetectorMessage(detectermessage);
  }

  @override
  void onClose() {
    _imageLabeler.close();
    super.onClose();
  }
}
