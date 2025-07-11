import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_todo_app_tibicle_pratical/data/rule_engine_storage.dart';
import 'package:smart_todo_app_tibicle_pratical/model/rule_engine_model.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/rule_engine_bloc/rule_engine_state.dart';

class RuleEngineCubit extends Cubit<RuleEngineState> {
  RuleEngineCubit() : super(RuleEngineState(RuleEngineSettingModel()));

  Future<void> loadSettings() async {
    final settings = await RuleEngineSettingsStorage.loadSettings();
    emit(RuleEngineState(settings));
  }

  Future<void> updateSetting(Function(RuleEngineSettingModel) updater) async {
    final newSettings = state.settings;
    updater(newSettings);
    await RuleEngineSettingsStorage.saveSettings(newSettings);
    emit(RuleEngineState(newSettings));
  }
}