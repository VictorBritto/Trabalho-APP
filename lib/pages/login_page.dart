// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:trabalho/components/botoes.dart';
import 'package:trabalho/components/circulo_carregamento.dart';
import 'package:trabalho/components/my_text_field.dart';
import 'package:trabalho/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //acessar o serviço de auth
  final _auth = AuthService();

  // Controle Da Caixa de texto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  // metodo login
  void login() async {
    // mostrar circulo de carregamento
    showLoadingCircle(context);

    //Etapa de login
    try {
      //fazendo o login
      await _auth.loginEmailPassword(
          emailController.text, senhaController.text);

      //acabando a faze de carregamento
      if (mounted) hideLoadingCircle(context);
    } catch (e) {
      //acabando a faze de carregamento
      if (mounted) hideLoadingCircle(context);

      //caso apresente algum erro para o usuario
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      // Body
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              //Deixa os itens centralizados no meio da pagina
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                //logo
                Icon(
                  Icons.lock_open_rounded,
                  size: 72,
                  color: Theme.of(context).colorScheme.primary,
                ),

                const SizedBox(height: 50),

                Text(
                  "Bem-vindo de volta, você fez falta!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),

                //Email para o login
                MyTextField(
                    controller: emailController,
                    hinText: "Digite Seu E-mail",
                    obscureText: false),

                const SizedBox(height: 10),
                //Senha para o login
                MyTextField(
                    controller: senhaController,
                    hinText: "Digite sua Senha",
                    //deixa a senha oculta
                    obscureText: true),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Esqueceu sua Senha?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 25),

                Botoes(
                  text: "Login",
                  onTap: login,
                ),

                const SizedBox(height: 50),
                // Não tenho conta
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Não e membro ainda?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    //
                    const SizedBox(width: 5),
                    //
                    //Botão para usario que não conta
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Registrar-se",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
