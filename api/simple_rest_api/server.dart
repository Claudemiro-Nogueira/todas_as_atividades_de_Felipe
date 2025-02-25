import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:path/path.dart' as path;

void main() async {
  final router = Router();

  // Endpoint de upload de dados
  router.post('/upload', (Request request) async {
    final contentType = request.headers[HttpHeaders.contentTypeHeader];
    if (contentType == null || !contentType.startsWith('multipart/form-data')) {
      return Response(400, body: 'Content-Type must be multipart/form-data');
    }

    final boundary = contentType.split('boundary=')[1];
    final parts = await _parseMultipart(request, boundary);

    String? title;
    String? description;
    File? image;

    // Processa as partes do formulário
    for (final part in parts) {
      final contentDisposition = part.headers['content-disposition'];
      if (contentDisposition != null) {
        final name = RegExp(r'name="(.+?)"').firstMatch(contentDisposition)?.group(1);
        if (name == 'title') {
          title = utf8.decode(part.content);
        } else if (name == 'description') {
          description = utf8.decode(part.content);
        } else if (name == 'image') {
          final fileName = RegExp(r'filename="(.+?)"')
              .firstMatch(contentDisposition)
              ?.group(1);
          if (fileName != null) {
            final tempDir = Directory.systemTemp.createTempSync();
            final file = File(path.join(tempDir.path, fileName));
            await file.writeAsBytes(part.content);
            image = file;
          }
        }
      }
    }

    if (title != null && description != null && image != null) {
      // Salva a imagem redimensionada (se necessário)
      final fileName = 'resized_${path.basename(image.path)}';
      final savedFile = await image.copy(path.join(Directory.systemTemp.path, fileName));
      
      return Response.ok(
          'Upload successful: title=$title, description=$description, image=${savedFile.path}');
    } else {
      return Response(400, body: 'Invalid upload data');
    }
  });

  // Endpoint de teste
  router.get('/test', (Request request) {
    final response = {
      'message': 'API está funcionando corretamente!',
      'timestamp': DateTime.now().toIso8601String()
    };
    return Response.ok(jsonEncode(response),
        headers: {'Content-Type': 'application/json'});
  });

  // Listar entradas
  router.get('/entries', (Request request) async {
    final dir = Directory.systemTemp;
    final files = await dir.list().toList();
    final entries = files
        .whereType<File>()
        .where((file) => file.path.contains('resized_'))
        .map((file) => {
              'title': path.basenameWithoutExtension(file.path).replaceFirst('resized_', ''),
              'description': 'Description for ${path.basename(file.path)}',
              'image': file.path
            })
        .toList();
    return Response.ok(jsonEncode(entries),
        headers: {'Content-Type': 'application/json'});
  });

  // Adicionar middleware CORS
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(router);

  final server = await io.serve(handler, '0.0.0.0', 8080);

  print('Server listening on port ${server.port}');
}

Future<List<_Multipart>> _parseMultipart(
    Request request, String boundary) async {
  final transformer =
      StreamTransformer<Uint8List, _Multipart>.fromHandlers(handleData: (data, sink) {
    final boundaryBytes = utf8.encode("--$boundary");
    int start = 0;

    while (start < data.length) {
      final end = _indexOf(data, boundaryBytes, start);
      if (end == -1) {
        break;
      }

      final partData = data.sublist(start, end);
      final headersEnd = _indexOf(partData, utf8.encode("\r\n\r\n"), 0);

      if (headersEnd == -1) {
        start = end + boundaryBytes.length;
        continue;
      }

      final headersData = partData.sublist(0, headersEnd);
      final contentData = partData.sublist(headersEnd + 4);

      final headers = <String, String>{};
      final headersLines = utf8.decode(headersData).split('\r\n');
      for (final line in headersLines) {
        final headerParts = line.split(': ');
        if (headerParts.length == 2) {
          headers[headerParts[0]] = headerParts[1];
        }
      }

      sink.add(_Multipart(headers, contentData));
      start = end + boundaryBytes.length;
    }
  });

  return await request.read().transform(transformer).toList();
}

int _indexOf(List<int> data, List<int> pattern, int start) {
  for (int i = start; i <= data.length - pattern.length; i++) {
    bool found = true;
    for (int j = 0; j < pattern.length; j++) {
      if (data[i + j] != pattern[j]) {
        found = false;
        break;
      }
    }
    if (found) {
      return i;
    }
  }
  return -1;
}

class _Multipart {
  final Map<String, String> headers;
  final List<int> content;

  _Multipart(this.headers, this.content);
}
