import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final String priority;

  @HiveField(3)
  final int estimatedTime;

  @HiveField(4)
  bool isCompleted;

  TaskModel({
    required this.title,
    required this.category,
    required this.priority,
    required this.estimatedTime,
    this.isCompleted = false,
  });
}