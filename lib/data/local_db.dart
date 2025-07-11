import 'package:hive/hive.dart';
import 'package:smart_todo_app_tibicle_pratical/model/task_model.dart';

class LocalDB {
  static final Box<TaskModel> _taskBox = Hive.box<TaskModel>('tasks');

  static List<TaskModel> getTasks() {
    return _taskBox.values.toList();
  }

  static Future<void> addTask(TaskModel task) async {
    await _taskBox.add(task);
  }

  static Future<void> toggleTaskComplete(int index) async {
    final task = _taskBox.getAt(index);
    if (task != null) {
      task.isCompleted = !task.isCompleted;
      await task.save();
    }
  }

  static Future<void> deleteTask(int index) async {
    await _taskBox.deleteAt(index);
  }
}