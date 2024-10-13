// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:trabalho/components/circulo_carregamento.dart';
import 'package:trabalho/services/auth/auth_service.dart';

import '../components/botoes.dart';
import '../components/my_text_field.dart';

// Tela de Registrar-se
class RegistrarPage extends StatefulWidget {
  final void Function()? onTap;
  const RegistrarPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegistrarPage> createState() => _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage> {
  // Acesso ao serviço de Auth
  final _auth = AuthService();

  // Controle Da Caixa de texto
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarsenhaController =
      TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarsenhaController.dispose();
    super.dispose();
  }

  // Registrar o usuário
  void register() async {
    // Verificar se os campos estão preenchidos
    if (emailController.text.isEmpty ||
        senhaController.text.isEmpty ||
        confirmarsenhaController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Preencha todos os campos"),
        ),
      );
      return;
    }

    // Verificar se as senhas coincidem
    if (senhaController.text != confirmarsenhaController.text) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("As senhas estão diferentes!!"),
        ),
      );
      return;
    }

    // Mostrar o círculo de carregamento
    showLoadingCircle(context);

    try {
      // Criar um novo usuário
      await _auth.registerEmailPassword(
        emailController.text.trim(),
        senhaController.text.trim(),
      );

      // Ocultar o círculo de carregamento
      if (mounted) hideLoadingCircle(context);
    } catch (e) {
      // Ocultar o círculo de carregamento
      if (mounted) hideLoadingCircle(context);

      // Exibir o erro
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Erro ao registrar"),
          content: Text(e.toString()),
        ),
      );
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
            child: SingleChildScrollView(
              child: Column(
                // Deixar os itens centralizados no meio da página
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // Logo
                  Icon(
                    Icons.lock_open_rounded,
                    size: 72,
                    color: Theme.of(context).colorScheme.primary,
                  ),

                  const SizedBox(height: 50),

                  Text(
                    "Crie sua conta ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Campo para nome
                  MyTextField(
                    controller: nomeController,
                    hinText: "Digite Seu Nome",
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // Campo para email
                  MyTextField(
                    controller: emailController,
                    hinText: "Digite Seu E-mail",
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // Campo para senha
                  MyTextField(
                    controller: senhaController,
                    hinText: "Digite sua Senha",
                    obscureText: true, // Deixar a senha oculta
                  ),

                  const SizedBox(height: 10),

                  // Campo para confirmar senha
                  MyTextField(
                    controller: confirmarsenhaController,
                    hinText: "Confirme sua senha",
                    obscureText: true, // Deixar a senha oculta
                  ),

                  const SizedBox(height: 25),

                  // Botão de Registrar-se
                  Botoes(
                    text: "Registrar-se",
                    onTap: register,
                  ),

                  const SizedBox(height: 50),

                  // Já tem uma conta?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Já tem uma conta?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Login",
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
      ),
    );
  }
}
