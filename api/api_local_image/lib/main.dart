import 'package:api_local_image/screens/Splash.dart';
import 'package:api_local_image/screens/add_post.dart';
import 'package:api_local_image/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.amber,
        ),
      ),
      initialRoute: "/",
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        AddPostScreen.routeName: (context) => const AddPostScreen(),
        InitialSplash.routeName: (context) => const HomeScreen(),
      },
    );
  }
}