import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:numbers_api/screens/result_screen.dart';

class Telanumero extends StatefulWidget {
  const Telanumero({super.key});

  @override
  State<Telanumero> createState() => _TelanumeroState();
}

class _TelanumeroState extends State<Telanumero> {
  final TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar Fato por Número'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _numberController,
              decoration: const InputDecoration(
                labelText: 'Digite um número',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                      url: 'http://numbersapi.com/${_numberController.text}/math',
                    ),
                  ),
                );
              },
              child: const Text('Buscar Fato'),
            ),
          ],
        ),
      ),
    );
  }
}
