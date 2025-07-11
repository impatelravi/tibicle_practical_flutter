import 'package:smart_todo_app_tibicle_pratical/model/rule_engine_model.dart';
import 'package:smart_todo_app_tibicle_pratical/model/task_model.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;
  final RuleEngineSettingModel ruleEngineSettings;

  TaskLoaded({
    required this.tasks,
    required this.ruleEngineSettings,
  });
}
