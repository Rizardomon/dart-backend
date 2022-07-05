import '../models/noticia_model.dart';
import 'generic_service.dart';
import '../utils/list_extension.dart';

class NoticiaService implements GenericService<NoticiaModel> {
  final List<NoticiaModel> _fakeDB = [];
  @override
  Future<bool> delete(int id) async {
    _fakeDB.removeWhere((element) => element.id == id);
    return true;
  }

  @override
  Future<List<NoticiaModel>> findAll() async {
    return _fakeDB;
  }

  @override
  Future<NoticiaModel?> findOne(int id) async {
    return _fakeDB.firstWhere((element) => element.id == id);
  }

  @override
  Future<bool> save(NoticiaModel value) async {
    NoticiaModel? model =
        _fakeDB.firstWhereOrNull((element) => element.id == value.id);

    if (model == null) {
      _fakeDB.add(value);
    } else {
      int index = _fakeDB.indexOf(model);
      _fakeDB[index] = value;
    }

    return true;
  }
}
