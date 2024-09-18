import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/pages/home_page.dart';
import 'package:trabalho/services/auth/login_ou_registrar.dart';

/* 
        Aqui sera feita a checagem se o usuario esta logado ou não.
--------------------------------------------------------------------------
        Se o usuario estiver logado -> vai para home page
        Ou
        Se o usuario nao estiver logado -> vai para pagina de login ou registrar
*/

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //Usuario logado
          if (snapshot.hasData) {
            return const HomePage();
          }

          //Se o Usuario não estiver logado
          else {
            return const LoginOuRegistrar();
          }
        },
      ),
    );
  }
}
