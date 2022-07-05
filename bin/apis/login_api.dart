import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security_service.dart';
import '../services/login_servicec.dart';
import '../to/auth_to.dart';
import 'api.dart';

class LoginApi extends Api {
  final SecurityService _securityService;
  final LoginService _loginService;

  LoginApi(this._securityService, this._loginService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    router.post('/login', (Request request) async {
      var body = await request.readAsString();

      var authTO = AuthTO.fromRequest(body);

      var userId = await _loginService.authenticate(authTO);

      if (userId > 0) {
        var token = await _securityService.generateJWT(userId.toString());

        return Response.ok(jsonEncode({
          'token': token,
        }));
      } else {
        return Response(401);
      }
    });

    return createHandler(router: router, middlewares: middlewares);
  }
}
