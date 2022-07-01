import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/dependency_injector.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service.dart';
import 'infra/security/security_service_impl.dart';
import 'services/noticia_service.dart';
import 'utils/custom_env.dart';

void main() async {
  // CustomEnv.fromFile('.env');

  final _di = DependencyInjector();

  _di.register<SecurityService>(() => SecurityServiceImpl(), isSingleton: true);

  var _securityService = _di.get<SecurityService>();

  var cascadeHandler = Cascade()
      .add(LoginApi(_securityService).getHandler())
      .add(BlogApi(NoticiaService()).getHandler(middlewares: [
        _securityService.authorization,
        _securityService.verifyJwt,
      ]))
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'SERVER_ADDRESS'),
    port: await CustomEnv.get<int>(key: 'SERVER_PORT'),
  );
}
