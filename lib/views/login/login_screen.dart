import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/common/auth_header.dart';
import 'package:personal_expenses_tracker/common/auth_prompt_text.dart';
import 'package:personal_expenses_tracker/views/login/widgets/login_form.dart';
import 'package:personal_expenses_tracker/views/register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                headerText: 'Welcome Back!',
                subHeaderText: 'Login to your account',
              ),
              const SizedBox(height: 64),
              const LoginForm(),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.center,
                child: AuthPromptText(
                  questionText: "Don't have an account?",
                  actionText: ' Register',
                  onActionTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const RegisterScreen();
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
