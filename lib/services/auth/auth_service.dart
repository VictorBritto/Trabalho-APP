import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instância do FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Obter o ID do usuário atual
  User? getCurrentUser() => _auth.currentUser;

  String getCurrentUid() {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      return currentUser.uid;
    } else {
      throw Exception("Usuário não autenticado");
    }
  }

  // Login -> email & senha
  Future<UserCredential> loginEmailPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception("Erro de autenticação: ${e.code}");
    }
  }

  // Registrar -> email & senha
  Future<UserCredential> registerEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception("Erro de registro: ${e.code}");
    }
  }

  // Sair do sistema
  Future<void> logout() async {
    try {
      await _auth.signOut();
      print("Usuário deslogado com sucesso");
    } catch (e) {
      print("Erro ao tentar fazer logout: $e");
      throw Exception("Erro ao deslogar");
    }
  }
}
