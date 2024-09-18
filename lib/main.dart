import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho/firebase_options.dart';
import 'package:trabalho/services/auth/auth_guarante.dart';
import 'package:trabalho/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';

//firebase

//run app
main() async {
  //firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "trabalho", options: DefaultFirebaseOptions.currentPlatform);

  //run app
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
