import 'dart:developer';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../utils/custom_env.dart';
import 'security_service.dart';
import 'validate/api_router_validate.dart';

class SecurityServiceImpl implements SecurityService<JWT> {
  @override
  Future<String> generateJWT(String userId) async {
    var jwt = JWT({
      'iat': DateTime.now().millisecondsSinceEpoch,
      'userId': userId,
      'roles': ['admin', 'user']
    });

    String key = await CustomEnv.get<String>(key: 'JWT_KEY');

    return jwt.sign(SecretKey(key));
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    String key = await CustomEnv.get<String>(key: 'JWT_KEY');

    try {
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidError {
      return null;
    } on JWTExpiredError {
      return null;
    } on JWTNotActiveError {
      return null;
    } on JWTUndefinedError {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Middleware get authorization => (Handler handler) => (Request req) async {
        String? authorizationHeader = req.headers['Authorization'];

        JWT? jwt;

        if (authorizationHeader != null) {
          if (authorizationHeader.startsWith('Bearer ')) {
            String token = authorizationHeader.substring(7);

            log('JWT token: ' + token);

            jwt = await validateJWT(token);
          }
        }

        Request requestChanged = req.change(context: {'jwt': jwt});

        return handler(requestChanged);
      };

  @override
  Middleware get verifyJwt => createMiddleware(requestHandler: (Request req) {
        var _apiSecurity = ApiRouterValidate().add('login');

        if (_apiSecurity.isPublic(req.url.path)) return null;

        if (req.context['jwt'] == null) {
          return Response.forbidden('Not authorized');
        }
        log('Authorized: ${req.context['jwt']}');
        return null;
      });
}
