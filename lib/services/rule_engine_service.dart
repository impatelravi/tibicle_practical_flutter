import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_todo_app_tibicle_pratical/model/rule_engine_model.dart';
import 'package:smart_todo_app_tibicle_pratical/model/task_model.dart';

class RuleEngineService {
  final RuleEngineSettingModel? settings;

  RuleEngineService(this.settings);

  Future<void> saveSettings(RuleEngineSettingModel settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rule_settings/maxTimeLimit', settings.maxTimeLimit);
    await prefs.setBool('rule_settings/sortByPriority', settings.sortByPriority);
    await prefs.setBool('rule_settings/preferShorterTasks', settings.preferShorterTasks);
    await prefs.setBool('rule_settings/requireTwoCategories', settings.requireTwoCategories);
    await prefs.setBool('rule_settings/warnIfHighSkipped', settings.warnIfHighSkipped);
  }

  List<TaskModel> getSuggestedTasks(List<TaskModel> tasks) {
    var activeTasks = tasks.where((t) => !t.isCompleted).toList();

    if (settings?.sortByPriority ?? false) {
      activeTasks.sort((a, b) => _priorityValue(a.priority).compareTo(_priorityValue(b.priority)));
    }

    if (settings?.preferShorterTasks ?? false) {
      activeTasks.sort((a, b) {
        final priorityCompare = _priorityValue(a.priority).compareTo(_priorityValue(b.priority));
        if (priorityCompare != 0) return priorityCompare;
        return a.estimatedTime.compareTo(b.estimatedTime);
      });
    }

    List<TaskModel> selected = [];
    int totalTime = 0;
    Set<String> categories = {};

    for (final task in activeTasks) {
      if ((settings?.maxTimeLimit ?? false) && totalTime + task.estimatedTime > 240) {
        continue;
      }
      selected.add(task);
      totalTime += task.estimatedTime;
      categories.add(task.category);
    }

    if ((settings?.requireTwoCategories ?? false) && categories.length < 2) {
      final otherCategoryTasks = activeTasks.where((t) => !categories.contains(t.category));
      for (final t in otherCategoryTasks) {
        if ((settings?.maxTimeLimit ?? false) && totalTime + t.estimatedTime > 240) break;
        selected.add(t);
        totalTime += t.estimatedTime;
        categories.add(t.category);
        if (categories.length >= 2) break;
      }
    }

    return selected;
  }

  int _priorityValue(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return 0;
      case 'medium':
        return 1;
      case 'low':
        return 2;
      default:
        return 2;
    }
  }
}