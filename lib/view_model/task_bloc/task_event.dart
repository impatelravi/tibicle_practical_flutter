import 'package:smart_todo_app_tibicle_pratical/model/rule_engine_model.dart';
import 'package:smart_todo_app_tibicle_pratical/model/task_model.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final TaskModel task;
  AddTask(this.task);
}

class ToggleTaskComplete extends TaskEvent {
  final TaskModel task;
  ToggleTaskComplete(this.task);
}

class UpdateRuleEngineSettingsEvent extends TaskEvent {
  final RuleEngineSettingModel settings;
  UpdateRuleEngineSettingsEvent(this.settings);
}