import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InitialSplash extends StatefulWidget {
  const InitialSplash({super.key});

  @override
  State<InitialSplash> createState() => _InitialSplashState();
}

class _InitialSplashState extends State<InitialSplash> {
  @override
  void initState() {
    super.initState();
    // Navegação após a splash
    Future.delayed(Duration(seconds: 3), () {
      context.go('/home_page'); // Navega para a rota especificada
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.network(
        "https://cdn-icons-png.flaticon.com/512/179/179349.png",
        height: 500,
        width: 500,
      ),
      backgroundColor: Colors.blueGrey,
      showLoader: true,
      loadingText: const Text("Carregando"),
      durationInSeconds: 3, // Duração é controlada pelo initState
    );
  }
}
