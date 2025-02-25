import 'dart:convert';
// Irei crirar um classe que tem todas as funções para buscar um fato.
import 'package:flutter/material.dart';
import 'package:numbers_api/routes.dart';
import 'package:numbers_api/screens/NumberFactScreen.dart';
import 'package:numbers_api/screens/home_screen.dart';
import 'package:numbers_api/screens/splash.dart';
import 'package:numbers_api/screens/TelaPorData.dart';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Consumindo api Numbers",
      theme: ThemeData(
          primarySwatch: Colors.cyan), // Depois adicionar constantes de cores
      // home: InitialSplash(), // Aqui estou chamando o splah de iniciar
      home: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
