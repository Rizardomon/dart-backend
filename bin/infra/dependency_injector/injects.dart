import '../../apis/noticias_api.dart';
import '../../apis/login_api.dart';
import '../../apis/usuario_api.dart';
import '../../dao/noticia_dao.dart';
import '../../dao/usuario_dao.dart';
import '../../models/noticia_model.dart';
import '../../services/generic_service.dart';
import '../../services/login_servicec.dart';
import '../../services/noticia_service.dart';
import '../../services/usuario_service.dart';
import '../database/db_configuration.dart';
import '../database/mysql_db_configuration.dart';
import '../security/security_service.dart';
import '../security/security_service_impl.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<DBConfiguration>(() => MySqlDBConfiguration());

    di.register<SecurityService>(() => SecurityServiceImpl());

    // Noticias dependencies
    di.register<NoticiaDAO>(() => NoticiaDAO(di.get<DBConfiguration>()));
    di.register<GenericService<NoticiaModel>>(
        () => NoticiaService(di.get<NoticiaDAO>()));
    di.register<NoticiasApi>(
        () => NoticiasApi(di.get<GenericService<NoticiaModel>>()));

    // User dependencies
    di.register<UsuarioDAO>(() => UsuarioDAO(di.get<DBConfiguration>()));
    di.register<UsuarioService>(() => UsuarioService(di.get<UsuarioDAO>()));
    di.register<UsuarioApi>(() => UsuarioApi(di.get<UsuarioService>()));

    // Login dependencies
    di.register<LoginService>(() => LoginService(di.get<UsuarioService>()));
    di.register<LoginApi>(() => LoginApi(
          di.get<SecurityService>(),
          di.get<LoginService>(),
        ));

    return di;
  }
}
