import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/utils/secure_storage.dart';
import 'package:personal_expenses_tracker/views/login/login_screen.dart';
import 'package:personal_expenses_tracker/views/tab_layout.dart';

class LadderApp extends StatefulWidget {
  const LadderApp({super.key});

  @override
  State<LadderApp> createState() => _LadderAppState();
}

class _LadderAppState extends State<LadderApp> {
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String authToken = await LadderSecureStorage().getAccessToken();
      if (authToken.isNotEmpty) {
        setState(() {
          isAuthenticated = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isAuthenticated ? const TabLayout() : const LoginScreen();
  }
}
