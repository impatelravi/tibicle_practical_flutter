import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_todo_app_tibicle_pratical/model/task_model.dart';
import 'package:smart_todo_app_tibicle_pratical/services/rule_engine_service.dart';
import 'package:smart_todo_app_tibicle_pratical/view/reusable_widgets/task_tile.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/task_bloc/task_bloc.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/task_bloc/task_event.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/task_bloc/task_state.dart';

class SuggestedTasksSection extends StatelessWidget {
  const SuggestedTasksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoaded) {
          final tasks = state.tasks;
          final settings = state.ruleEngineSettings;

          // Use RuleEngineService to get suggested tasks
          final engine = RuleEngineService(settings);
          final suggestedTasks = engine.getSuggestedTasks(tasks);

          if (suggestedTasks.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No suggested tasks for today.'),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Suggested for Today',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: suggestedTasks.length,
                separatorBuilder: (_, __) => const Divider(height: 0),
                itemBuilder: (context, index) {
                  final TaskModel task = suggestedTasks[index];
                  return TaskTile(
                    task: task,
                    onChanged: (value) {
                      context.read<TaskBloc>().add(ToggleTaskComplete(task));
                    },
                  );
                },
              ),
            ],
          );
        }

        if (state is TaskInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        return const SizedBox.shrink();
      },
    );
  }
}