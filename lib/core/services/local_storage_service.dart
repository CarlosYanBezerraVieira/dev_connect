abstract class LocalStorageService<T> {
  Future<void> init();
  Future<T?> get(String id);
  Future<List<T>> getAll();
  Future<void> put(String id, T value);
  Future<void> delete(String id);
  Future<void> clear();
}
