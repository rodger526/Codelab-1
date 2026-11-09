import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/taskflow_app.dart';
import 'features/tasks/data/task_repository.dart';
import 'features/tasks/presentation/task_list_view_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          TasksViewModel(repository: LocalTaskRepository())..loadTasks(),
      child: const TaskFlowApp(),
    ),
  );
}
