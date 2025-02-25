import 'package:flutter/material.dart';
import 'package:numbers_api/models/apidata_model.dart';
import 'package:numbers_api/repositories/apidata_repository.dart';

class ApiDataStore {
  final ApiDataRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<ApiDataModel>> state =
      ValueNotifier<List<ApiDataModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ApiDataStore({
    required this.repository,
  });

  Future getData(String url) async {
    isLoading.value = true;

    try {
      final result = await repository.getData(url);
      state.value = result;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
