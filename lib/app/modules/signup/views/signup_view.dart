import 'package:detectai/app/modules/signup/controllers/signup_controller.dart';
import 'package:detectai/app/widgets/auth_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/validators/auth_validator.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/auth_button.dart';
import '../../../widgets/auth_text.dart';
import '../../../widgets/auth_text_field.dart';
class SignupView extends GetView<SignupController> {
  const SignupView({super.key});
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 90.0, left: 16, right: 16),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AuthTitle(
                      title: 'Create Account',
                    ),

                    const SizedBox(height: 32),
                    AuthTextField(
                      controller:controller.nameController,
                      hintText: 'Full Name',
                      icon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      validator: AuthValidator.validateName,
                    ),

                    const SizedBox(height: 16),
                    AuthTextField(
                      controller: controller.emailController,
                      hintText: 'Email',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: AuthValidator.validateEmail,
                    ),

                    const SizedBox(height: 16),
                    Obx( ()=> AuthTextField(
                        controller: controller.passwordController,
                        hintText: 'Password',
                        icon: Icons.lock_outline,
                        obscureText:controller.obscurePassword.value,
                        keyboardType: TextInputType.text,
                        onToggle: controller.togglePassword,
                        validator: AuthValidator.validatePassword,
                      
                    ),
                    ),

                    const SizedBox(height: 16),
                    Obx(()=> AuthTextField(
                        controller: controller.confirmpasswordController,
                        hintText: 'Confirm Password',
                        icon: Icons.lock_outline,
                        keyboardType: TextInputType.text,
                        obscureText: controller.obscureConfirmPassword.value,
                        onToggle: controller.toggleConfirmPassword,
                        validator: (value) => AuthValidator.validateConfirmPassword(
                          value,
                         controller.passwordController.text.trim(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 64),
                    Obx(()=> AuthButton(
                        text: "Sign Up",
                        loading:controller.isLoading.value,
                        onPressed: controller.signup
                      ),
                    ),

                    const SizedBox(height: 16),
                    AuthText(
                      questionText: "Already have an account?",
                      actionText: "Sign In",
                      onPressed: (){ Get.offNamed(Routes.SIGNIN);}
                    ),
                  ],
                ),
              ),
            ),
          )
    );
  }
}