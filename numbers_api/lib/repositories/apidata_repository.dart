import 'package:numbers_api/http/http_client.dart';
import 'package:numbers_api/models/apidata_model.dart';

class ApiDataRepository {
  final IHttpClient client;

  ApiDataRepository({
    required this.client,
  });

  Future<List<ApiDataModel>> getData(String url) async {
    final response = await client.get(url: url);
    try {
      final data = response.body;
      return [ApiDataModel.fromString(data)];
    } catch (e) {
      throw Exception(e);
    }
  }
}
