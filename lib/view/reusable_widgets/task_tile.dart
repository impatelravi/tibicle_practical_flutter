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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (task.showWarning) {
        showWarningDialog(context);
      }
    });

    return CheckboxListTile(
      title: Text(task.title),
      subtitle: Text('${task.priority} • ${task.category} • ${task.estimatedTime} min'),
      value: task.isCompleted,
      onChanged: onChanged,
    );
  }

  void showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.orange),
              SizedBox(width: 8),
              Text("Warning"),
            ],
          ),
          content: Text("High priority task skipped due to exceed time limit!"),
          actions: [
            TextButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}