import 'package:flutter/material.dart';
import 'models/todo.dart';
import 'services/sembast_service.dart';

// sembast package
// run on winform
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sembast 001 Todo List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> _todos = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshTodos();
  }

  Future<void> _refreshTodos() async {
    final todos = await SembastService.getAllTodos();
    setState(() {
      _todos = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sembast 001 Todo List')),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return ListTile(
            title: Text(
              todo.title,
              style: TextStyle(
                decoration:
                    todo.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            leading: Checkbox(
              value: todo.isCompleted,
              onChanged: (bool? value) {
                todo.isCompleted = value ?? false;
                SembastService.updateTodo(todo).then((_) => _refreshTodos());
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                SembastService.deleteTodo(todo.id!)
                    .then((_) => _refreshTodos());
              },
            ),
            onTap: () => _showEditDialog(todo),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter todo title'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
                _controller.clear();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  final newTodo = Todo(title: _controller.text);
                  SembastService.addTodo(newTodo).then((_) {
                    _refreshTodos();
                    Navigator.pop(context);
                    _controller.clear();
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(Todo todo) {
    _controller.text = todo.title;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter todo title'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
                _controller.clear();
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  todo.title = _controller.text;
                  SembastService.updateTodo(todo).then((_) {
                    _refreshTodos();
                    Navigator.pop(context);
                    _controller.clear();
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }
}
