import 'dart:convert';
import 'dart:typed_data';

import 'package:api_local_image/data/http/http_client.dart';
import 'package:api_local_image/data/repositories/postRepositorie.dart';
import 'package:api_local_image/data/store/post_store.dart';
import 'package:api_local_image/screens/add_post.dart';
import 'package:api_local_image/screens/post_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostsStore store = PostsStore(
    repository: PostRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Postagens"),
        backgroundColor: Colors.amber,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await store.getPosts();
        },
        child: AnimatedBuilder(
          animation: Listenable.merge([
            store.isLoading,
            store.erro,
            store.state,
          ]),
          builder: (context, child) {
            if (store.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (store.erro.value.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error),
                    Text(store.erro.value),
                  ],
                ),
              );
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Define 2 colunas
                crossAxisSpacing: 8.0, // Espaço horizontal entre os itens
                mainAxisSpacing: 4.0, // Espaço vertical entre os itens
                childAspectRatio:
                    0.7, // Ajuste para que as células fiquem mais retangulares
              ),
              itemCount: store.state.value.length,
              itemBuilder: (context, index) {
                final item = store.state.value[index];
                Uint8List imageBytes = base64Decode(item.imagem);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostScreen(post: item),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 150, // Tamanho fixo para a imagem
                            width: double.infinity,
                            child: Image.memory(
                              imageBytes,
                              fit: BoxFit
                                  .cover, // A imagem será cortada para cobrir a área
                            ),
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          item.texto,
                          style: const TextStyle(fontSize: 16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(
            context,
            AddPostScreen.routeName,
          );

          if (result == true) {
            store.getPosts();
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
