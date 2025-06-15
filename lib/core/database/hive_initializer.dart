import 'package:hive_flutter/hive_flutter.dart';

class HiveInitializer {
  static bool _isInitialized = false;

  static Future<void> init() async {
    if (_isInitialized) return;

    await Hive.initFlutter();
    _isInitialized = true;
  }


  static Future<Box> openBox(String boxName) async {
    if (!_isInitialized) {
      await init();
    }
    return await Hive.openBox(boxName);
  }

  static Box getBox(String boxName) {
    if (!_isInitialized) {
      throw Exception(
          'Hive has not been initialized. Call HiveInitializer.init() first.');
    }
    return Hive.box(boxName);
  }
}
