import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

void main() async {
  // CustomEnv.fromFile('.env');

  var conexao = await MySqlConnection.connect(ConnectionSettings(
    host: await CustomEnv.get<String>(key: 'DB_HOST'),
    port: await CustomEnv.get<int>(key: 'DB_PORT'),
    user: await CustomEnv.get<String>(key: 'DB_USER'),
    password: await CustomEnv.get<String>(key: 'DB_PASS'),
    db: await CustomEnv.get<String>(key: 'DB_SCHEMA'),
  ));

  var result = await conexao.query('SELECT * FROM usuarios;');

  print(result);

  final _di = Injects.initialize();

  var cascadeHandler = Cascade()
      .add(_di.get<LoginApi>().getHandler())
      .add(_di.get<BlogApi>().getHandler(isSecurity: true))
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
