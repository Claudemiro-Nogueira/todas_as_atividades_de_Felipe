import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaDeTarefas extends StatefulWidget {
  @override
  _ListaDeTarefasState createState() => _ListaDeTarefasState();
}

class _ListaDeTarefasState extends State<ListaDeTarefas> {
  List<String> tarefas = [];

  @override
  void initState() {
    super.initState();
    carregarTarefas();
  }

  Future<void> carregarTarefas() async {
    // Cria uma instancia do shared preference para persistir os dados
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // retorna uma lista de strings
      // ['Comprar leite', 'Estudar Flutter', 'Fazer exercícios']
      tarefas = prefs.getStringList('tarefas') ?? [];
    });
  }

  Future<void> salvarTarefas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('tarefas', tarefas);
  }

  void adicionarTarefa(String tarefa) {
    setState(() {
      tarefas.add(tarefa);
    });
    salvarTarefas();
  }

  void editarTarefa(int index, String novaTarefa) {
    setState(() {
      tarefas[index] = novaTarefa;
    });
    salvarTarefas();
  }

  void excluirTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
    salvarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text(
          'Gerenciador de Tarefas',
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            elevation: 6, // Maior sombreamento
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20), // Bordas mais arredondadas
            ),
            color: Colors.white, // Cor de fundo do Card
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  vertical: 12, horizontal: 20), // Padding para o texto
              title: Text(
                tarefas[index],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // Texto em negrito
                  color: Colors.blueGrey, // Cor do texto
                ),
              ),
              subtitle: Text(
                'Toque para editar ou excluir', // Subtítulo com mais informações
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ícone de editar com efeito visual
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () =>
                        _mostrarDialogoEditar(index, tarefas[index]),
                    tooltip:
                        'Editar Tarefa', // Texto que aparece ao segurar o ícone
                  ),
                  // Ícone de excluir com animação
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => excluirTarefa(index),
                    tooltip: 'Excluir Tarefa',
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _mostrarDialogoAdicionar,
      ),
    );
  }

  void _mostrarDialogoAdicionar() {
    String novaTarefa = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adicionar Tarefa'),
        content: TextField(
          onChanged: (value) {
            novaTarefa = value;
          },
          decoration: InputDecoration(
            hintText: 'Digite a nova tarefa',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Adicionar'),
            onPressed: () {
              if (novaTarefa.isNotEmpty) {
                adicionarTarefa(novaTarefa);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoEditar(int index, String tarefaAtual) {
    String tarefaAtualizada = tarefaAtual;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Tarefa'),
        content: TextField(
          controller: TextEditingController(text: tarefaAtual),
          onChanged: (value) {
            tarefaAtualizada = value;
          },
          decoration: InputDecoration(
            hintText: 'Atualize a tarefa',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Atualizar'),
            onPressed: () {
              if (tarefaAtualizada.isNotEmpty) {
                editarTarefa(index, tarefaAtualizada);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
