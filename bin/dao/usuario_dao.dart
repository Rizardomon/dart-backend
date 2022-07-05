import '../infra/database/db_configuration.dart';
import '../models/usuario_model.dart';
import 'dao.dart';

class UsuarioDAO implements DAO<UsuarioModel> {
  final DBConfiguration _dbConfiguration;

  UsuarioDAO(this._dbConfiguration);

  @override
  Future<bool> create(UsuarioModel value) async {
    var result = _execQuery(
      'INSERT INTO usuarios (nome, email, password) VALUES (?, ?, ?)',
      [value.name, value.email, value.password],
    );

    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = _execQuery('DELETE from usuarios where id = ?', [id]);

    return result.affectedRows > 0;
  }

  @override
  Future<List<UsuarioModel>> findAll() async {
    var result = _execQuery('SELECT * FROM usuarios');

    return result
        .map((r) => UsuarioModel.fromMap(r.fields))
        .toList()
        .cast<UsuarioModel>();
  }

  @override
  Future<UsuarioModel?> findOne(int id) async {
    var result = _execQuery('SELECT * FROM usuarios WHERE id = ?', [id]);

    return result.affectedRows == 0
        ? null
        : UsuarioModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(UsuarioModel value) async {
    var result = _execQuery(
      'UPDATE usuarios set nome = ?, password = ? where id = ?',
      [value.name, value.password, value.id],
    );

    return result.affectedRows > 0;
  }

  _execQuery(String query, [List? params]) async {
    var connection = await _dbConfiguration.connection;
    return await connection.query(query, params);
  }
}
