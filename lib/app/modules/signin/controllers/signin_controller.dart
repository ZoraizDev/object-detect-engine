import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../core/utils/utils.dart';

class SigninController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  var obscurePassword = true.obs;
  var isLoading = false.obs;
  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

void login() async {
  if (!formKey1.currentState!.validate()) {
    Utils.snackBar('Error', 'Please fill All Filds');
    return;
  }
  isLoading.value = true;
  try {
    await Future.delayed(const Duration(seconds: 2));
    Utils.snackBar("Success", "Logged in successfully");
    Get.offNamed(Routes.HOME);
  } catch (e) {
    Utils.snackBar("Error", "Login failed");
  } finally {
    isLoading.value = false;
  }
}
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
