import 'package:dev_connect/core/db/local_storage_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveLocalStorageService<T> implements LocalStorageService<T> {
  late final Box<T> _box;
  final String boxName;

  HiveLocalStorageService(this.boxName);

  @override
  Future<void> init() async {
    _box = await Hive.openBox<T>(boxName);
  }

  @override
  Future<T?> get(String id) async {
    return _box.get(id);
  }

  @override
  Future<List<T>> getAll() async {
    return _box.values.toList();
  }

  @override
  Future<void> put(String id, T value) async {
    await _box.put(id, value);
  }

  @override
  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }
}
