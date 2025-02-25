import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/Splash.dart';


void main() {
  runApp(GerenciadorDeTarefasApp());
}

class GerenciadorDeTarefasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
         // Fundo mais moderno
      ),
      home: InitialSplash(),
    );
  }
}
