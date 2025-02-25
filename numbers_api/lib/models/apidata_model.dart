class ApiDataModel {
  final String data;

  ApiDataModel({
    required this.data,
  });

  factory ApiDataModel.fromString(String response) {
    return ApiDataModel(data: response);
  }
}