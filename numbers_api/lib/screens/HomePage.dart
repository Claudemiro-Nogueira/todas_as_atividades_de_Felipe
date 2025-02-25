import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:numbers_api/screens/TelaNumero.dart';
import 'package:numbers_api/screens/TelaPorData.dart';
import 'package:numbers_api/screens/result_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: const Text("início"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(20), // Define o raio das bordas
                child: Image.network(
                  'https://media.assettype.com/theceo%2Fimport%2F2020%2F08%2FAll-about-Random-Number-Generators-RNGs-and-its-use-cases.jpg',
                  width: 300, // Largura da imagem
                  height: 300, // Altura da imagem
                  fit: BoxFit.cover, // Ajuste da imagem
                ),
              ),

              const SizedBox(height: 24),
              // Botão para ir ao fato aleatório
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        url: 'http://numbersapi.com/random',
                      ),
                    ),
                  ),
                  child: const Text("FATO ALEATORIO"),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
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
                        builder: (context) => SearchByDateScreen(),
                      ),
                    );
                  },
                  child: const Text("PESQUISAR POR DATA"),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
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
                        builder: (context) => Telanumero()
                      ),
                    );
                  },
                  child: const Text("PESQUISAR POR NÚMERO"),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
