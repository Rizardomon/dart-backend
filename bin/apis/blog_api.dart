import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/noticia_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class BlogApi extends Api {
  final GenericService<NoticiaModel> _service;

  BlogApi(this._service);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    router.get('/blog/noticias', (Request request) async {
      List<NoticiaModel> noticias = await _service.findAll();

      List<Map> noticiasMap = noticias.map((e) => e.toMap()).toList();

      return Response.ok(jsonEncode(noticiasMap));
    });

    router.post('/blog/noticias', (Request request) async {
      var body = await request.readAsString();
      _service.save(NoticiaModel.fromJson(body));
      return Response(201);
    });

    // /blog/noticias?id=123
    router.put('/blog/noticias', (Request request) {
      String? id = request.url.queryParameters['id'];
      // _service.save(id);
      return Response.ok('Choveu hoje');
    });

    router.delete('/blog/noticias', (Request request) {
      String? id = request.url.queryParameters['id'];
      // _service.delete(id);
      return Response.ok('Choveu hoje');
    });

    return createHandler(
        router: router, middlewares: middlewares, isSecurity: isSecurity);
  }
}
