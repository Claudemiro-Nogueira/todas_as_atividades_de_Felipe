import 'dart:convert';
import 'dart:typed_data';

import 'package:api_local_image/data/http/http_client.dart';
import 'package:api_local_image/data/model/model_post.dart';
import 'package:api_local_image/data/repositories/postRepositorie.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  static const routeName = '/post_screen';
  final PostModel post;

  const PostScreen({
    super.key,
    required this.post,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final repository = PostRepository(client: HttpClient());

  @override
  Widget build(BuildContext context) {
    Uint8List imageBytes = base64Decode(widget.post.imagem);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre"),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.memory(imageBytes),
            Text(
              widget.post.texto,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
