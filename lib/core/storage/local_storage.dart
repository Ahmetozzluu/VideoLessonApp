/*import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final _box = GetStorage();

  Future<void> saveString(String key, String value) async {
    await _box.write(key, value);
  }

  String? getString(String key) {
    return _box.read(key);
  }

  Future<void> clear() async {
    await _box.remove('email');
    await _box.remove('password');
  }
}
*/