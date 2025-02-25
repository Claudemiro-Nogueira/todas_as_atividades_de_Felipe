import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart' as shelf_cors;

void main() async {
  final List<Map<String, dynamic>> posts = [];

  final router = Router();

  router.get(
    '/posts',
    // '/posts',
    (Request request) {
      return Response.ok(
        jsonEncode(posts),
        headers: {'Content-Type': 'application/json'},
      );
    },
  );

  router.post(
    '/posts',
    // '/posts',
    (Request request) async {
      final String body = await request.readAsString();
      final Map<String, dynamic> data = jsonDecode(body);
      posts.add(
        {
          'id': posts.length + 1,
          'texto': data['texto'],
          'imagem': data['imagem'],
          // 'texto': data['texto'],
          // 'imagem': data['imagem'],
        },
      );
      return Response(201, body: 'Post adicionado com sucesso');
    },
  );

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(shelf_cors.corsHeaders(headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Origin, Content-Type',
      }))
      .addHandler(router.call);

  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('Servidor rodando em http://${server.address.host}:${server.port}');
}
