import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServerHandler {
  Handler get handler {
    final router = Router();

    router.get(
        '/',
        (Request req) => Response(
              200,
              body: '<h1> Bem vindo ao backend! </h1>',
              headers: {
                'Content-Type': 'text/html',
              },
            ));

    router.get('/teste/<route>',
        (Request req, String route) => Response.ok("Rota $route"));

    router.get('/query', (Request req) {
      String? query = req.url.queryParameters['query'];
      String? query2 = req.url.queryParameters['query2'];
      return Response.ok("Query é: $query e $query2");
    });

    router.post('/login', (Request req) async {
      var result = await req.readAsString();

      Map json = jsonDecode(result);

      var user = json['user'];
      var password = json['password'];

      if (user == 'admin' && password == '123') {
        String jsonResponse = jsonEncode({
          'token': 'hifgvbuifxghbifng',
          'user_id': 1,
        });

        return Response.ok(
          jsonResponse,
          headers: {'Content-Type': 'application/json'},
        );
      } else {
        String jsonResponse = jsonEncode({
          'type': 'Error',
          'message': 'Acesso negado',
        });

        return Response.forbidden(
          jsonResponse,
          headers: {'Content-Type': 'application/json'},
        );
      }
    });

    return router;
  }
}
