import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho/components/configuracao_tile.dart';
import 'package:trabalho/themes/theme_provider.dart';

/*

Tela De Configuração

- Tocar o tema do aplicativo

 */

class ConfiguracaoPage extends StatelessWidget {
  const ConfiguracaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      //App Bar
      appBar: AppBar(
        title: const Text("C O N F I G U R A Ç Ã O"),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),

      //body
      body: Column(
        children: [
          // Dark mode
          ConfiguracaoTile(
            title: "Tema Escuro",
            action: CupertinoSwitch(
              onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
              value:
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
            ),
          ),
        ],
      ),
    );
  }
}
