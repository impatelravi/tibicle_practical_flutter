import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_todo_app_tibicle_pratical/model/task_model.dart';
import 'package:smart_todo_app_tibicle_pratical/services/rule_engine_service.dart';
import 'package:smart_todo_app_tibicle_pratical/view/screens/home_screen.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/task_bloc/task_bloc.dart';
import 'package:smart_todo_app_tibicle_pratical/view_model/task_bloc/task_event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasks');

  runApp(
    BlocProvider(
      create: (_) => TaskBloc(RuleEngineService(null))..add(LoadTasks()),
      child: const MaterialApp(home: HomeScreen()),
    ),
  );
}
