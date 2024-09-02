import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/common/custom_button.dart';
import 'package:personal_expenses_tracker/common/input_error.dart';
import 'package:personal_expenses_tracker/common/password_input_field.dart';
import 'package:personal_expenses_tracker/helper/validation.dart';
import 'package:personal_expenses_tracker/views/register/providers/register_with_email_provider.dart';
import 'package:personal_expenses_tracker/views/tab_layout.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends ConsumerState<RegisterForm> {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ref.watch(registerWithEmailProvider).registerWithEmailFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              labelText: 'Full Name',
            ),
            onChanged: (value) {
              ref.read(registerWithEmailProvider.notifier).onNameChanged(value);
            },
            validator: validateFullName,
          ),
          const SizedBox(height: 16),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              labelText: 'Email Address',
            ),
            onChanged: (value) {
              ref
                  .read(registerWithEmailProvider.notifier)
                  .onEmailChanged(value);
            },
            validator: validateEmail,
          ),
          const SizedBox(height: 16),
          PasswordInputField(
            isTextObscured:
                ref.watch(registerWithEmailProvider).isPasswordVisible
                    ? false
                    : true,
            labelText: 'Password',
            toggleVisibility: () {
              ref
                  .read(registerWithEmailProvider.notifier)
                  .togglePasswordVisibility();
            },
            onChanged: (value) {
              ref
                  .read(registerWithEmailProvider.notifier)
                  .onPasswordChanged(value);
            },
            validator: validateStrongPassword,
          ),
          const SizedBox(height: 16),
          PasswordInputField(
            labelText: 'Confirm Password',
            isTextObscured:
                ref.watch(registerWithEmailProvider).isPasswordVisible
                    ? false
                    : true,
            toggleVisibility: () {
              ref
                  .read(registerWithEmailProvider.notifier)
                  .togglePasswordVisibility();
            },
            onChanged: (value) {
              ref
                  .read(registerWithEmailProvider.notifier)
                  .onConfirmPasswordChanged(value);
            },
            validator: (value) => validatePasswordMatch(
              ref.read(registerWithEmailProvider).password,
              value,
            ),
          ),
          ErrorTextWidget(
            errorText: ref.watch(registerWithEmailProvider).errorMessage,
          ),
          const SizedBox(height: 16),
          ExpenseTrackerCustomButton(
            text: "Next",
            isLoading: ref.watch(registerWithEmailProvider).isLoading,
            onPressed: () async {
              if (!ref
                  .read(registerWithEmailProvider)
                  .registerWithEmailFormKey
                  .currentState!
                  .validate()) {
                return;
              }

              final (res, _) = await ref
                  .read(registerWithEmailProvider.notifier)
                  .registerWithEmail();

              if (res?.data != null) {
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => TabLayout(),
                    ),
                    (route) => false,
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
