import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo database trên web
  final factory = databaseFactoryWeb;
  final db = await factory.openDatabase('tasks.db');

  runApp(MyApp(database: db));
}

class MyApp extends StatelessWidget {
  final Database database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskScreen(database: database),
    );
  }
}

class TaskScreen extends StatefulWidget {
  final Database database;

  const TaskScreen({super.key, required this.database});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _taskController = TextEditingController();

  // Store để lưu trữ dữ liệu
  final _store = intMapStoreFactory.store('tasks');

  // Thêm task
  Future<void> _addTask(String task) async {
    await _store.add(widget.database, {'task': task});
    setState(() {}); // Refresh UI
  }

  // Lấy danh sách các task
  Future<List<RecordSnapshot<int, Map<String, Object?>>>> _getTasks() async {
    return await _store.find(widget.database);
  }

  // Xóa task
  Future<void> _deleteTask(int key) async {
    await _store.record(key).delete(widget.database);
    setState(() {}); // Refresh UI
  }

  // Cập nhật task
  Future<void> _updateTask(int key, String newTask) async {
    await _store.record(key).update(widget.database, {'task': newTask});
    setState(() {}); // Refresh UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sembast Web CRUD Demo'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'Enter a task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_taskController.text.isNotEmpty) {
                      _addTask(_taskController.text);
                      _taskController.clear();
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<RecordSnapshot<int, Map<String, Object?>>>>(
              future: _getTasks(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No tasks added!'),
                  );
                }

                final tasks = snapshot.data!;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(task['task'] as String),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _showUpdateDialog(task.key, task['task'] as String);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteTask(task.key);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Hiển thị dialog cập nhật task
  void _showUpdateDialog(int key, String currentTask) {
    final updateController = TextEditingController(text: currentTask);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Task'),
          content: TextField(
            controller: updateController,
            decoration: const InputDecoration(
              labelText: 'New task',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateTask(key, updateController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
