import 'package:flutter/material.dart';
import 'package:numbers_api/http/http_client.dart';
import 'package:numbers_api/repositories/apidata_repository.dart';
import 'package:numbers_api/screens/store/apidata_store.dart';

class ResultScreen extends StatefulWidget {
  final String url;

  const ResultScreen({
    super.key,
    required this.url,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final ApiDataStore store = ApiDataStore(
    repository: ApiDataRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getData(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          store.isLoading,
          store.state,
          store.erro,
        ]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (store.erro.value.isNotEmpty) {
            return Center(
              child: Icon(Icons.error),
            );
          }
          final data = store.state.value[0].data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      data,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Voltar'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
