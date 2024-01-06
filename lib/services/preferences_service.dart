import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taku_time/models/user_preferences.dart';
import 'dart:convert';

class PreferencesService {
  Future<UserPreferences> loadPreferences() async {
    debugPrint('Loading preferences');
    final prefs = await SharedPreferences.getInstance();
    String? userPrefsString = prefs.getString('userPreferences');
    if (userPrefsString != null) {
      return UserPreferences.fromMap(json.decode(userPrefsString));
    } else {
      return UserPreferences.defaultPreferences();
    }
  }

  Future<void> updatePreference(String key, dynamic value) async {
    debugPrint('Updating preference $key to $value');
    UserPreferences currentPreferences = await loadPreferences();
    Map<String, dynamic> prefMap = currentPreferences.toMap();
    prefMap[key] = value;
    await savePreferences(UserPreferences.fromMap(prefMap));
  }

  Future<void> savePreferences(UserPreferences preferences) async {
    debugPrint('Saving preferences');
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userPreferences', json.encode(preferences.toMap()));
  }
}
