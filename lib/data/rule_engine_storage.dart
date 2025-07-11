import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_todo_app_tibicle_pratical/model/rule_engine_model.dart';

class RuleEngineSettingsStorage {
  static const String _key = 'rule_settings';

  static Future<RuleEngineSettingModel> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null) {
      return RuleEngineSettingModel.fromMap(jsonDecode(raw));
    }
    return RuleEngineSettingModel();
  }

  static Future<void> saveSettings(RuleEngineSettingModel settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(settings.toMap()));
  }
}
