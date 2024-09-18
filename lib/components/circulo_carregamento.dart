import 'package:flutter/material.dart';

// aparecer carregamento
void showLoadingCircle(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

//sair circulo de carregamento

void hideLoadingCircle(BuildContext context) {
  Navigator.pop(context);
}
