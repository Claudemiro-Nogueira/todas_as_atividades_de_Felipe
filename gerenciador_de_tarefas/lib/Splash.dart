import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/ListaDeTarefas.dart';

class InitialSplash extends StatefulWidget {
  const InitialSplash({super.key});

  @override
  _InitialSplashState createState() => _InitialSplashState();
}

class _InitialSplashState extends State<InitialSplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ListaDeTarefas()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    "https://cdn-icons-png.flaticon.com/512/15203/15203038.png",
                    height: 150,
                    width: 150,
                  ),
                  const SizedBox(height: 20),
                  const Text(""),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 30), // Espaço inferior opcional
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
