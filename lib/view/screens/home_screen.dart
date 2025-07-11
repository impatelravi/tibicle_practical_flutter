import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_todo_app_tibicle_pratical/view/reusable_widgets/suggested_task_section.dart';
import 'package:smart_todo_app_tibicle_pratical/view/reusable_widgets/task_tile.dart';
import 'package:smart_todo_app_tibicle_pratical/view/screens/add_task_screen.dart';
import 'package:smart_todo_app_tibicle_pratical/view/screens/rule_engine_setting_screen.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/task_bloc/task_bloc.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/task_bloc/task_event.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/task_bloc/task_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart To-Do'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RuleEngineSettingsScreen()),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoaded) {
            final tasks = state.tasks;
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SuggestedTasksSection(),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'All Tasks',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return TaskTile(
                            task: task,
                            onChanged: (_) {
                              context.read<TaskBloc>().add(ToggleTaskComplete(task));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );

          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}