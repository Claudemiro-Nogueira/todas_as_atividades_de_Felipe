import 'package:flutter/material.dart';
import 'package:numbers_api/screens/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  ResultScreen(url: 'http://numbersapi.com/random',),
                            ),),
                child: Text('aleatorio'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  ResultScreen(url: 'http://numbersapi.com/2/29/date',),
                            ),),
                child: Text('data 29/02'),
              ),
              TextFormField(
                
              )
            ],
          ),
        ),
      ),
    );
  }
}
