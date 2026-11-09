import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:taskflow/app/taskflow_app.dart';
import 'package:taskflow/features/tasks/data/task_repository.dart';
import 'package:taskflow/features/tasks/presentation/task_list_view_model.dart';

void main() {
  testWidgets('TaskFlow muestra la lista de tareas', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) =>
            TasksViewModel(repository: LocalTaskRepository())..loadTasks(),
        child: const TaskFlowApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Mis tareas'), findsOneWidget);
    expect(find.text('Diseñar la interfaz'), findsOneWidget);
  });
}
