import 'package:flutter/material.dart';

class Botoes extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const Botoes({
    super.key,
    required this.text,
    required this.onTap,
  });

// Construção UI
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          //Espaçamento
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            //Cor do botão
            color: Theme.of(context).colorScheme.secondary,
            //Borda do botão
            borderRadius: BorderRadius.circular(12),
          ),

          //Texto
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )),
    );
  }
}
