import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/common/auth_header.dart';
import 'package:personal_expenses_tracker/views/forget_password/widget/forget_password_form.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            AuthHeaderText(
              headerText: 'Forgot Password',
              subHeaderText: 'Enter your email address to reset your password',
            ),
            SizedBox(height: 64),
            ForgotPasswordForm(),
          ],
        ),
      ),
    );
  }
}
