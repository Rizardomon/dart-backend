import '../../apis/blog_api.dart';
import '../../apis/login_api.dart';
import '../../apis/usuario_api.dart';
import '../../dao/usuario_dao.dart';
import '../../models/noticia_model.dart';
import '../../services/generic_service.dart';
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

    di.register<LoginApi>(() => LoginApi(di.get<SecurityService>()));

    di.register<GenericService<NoticiaModel>>(() => NoticiaService());
    di.register<BlogApi>(() => BlogApi(di.get<GenericService<NoticiaModel>>()));

    di.register<UsuarioDAO>(() => UsuarioDAO(di.get<DBConfiguration>()));
    di.register<UsuarioService>(() => UsuarioService(di.get<UsuarioDAO>()));
    di.register<UsuarioApi>(() => UsuarioApi(di.get<UsuarioService>()));

    return di;
  }
}
