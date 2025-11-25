import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../core/utils/utils.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;
  var isLoading = false.obs;
  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }
  void toggleConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

void signup() async {
  if (!formKey.currentState!.validate()) {
    Utils.snackBar('Error', 'Please fill All Fields');
    return;
  }
  isLoading.value = true;
  try {
    await Future.delayed(const Duration(seconds: 2));
    Utils.snackBar("Success", "user registered successfully");
    Get.offNamed(Routes.HOME);
  } catch (e) {
    Utils.snackBar("Error", "Sign up failed");
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
