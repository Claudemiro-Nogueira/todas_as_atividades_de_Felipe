import 'package:api_local_image/data/model/model_post.dart';
import 'package:api_local_image/data/repositories/postRepositorie.dart';
import 'package:flutter/material.dart';

class PostsStore {
  final IPostRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<PostModel>> state =
      ValueNotifier<List<PostModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  PostsStore({required this.repository});

  Future getPosts() async {
    isLoading.value = true;

    try {
      final result = await repository.getPosts();
      state.value = result;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}