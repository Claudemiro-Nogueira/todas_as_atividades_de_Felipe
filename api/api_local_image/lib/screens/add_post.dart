import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:api_local_image/data/model/model_post.dart';
import 'package:api_local_image/data/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data/repositories/postRepositorie.dart';

class AddPostScreen extends StatefulWidget {
  static const routeName = '/add-post';

  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final repository = PostRepository(client: HttpClient());
  late String text = '';
  late String base64Image = '';
  XFile? _image;

  _changeText(String value) {
    setState(() {
      text = value;
    });
  }

  _setBase64Image(XFile image) async {
    final bytes = await image.readAsBytes(); // Lendo os bytes da imagem
    setState(() {
      base64Image = base64Encode(bytes);
    });
  }

  _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
        });
        _setBase64Image(_image!);
      }
    } catch (e) {
      log("Erro ao selecionar imagem: $e");
    }
  }

  _createPost(String text, String image) {
    repository.createPost(
      PostModel(
        id: 0,
        texto: text,
        imagem: image,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicione uma imagem"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: const Text('Adicionar imagem'),
                trailing: _image == null
                    ? const Icon(Icons.image, color: Colors.grey)
                    : Image.file(
                        File(_image!.path),
                        height: 100,
                      ),
                onTap: _pickImage,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              TextFormField(
                onChanged: (value) => _changeText(value),
                decoration: InputDecoration(
                  hintText: 'Descrição do post',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(.6)),
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              // Text(text),
              ElevatedButton(
                onPressed: () {
                  if (text != '' || _image != null) {
                    _createPost(text, base64Image);
                    Navigator.pop(context, true);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Insira uma imagem e um texto!'),
                        showCloseIcon: true,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                child: const Text('Criar post'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
