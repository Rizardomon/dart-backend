import 'package:test/test.dart';

import '../../../bin/models/noticia_model.dart';

void main() {
  test('Should return a NoticiaModel from a map', () {
    Map<String, dynamic> map = {
      'id': 1,
      'titulo': 'titulo',
      'descricao': 'descricao',
      'dt_criacao': DateTime(2022),
      'dt_atualizacao': DateTime(2022),
      'id_usuario': 2,
    };

    var noticia = NoticiaModel.fromMap(map);

    expect(noticia.id, 1);
    expect(noticia.title, 'titulo');
    expect(noticia.description, 'descricao');
    expect(noticia.dtCreated, DateTime(2022));
    expect(noticia.dtUpdated, DateTime(2022));
    expect(noticia.userId, 2);
  });

  test('Should return a NoticiaModel from a request', () {
    Map<String, dynamic> map = {
      'id': 1,
      'title': 'titulo',
      'description': 'descricao',
      'userId': 2,
    };

    var noticia = NoticiaModel.fromRequest(map);

    expect(noticia.id, 1);
    expect(noticia.title, 'titulo');
    expect(noticia.description, 'descricao');
    expect(noticia.dtCreated, null);
    expect(noticia.dtUpdated, null);
    expect(noticia.userId, 2);
  });

  test('Should return a NoticiaModel toString', () {
    Map<String, dynamic> map = {
      'id': 1,
      'titulo': 'titulo',
      'descricao': 'descricao',
      'dt_criacao': DateTime(2022),
      'dt_atualizacao': DateTime(2022),
      'id_usuario': 2,
    };

    var noticia = NoticiaModel.fromMap(map);
    var noticiaToString = noticia.toString();

    expect(noticiaToString,
        'NoticiaModel(id: 1, title: titulo, description: descricao, dtCreated: 2022-01-01 00:00:00.000, dtUpdated: 2022-01-01 00:00:00.000, userId: 2)');
  });
}
