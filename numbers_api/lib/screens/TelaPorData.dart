import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:numbers_api/screens/result_screen.dart';

class SearchByDateScreen extends StatefulWidget {
  const SearchByDateScreen({super.key});

  @override
  State<SearchByDateScreen> createState() => _SearchByDateScreenState();
}

class _SearchByDateScreenState extends State<SearchByDateScreen> {
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar por Data'),
        // automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _monthController,
              decoration: const InputDecoration(
                labelText: 'Digite o mês (1-12)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _dayController,
              decoration: const InputDecoration(
                labelText: 'Digite o dia',
                border: OutlineInputBorder(),
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
                          url: "http://numbersapi.com/${_monthController.text}/${_dayController.text}")),
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
