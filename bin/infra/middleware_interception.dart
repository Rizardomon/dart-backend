import 'package:shelf/shelf.dart';

class MiddlewareInterception {
  static Middleware get contentTypeJson => createMiddleware(
        responseHandler: (Response res) => res.change(
          headers: {'content-type': 'application/json'},
        ),
      );

  static Middleware get cors {
    var allowedHeaders = {'Access-Control-Allow-Origin': '*'};

    Response? handlerOption(Request request) {
      if (request.method == 'OPTIONS') {
        return Response(200, headers: allowedHeaders);
      } else {
        return null;
      }
    }

    Response addCorsHeader(Response res) => res.change(
          headers: allowedHeaders,
        );

    return createMiddleware(
      requestHandler: handlerOption,
      responseHandler: addCorsHeader,
    );
  }
}
