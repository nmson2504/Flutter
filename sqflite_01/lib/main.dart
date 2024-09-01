import 'package:flutter/material.dart';
import 'database_helper.dart';

// Run winform ok
void main() async {
  // Ensure that databaseFactory is initialized correctly based on platform
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().initDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo List',
      home: TodoListScreen2(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _controller = TextEditingController();
  late Future<List<Map<String, dynamic>>> _todos;

  @override
  void initState() {
    super.initState();
    _refreshTodoList();
  }

  void _refreshTodoList() {
    setState(() {
      _todos = DatabaseHelper().queryAllTodos();
    });
  }

  void _addTodo() async {
    if (_controller.text.isEmpty) return;

    await DatabaseHelper().insertTodo({'title': _controller.text});
    _controller.clear();
    _refreshTodoList();
  }

  void _deleteTodo(int id) async {
    await DatabaseHelper().deleteTodo(id);
    _refreshTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter todo item',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTodo,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _todos,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final todo = snapshot.data![index];
                    return ListTile(
                      title: Text(todo['title']),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteTodo(todo['id']),
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
}

class TodoListScreen2 extends StatefulWidget {
  const TodoListScreen2({super.key});

  @override
  State<TodoListScreen2> createState() => _TodoListScreen2State();
}

class _TodoListScreen2State extends State<TodoListScreen2> {
  final TextEditingController _controller = TextEditingController();
  late Future<List<Map<String, dynamic>>> _todos;

  @override
  void initState() {
    super.initState();
    _refreshTodoList();
  }

  void _refreshTodoList() {
    setState(() {
      _todos = DatabaseHelper().queryAllTodos();
    });
  }

  void _addTodo() async {
    if (_controller.text.isEmpty) return;

    await DatabaseHelper().insertTodo({'title': _controller.text});
    _controller.clear();
    _refreshTodoList();
  }

  void _deleteTodo(int id) async {
    await DatabaseHelper().deleteTodo(id);
    _refreshTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoListScreen2 '),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter todo item',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTodo,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _todos,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final todo = snapshot.data![index];
                    return ListTile(
                      title: Text(todo['title']),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteTodo(todo['id']),
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
}
