import 'package:test/test.dart';

import '../../../bin/models/usuario_model.dart';

void main() {
  var usuario = UsuarioModel.create(
    1,
    'Richard',
    'richard@email.com',
    true,
    DateTime(2022),
    DateTime(2022),
  );

  Map<String, dynamic> map = {
    'id': 1,
    'nome': 'Richard',
    'email': 'richard@email.com',
    'is_ativo': 1,
    'dt_criacao': DateTime(2022),
    'dt_atualizacao': DateTime(2022),
  };

  test('Should return a UsuarioModel', () {
    expect(usuario.id, 1);
    expect(usuario.name, 'Richard');
    expect(usuario.email, 'richard@email.com');
    expect(usuario.dtCreated, DateTime(2022));
    expect(usuario.dtUpdated, DateTime(2022));
  });

  test('Should return a UsuarioModel from a map', () {
    var usuarioFromMap = UsuarioModel.fromMap(map);

    expect(usuarioFromMap, usuario);
  });

  test('Should return a UsuarioModel from a request', () {
    Map<String, dynamic> map = {
      'name': 'Richard',
      'email': 'richard@email.com',
      'password': '123',
    };

    var usuario = UsuarioModel.fromRequest(map);

    expect(usuario.name, 'Richard');
    expect(usuario.email, 'richard@email.com');
    expect(usuario.password, '123');
  });

  test('Should return a UsuarioModel from email', () {
    Map<String, dynamic> map = {
      'id': 1,
      'password': '123',
    };

    var usuario = UsuarioModel.fromEmail(map);

    expect(usuario.id, 1);
    expect(usuario.password, '123');
  });

  test('Should return a NoticiaModel toString', () {
    var usuario = UsuarioModel.fromMap(map);
    var usuarioToString = usuario.toString();

    expect(usuarioToString,
        'UsuarioModel(id: 1, name: Richard, email: richard@email.com, isActive: true, dtCreated: 2022-01-01 00:00:00.000, dtUpdated: 2022-01-01 00:00:00.000)');
  });
}
