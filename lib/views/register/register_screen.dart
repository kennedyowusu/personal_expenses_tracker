import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/widgets/auth_header.dart';
import 'package:personal_expenses_tracker/widgets/auth_prompt_text.dart';
import 'package:personal_expenses_tracker/views/login/login_screen.dart';
import 'package:personal_expenses_tracker/views/register/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              const AuthHeaderText(
                headerText: 'Create Account',
                subHeaderText: 'Sign up to get started',
              ),
              const SizedBox(height: 32),
              const RegisterForm(
                key: Key('register_form_key'),
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.center,
                child: AuthPromptText(
                  questionText: 'Already have an account?',
                  actionText: ' Login',
                  onActionTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
