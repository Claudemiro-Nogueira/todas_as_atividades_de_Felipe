import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:numbers_api/screens/HomePage.dart';
import 'package:numbers_api/screens/TelaPorData.dart';
import 'package:numbers_api/screens/home_screen.dart';
import 'package:numbers_api/screens/result_screen.dart';
import 'package:numbers_api/screens/splash.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const InitialSplash(); // Tela inicial (Splash)
      },
    ),
    GoRoute(
      path: '/home_page',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage(); // Tela principal
      },
    ),
    GoRoute(
      path: '/tela_data',
      builder: (BuildContext context, GoRouterState state) {
        return const SearchByDateScreen(); // Tela de busca por data
      },
    ),

  ],
);
