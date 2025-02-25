import 'package:http/http.dart' as http;

// Irei crirar um classe que tem todas as funções para buscar um fato.

class Gerenciadorapi {
  String nome;

  Gerenciadorapi(this.nome);


    // Função que retorna o dado da API
  Future<void> fechNumbersApi() async {
    const apiUrl = 'http://numbersapi.com/random/year';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
          print(response.body);
          nome = response.body;
      } else {
        throw Exception('Falha ao carregar os dados');
      }
    } catch (error) {
      print(error);
    }
  }


}
