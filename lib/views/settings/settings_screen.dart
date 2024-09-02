import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expenses_tracker/widgets/custom_app_bar.dart';
import 'package:personal_expenses_tracker/widgets/custom_border_button.dart';
import 'package:personal_expenses_tracker/widgets/custom_button.dart';
import 'package:personal_expenses_tracker/constants/colors.dart';
import 'package:personal_expenses_tracker/constants/images.dart';
import 'package:personal_expenses_tracker/utils/secure_storage.dart';
import 'package:personal_expenses_tracker/views/login/login_screen.dart';
import 'package:personal_expenses_tracker/views/settings/widgets/settings_options_tile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Settings',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(profile),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: 8),
              const Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ExpenseTrackerCustomButton(
                onPressed: () {},
                text: 'Edit Profile',
                backgroundColor: primaryColor,
              ),
              const SizedBox(height: 16),
              SettingsOptionTile(
                leadingIcon: Icons.receipt_long,
                title: 'Transaction History',
                onTap: () {},
              ),
              SettingsOptionTile(
                leadingIcon: Icons.payment,
                title: 'Payment',
                onTap: () {},
              ),
              SettingsOptionTile(
                leadingIcon: Icons.security,
                title: 'Security',
                onTap: () {},
              ),
              SettingsOptionTile(
                leadingIcon: Icons.contact_mail,
                title: 'Contact Us',
                onTap: () {},
              ),
              const Spacer(),
              CustomExpenseTrackerBorderButton(
                textColor: Colors.red,
                borderColor: Colors.red,
                onPressed: () async {
                  await LadderSecureStorage().deleteAccessToken();

                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  }
                },
                text: 'Logout',
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
