import 'package:flutter_application_1/utils/log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils {
  static SharedPreferences? _prefs;
  static bool _isInitialized = false;

  /// Inisialisasi SharedPreferences (panggil sekali di awal aplikasi)
  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  /// Set String
  static Future<void> setString(String key, String value) async {
    await _waitForInitialization();
    await _prefs?.setString(key, value);
    Log.debug("Saved to SharedPreferences: $key = $value");
  }

  /// Get String
  static Future<String?> getString(String key) async {
    await _waitForInitialization();
    return _prefs?.getString(key);
  }

  /// Set Boolean
  static Future<void> setBool(String key, bool value) async {
    await _waitForInitialization();
    await _prefs?.setBool(key, value);
    Log.debug("Saved to SharedPreferences: $key = $value");
  }

  /// Get Boolean
  static Future<bool?> getBool(String key) async {
    await _waitForInitialization();
    return _prefs?.getBool(key);
  }

  /// Cetak semua SharedPreferences (untuk debugging)
  static Future<void> printAllSharedPreferences() async {
    await _waitForInitialization();
    final allPrefs = _prefs?.getKeys();

    for (String key in allPrefs!) {
      final value = _prefs?.get(key);
      Log.debug('Key: $key, Value: $value');
    }
  }

  /// Tunggu hingga inisialisasi selesai
  static Future<void> _waitForInitialization() async {
    while (!_isInitialized) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }
}
