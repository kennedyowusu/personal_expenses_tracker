import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/widgets/custom_button.dart';
import 'package:personal_expenses_tracker/widgets/custom_snackbar.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/helper/validation.dart';

class ForgotPasswordForm extends ConsumerStatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  ForgotPasswordFormState createState() => ForgotPasswordFormState();
}

class ForgotPasswordFormState extends ConsumerState<ForgotPasswordForm> {
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: forgotPasswordFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email Address',
            ),
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            backgroundColor: primaryColor,
            onPressed: () {
              if (forgotPasswordFormKey.currentState?.validate() == true) {
                // TODO: Implement forgot password logic
                CustomSnackBar.show(
                  context: context,
                  message: 'Password reset link sent to your email!',
                );
              }
            },
            text: 'Send Reset Link',
          ),
        ],
      ),
    );
  }
}
