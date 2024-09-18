import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hinText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hinText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        //Aparece a borda assim que for acionado a caixa de texto
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          borderRadius: BorderRadius.circular(12),
        ),
        // Borda
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        hintText: hinText,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
