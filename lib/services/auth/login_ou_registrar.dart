import 'package:flutter/material.dart';
import 'package:trabalho/pages/login_page.dart';
import 'package:trabalho/pages/registrar_page.dart';

class LoginOuRegistrar extends StatefulWidget {
  const LoginOuRegistrar({super.key});

  @override
  State<LoginOuRegistrar> createState() => _LoginOuRegistrarMyWidgetState();
}

class _LoginOuRegistrarMyWidgetState extends State<LoginOuRegistrar> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegistrarPage(
        onTap: togglePages,
      );
    }
  }
}
