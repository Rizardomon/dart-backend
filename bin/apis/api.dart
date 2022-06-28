import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({
    List<Middleware>? middlewares,
  });

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
  }) {
    middlewares ??= [];
    var pipe = Pipeline();

    // ignore: avoid_function_literals_in_foreach_calls
    middlewares.forEach((middleware) => pipe = pipe.addMiddleware(middleware));

    return pipe.addHandler(router);
  }
}
