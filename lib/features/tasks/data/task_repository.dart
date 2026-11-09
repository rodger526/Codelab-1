import '../domain/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();

  Future<Task?> getTaskById(int id);

  Future<void> addTask(Task task);

  Future<void> updateTask(Task task);

  Future<void> deleteTask(int id);
}

class LocalTaskRepository implements TaskRepository {
  final List<Task> _tasks = [
    const Task(
      id: 1,
      title: 'Diseñar la interfaz',
      description: 'Crear el diseño principal de TaskFlow.',
      priority: TaskPriority.alta,
      status: TaskStatus.completada,
      userId: 'usuario001',
    ),
    const Task(
      id: 2,
      title: 'Crear el modelo Task',
      description: 'Definir los atributos de cada tarea.',
      priority: TaskPriority.alta,
      status: TaskStatus.pendiente,
      userId: 'usuario001',
    ),
    const Task(
      id: 3,
      title: 'Construir TaskCard',
      description: 'Crear una tarjeta reutilizable.',
      priority: TaskPriority.media,
      status: TaskStatus.pendiente,
      userId: 'usuario001',
    ),
    const Task(
      id: 4,
      title: 'Implementar ListView',
      description: 'Mostrar las tareas en una lista.',
      priority: TaskPriority.alta,
      status: TaskStatus.enProgreso,
      userId: 'usuario001',
    ),
    const Task(
      id: 5,
      title: 'Realizar pruebas',
      description: 'Ejecutar flutter analyze y verificar la aplicación.',
      priority: TaskPriority.baja,
      status: TaskStatus.pendiente,
      userId: 'usuario001',
    ),
  ];

  @override
  Future<List<Task>> getTasks() async {
    return List.unmodifiable(_tasks);
  }

  @override
  Future<Task?> getTaskById(int id) async {
    for (final task in _tasks) {
      if (task.id == id) {
        return task;
      }
    }
    return null;
  }

  @override
  Future<void> addTask(Task task) async {
    _tasks.add(task);
  }

  @override
  Future<void> updateTask(Task task) async {
    final index = _tasks.indexWhere((item) => item.id == task.id);

    if (index != -1) {
      _tasks[index] = task;
    }
  }

  @override
  Future<void> deleteTask(int id) async {
    _tasks.removeWhere((task) => task.id == id);
  }
}
