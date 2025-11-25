import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/validators/auth_validator.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/auth_button.dart';
import '../../../widgets/auth_text.dart';
import '../../../widgets/auth_text_field.dart';
import '../../../widgets/auth_title.dart';
import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey1,
          child: Padding(
            padding: const EdgeInsets.only(top: 90.0, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AuthTitle(title: "Welcome Back"),
                const SizedBox(height: 32),
                AuthTextField(
                  controller: controller.emailController,
                  hintText: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator:AuthValidator.validateEmail,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                Obx(
                  () => AuthTextField(
                    controller: controller.passwordController,
                    hintText: 'Password',
                    icon: Icons.lock_outline,
                    obscureText: controller.obscurePassword.value,
                    validator:AuthValidator.validatePassword,
                    onToggle: controller.togglePassword,
                  ),
                ),
          
                const SizedBox(height: 94),
                Obx(
                  () => AuthButton(
                    text: 'Sign In',
                    loading: controller.isLoading.value,
                    onPressed:controller.login
                  ),
                ),
          
                const SizedBox(height: 16),
                AuthText(
                  questionText: "Don't have an account?",
                  actionText: "Sign Up",
                  onPressed: () {
                    Get.offNamed(Routes.SIGNUP);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
