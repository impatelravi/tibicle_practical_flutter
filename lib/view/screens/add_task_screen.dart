import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_todo_app_tibicle_pratical/model/task_model.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/task_bloc/task_bloc.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/task_bloc/task_event.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _priority = 'High';
  String _category = 'Work';
  int _estimatedTime = 0;

  final List<String> _priorities = ['High', 'Medium', 'Low'];
  final List<String> _categories = ['Work', 'Personal', 'Health'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value ?? '',
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter a title' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _priority,
                items: _priorities
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (value) => setState(() => _priority = value!),
                decoration: const InputDecoration(labelText: 'Priority'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _category,
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) => setState(() => _category = value!),
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Estimated Time (in minutes)',
                ),
                onSaved: (value) =>
                _estimatedTime = int.tryParse(value ?? '0') ?? 0,
                validator: (value) {
                  final time = int.tryParse(value ?? '');
                  if (time == null || time <= 0) {
                    return 'Enter a valid time > 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();

                    final newTask = TaskModel(
                      title: _title,
                      priority: _priority,
                      category: _category,
                      estimatedTime: _estimatedTime,
                    );

                    context.read<TaskBloc>().add(AddTask(newTask));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}