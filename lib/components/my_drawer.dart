import 'package:flutter/material.dart';
import 'package:trabalho/components/my_drawer_tile.dart';
import 'package:trabalho/pages/configuracao_page.dart';
import 'package:trabalho/services/auth/auth_service.dart';

/* Onde iremos ter acesso a navbar do aplicativo 

-----------------------------------------------------------------

Ira ter alguns caminhos 

- Home
- Configuração 
- sair

*/

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  // acesso ao serviço de auth
  final _auth = AuthService();

// Sair
  void logout() {
    _auth.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          // Botões da navbar lateral
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              // Logo do aplicativo
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Icon(
                  Icons.person,
                  size: 72,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),

              const SizedBox(height: 10),

              // Pagina principal
              MyDrawerTile(
                title: "I N I C I O",
                icon: Icons.home,
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              // Configuração
              MyDrawerTile(
                title: "C O N F I G U R A Ç Ã O",
                icon: Icons.settings,
                onTap: () {
                  Navigator.pop(context);

                  //Ir para pagina
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfiguracaoPage(),
                    ),
                  );
                },
              ),

              const Spacer(),

              // Sair
              MyDrawerTile(
                title: "S A I R",
                icon: Icons.logout,
                onTap: logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
