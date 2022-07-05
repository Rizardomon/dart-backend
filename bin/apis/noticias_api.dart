import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/noticia_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class NoticiasApi extends Api {
  final GenericService<NoticiaModel> _service;

  NoticiasApi(this._service);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    router.get('/noticias', (Request request) async {
      List<NoticiaModel> noticias = await _service.findAll();

      List<Map> noticiasMap = noticias.map((e) => e.toJson()).toList();

      return Response.ok(jsonEncode(noticiasMap));
    });

    router.post('/noticias', (Request request) async {
      var body = await request.readAsString();
      var result = await _service.save(
        NoticiaModel.fromRequest(jsonDecode(body)),
      );
      return result ? Response(201) : Response(500);
    });

    router.put('/noticias', (Request request) {
      String? id = request.url.queryParameters['id'];
      // _service.save(id);
      return Response.ok('Choveu hoje');
    });

    router.delete('/noticias', (Request request) {
      String? id = request.url.queryParameters['id'];
      // _service.delete(id);
      return Response.ok('Choveu hoje');
    });

    return createHandler(
        router: router, middlewares: middlewares, isSecurity: isSecurity);
  }
}
