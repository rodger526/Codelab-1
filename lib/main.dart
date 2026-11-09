import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'models/task.dart';

void main() {
  runApp(const TaskFlowApp());
}

// DATOS LOCALES
const demoTasks = [
  Task(
    id: 1,
    title: 'Diseñar la interfaz',
    description: 'Crear el diseño principal de TaskFlow.',
    priority: TaskPriority.alta,
    status: TaskStatus.completada,
    userId: 'usuario001',
  ),
  Task(
    id: 2,
    title: 'Crear el modelo Task',
    description: 'Definir los atributos de cada tarea.',
    priority: TaskPriority.alta,
    status: TaskStatus.pendiente,
    userId: 'usuario001',
  ),
  Task(
    id: 3,
    title: 'Construir TaskCard',
    description: 'Crear una tarjeta reutilizable.',
    priority: TaskPriority.media,
    status: TaskStatus.pendiente,
    userId: 'usuario001',
  ),
  Task(
    id: 4,
    title: 'Implementar ListView',
    description: 'Mostrar las tareas en una lista.',
    priority: TaskPriority.alta,
    status: TaskStatus.enProgreso,
    userId: 'usuario001',
  ),
  Task(
    id: 5,
    title: 'Realizar pruebas',
    description: 'Ejecutar flutter analyze y verificar la aplicación.',
    priority: TaskPriority.baja,
    status: TaskStatus.pendiente,
    userId: 'usuario001',
  ),
];

// CONFIGURACIÓN DE RUTAS
final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const TaskListScreen()),
    GoRoute(
      path: '/task/:id',
      builder: (context, state) {
        final taskId = int.parse(state.pathParameters['id']!);
        return TaskDetailScreen(taskId: taskId);
      },
    ),
  ],
);

// APLICACIÓN PRINCIPAL
class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}

// TARJETA REUTILIZABLE
class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, this.onTap});

  final Task task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        onTap: onTap,
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.isCompleted ? Colors.green : Colors.indigo,
          size: 30,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.description),
              const SizedBox(height: 6),
              Text('Prioridad: ${task.priority.name}'),
            ],
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

// PANTALLA DEL LISTADO
class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis tareas'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: demoTasks.length,
        itemBuilder: (context, index) {
          final task = demoTasks[index];

          return TaskCard(
            task: task,
            onTap: () {
              context.push('/task/${task.id}');
            },
          );
        },
      ),
    );
  }
}

// PANTALLA DEL DETALLE
class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.taskId});

  final int taskId;

  @override
  Widget build(BuildContext context) {
    final matchingTasks = demoTasks.where((item) => item.id == taskId);

    if (matchingTasks.isEmpty) {
      return const TaskNotFoundScreen();
    }

    final task = matchingTasks.first;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de tarea'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                task.isCompleted ? Icons.task_alt : Icons.assignment,
                size: 72,
                color: task.isCompleted ? Colors.green : Colors.indigo,
              ),
            ),
            const SizedBox(height: 28),
            Text(task.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            const Text(
              'Descripción',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(task.description),
            const SizedBox(height: 24),
            const Text(
              'Prioridad',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Chip(
              avatar: const Icon(Icons.flag),
              label: Text(task.priority.name),
            ),
            const SizedBox(height: 16),
            const Text(
              'Estado de la tarea',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  task.isCompleted ? Icons.check_circle : Icons.pending_actions,
                  color: task.isCompleted ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(task.status.name),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonalIcon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver al listado'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// PANTALLA PARA TAREAS INEXISTENTES
class TaskNotFoundScreen extends StatelessWidget {
  const TaskNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarea no encontrada')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text('No existe esta tarea.'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go('/'),
              child: const Text('Volver al listado'),
            ),
          ],
        ),
      ),
    );
  }
}
