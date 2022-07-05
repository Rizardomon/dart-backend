abstract class DAO<T> {
  // CRUD methods
  Future create(T value);

  Future<T> findOne(int id);

  Future<List<T>> findAll();

  Future update(T value);

  Future delete(int id);
}
