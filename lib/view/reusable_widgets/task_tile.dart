import 'package:flutter/material.dart';
import 'package:smart_todo_app_tibicle_pratical/model/task_model.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final Function(bool?) onChanged;

  const TaskTile({
    super.key,
    required this.task,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(task.title),
      subtitle: Text('${task.priority} • ${task.category} • ${task.estimatedTime} min'),
      value: task.isCompleted,
      onChanged: onChanged,
    );
  }
}