import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_todo_app_tibicle_pratical/data/local_db.dart';
import 'package:smart_todo_app_tibicle_pratical/model/rule_engine_model.dart';
import 'package:smart_todo_app_tibicle_pratical/services/rule_engine_service.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/task_bloc/task_event.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/task_bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final RuleEngineService ruleEngineSettingsService;

  TaskBloc(this.ruleEngineSettingsService) : super(TaskInitial()) {

    Future<RuleEngineSettingModel> getSettings() async {
      final prefs = await SharedPreferences.getInstance();
      return RuleEngineSettingModel(
        maxTimeLimit: prefs.getBool('rule_settings/maxTimeLimit') ?? true,
        sortByPriority: prefs.getBool('rule_settings/sortByPriority') ?? true,
        preferShorterTasks: prefs.getBool('rule_settings/preferShorterTasks') ?? true,
        requireTwoCategories: prefs.getBool('rule_settings/requireTwoCategories') ?? true,
        warnIfHighSkipped: prefs.getBool('rule_settings/warnIfHighSkipped') ?? true,
      );
    }

    on<LoadTasks>((event, emit) async {
      final tasks = LocalDB.getTasks();
      final ruleEngineSettings = await getSettings();

      emit(TaskLoaded(tasks: tasks, ruleEngineSettings: ruleEngineSettings,));
    });

    on<AddTask>((event, emit) async {
      await LocalDB.addTask(event.task);
      add(LoadTasks());
    });

    // on<ToggleTaskComplete>((event, emit) async {
    //   await LocalDB.toggleTaskComplete(event.index);
    //   add(LoadTasks());
    // });

    on<ToggleTaskComplete>((event, emit) async {
      event.task.isCompleted = !event.task.isCompleted;
      await event.task.save();
      add(LoadTasks());
    });

    on<UpdateRuleEngineSettingsEvent>((event, emit) async {
      await ruleEngineSettingsService.saveSettings(event.settings);

      // Reload tasks with updated settings
      final tasks = LocalDB.getTasks();

      emit(TaskLoaded(
        tasks: tasks,
        ruleEngineSettings: event.settings,
      ));
    });
  }
}