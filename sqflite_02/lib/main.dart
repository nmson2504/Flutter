import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' show Directory, File, Platform;
// Run winform ok

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListScreen2(),
    );
  }
}

// Màn hình chính của ứng dụng
// TodoListScreen - code all in main.dart

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Map<String, dynamic>> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> todos = await db.query('todos');
    setState(() {
      _todos = todos;
    });
  }

  int n = 0;
  Future<void> _addTodo() async {
    final Database db = await getDatabase();
    await db.insert('todos',
        {'title': 'New Task ${++n}', 'description': 'Description ${n}'});
    _loadTodos();
  }

  Future<void> _updateTodo(int id) async {
    final Database db = await getDatabase();
    await db.update('todos',
        {'title': 'Updated Task', 'description': 'Updated Description'},
        where: 'id = ?', whereArgs: [id]);
    _loadTodos();
  }

  Future<void> _deleteTodo(int id) async {
    final Database db = await getDatabase();
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return ListTile(
            title: Text(todo['title']),
            subtitle: Text(todo['description']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _updateTodo(todo['id']),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteTodo(todo['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// code xử lý database chung trong file main.dart
//-------

// Hàm khởi tạo database tại thư mục tùy chỉnh
Future<void> initializeDatabase() async {
  // Lấy đường dẫn đến thư mục tài liệu của người dùng
  Directory documentsDirectory = await getApplicationDocumentsDirectory();

  // Tạo đường dẫn cho thư mục con 'f1'
  String subdirectoryPath = '${documentsDirectory.path}/f1';

  // Tạo thư mục 'f1' nếu chưa tồn tại
  Directory subdirectory = Directory(subdirectoryPath);
  if (!await subdirectory.exists()) {
    await subdirectory.create(recursive: true);
  }

// Khai báo sqfliteFfiInit và databaseFactory ko truy cập ở đâu trong file này, nhưng vẫn phải thực hiện để run được trên winform
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Tạo đường dẫn đầy đủ cho tệp cơ sở dữ liệu
  String dbPath = join(subdirectory.path, 'todo_database.db');

  // Khởi tạo cơ sở dữ liệu
  await openDatabase(
    dbPath,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
      );
    },
  );

  debugPrint('Database created at: $dbPath');
}

// Hàm để lấy đối tượng Database
Future<Database> getDatabase() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String subdirectoryPath = '${documentsDirectory.path}/f1';
  String dbPath = join(subdirectoryPath, 'todo_database.db');

  return await openDatabase(dbPath);
}

// TodoListScreen2 - code _initializeDatabase in database_helper.dart

class TodoListScreen2 extends StatefulWidget {
  const TodoListScreen2({super.key});

  @override
  State<TodoListScreen2> createState() => _TodoListScreen2State();
}

class _TodoListScreen2State extends State<TodoListScreen2> {
  List<Map<String, dynamic>> _todos = [];
  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await DatabaseHelper().getTodos();
    setState(() {
      _todos = todos;
    });
  }

  int n = 0;
  Future<void> _addTodo() async {
    await DatabaseHelper().addTodo({
      'title': 'New Task ${++n}',
      'description': 'Description $n',
    });
    _loadTodos();
  }

  Future<void> _updateTodo(int id) async {
    await DatabaseHelper().updateTodo(id, {
      'title': 'Updated Task',
      'description': 'Updated Description',
    });
    _loadTodos();
  }

  Future<void> _deleteTodo(int id) async {
    await DatabaseHelper().deleteTodo(id);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List 2'),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return ListTile(
            title: Text(todo['title']),
            subtitle: Text(todo['description']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _updateTodo(todo['id']),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteTodo(todo['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
