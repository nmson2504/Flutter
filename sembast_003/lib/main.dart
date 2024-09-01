import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:path/path.dart';

import 'models/todo.dart';
import 'services/sembast_services.dart';

/* 
flutter run -d chrome --web-renderer html ok
F5 lần đầu lỗi, refresh lại ok
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp2());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Sembast Web Demo')),
        body: FutureBuilder<void>(
          future: initDatabaseFilter(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const Center(child: Text('Database operation completed.'));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

//  Demo CURD cơ bản
Future<void> initDatabase() async {
  debugPrint("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
  // Mở cơ sở dữ liệu
  final factory = databaseFactoryWeb;
  final db = await factory.openDatabase('my_database.db');

  // Tạo một store để lưu trữ dữ liệu
  /* 
  - store.record(id).put() cho phép bạn xác định khóa và có thể cập nhật một bản ghi đã tồn tại hoặc tạo mới nếu chưa có.
await store.record(1).put(database, {'name': 'John Doe', 'age': 30});
Nếu put trùng key sẽ update(overwrite) data

  - Method add thêm một bản ghi mới vào cơ sở dữ liệu và tự động tạo ra một khóa (ID) mới cho bản ghi đó. Khóa này sẽ là số nguyên duy nhất.
 */
  final store = intMapStoreFactory.store('my_store');

  // Thêm một bản ghi
  await store.record(1).put(db, {'name': 'John Doe', 'age': 30});
  await store.record(1).put(db, {'name': 'John Doe', 'age': 29});

  await store.add(db, {'name': 'Nguyễn Minh Sơn', 'age': 50});
  await store.add(db, {'name': 'Ngô Ngáo', 'age': 40});
  final key = await store.add(db, {'name': 'Nguyễn Xuân Trường', 'age': 31});

  debugPrint('key of record: $key');
  // Đọc dữ liệu
  final record = await store.record(1).get(db); // get 1 record
  debugPrint('Record: $record'); // Xem kết quả trong console
  final snapshots = await store.find(db); // get all records
  debugPrint(snapshots.toString());

  // Update the user with the given ID
  await store.record(1).update(db, {'name': 'Ng Sơn', 'age': 88});
  // Update với filter
  final finderU = Finder(filter: Filter.greaterThan('age', 40));
  await store.update(db, {'age': 120}, finder: finderU);

  // Delete
  // delete 1 record theo ID
  // await store.record(1).delete(db);
  final snapshotsX = await store.find(db); // get all records
  debugPrint(snapshotsX.toString());

  // delete với filter
  final finder = Finder(filter: Filter.greaterThan('age', 30));
  await store.delete(db, finder: finder);
  final snapshotsX1 = await store.find(db); // get all records
  debugPrint(snapshotsX1.toString());
  // in từng dòng
  for (var snapshot in snapshots) {
    debugPrint('Key: ${snapshot.key}, Value: ${snapshot.value}');
  }
  // delete all
  await store.delete(db); // xoá sạch all record in database
  // Đóng cơ sở dữ liệu
  await db.close();
}

//

//  Demo CURD với filter
Future<void> initDatabaseFilter() async {
  debugPrint("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0

  // Mở cơ sở dữ liệu
  final factory = databaseFactoryWeb;
  final db = await factory.openDatabase('my_database.db');

  // Tạo một store để lưu trữ dữ liệu
  final store = intMapStoreFactory.store('my_store');
  /* 
  - store.record(id).put() cho phép bạn xác định khóa và có thể cập nhật một bản ghi đã tồn tại hoặc tạo mới nếu chưa có.
await store.record(1).put(database, {'name': 'John Doe', 'age': 30});
Nếu put trùng key sẽ update(overwrite) data

  - Method add thêm một bản ghi mới vào cơ sở dữ liệu và tự động tạo ra một khóa (ID) mới cho bản ghi đó. Khóa này sẽ là số nguyên duy nhất.
 */

  // Thêm một bản ghi
  await store.record(1).put(db, {'name': 'John Doe', 'age': 30});
  await store.record(2).put(db, {'name': 'John Cu', 'age': 29});
  await store.record(3).put(db, {'name': 'Cu To', 'age': 19});
  await store.add(db, {'name': 'Minh Sơn', 'age': 50});
  await store.add(db, {'name': 'Ngô Ngáo', 'age': 40});
  final key = await store.add(db, {'name': 'Xuân Trường', 'age': 31});

  debugPrint('key of record: $key');
  // Đọc dữ liệu với filter
  final record = await store.record(1).get(db); // get 1 record
  debugPrint('Record: $record'); // Xem kết quả trong console
  final snapshots = await store.find(db); // get all records
  debugPrint(snapshots.toString());
  // in từng dòng
  for (var snapshot in snapshots) {
    debugPrint('Key: ${snapshot.key}, Value: ${snapshot.value}');
  }

  // delete all
  await store.delete(db); // xoá sạch all record in database
  // Đóng cơ sở dữ liệu
  await db.close();
}

// Example 2 - load data on UI
class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sembast Web Example - MyApp2',
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

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos({Finder? finder}) async {
    final todos = await SembastService.getTodos(finder: finder);
    setState(() {
      _todos = todos;
    });
  }

  Future<void> _addTestData() async {
    final random = Random();
    final names = [
      'John Doe',
      'John Cu',
      'John Bi',
      'Cu To',
      'Minh Sơn',
      'Ngô Ngáo',
      'John K',
      'CuTi',
      'Toan',
      'Chi',
      'Tran'
    ];

    // Generate 5 random Todos
    for (int i = 0; i < 10; i++) {
      final name = names[random.nextInt(names.length)];
      final age = random.nextInt(82) + 15; // Random age between 18 and 96
      await SembastService.addTodo(Todo(name: name, age: age));
    }

    _loadTodos(); // Refresh the list after adding data
  }

// Các filters
  final finderContains = Finder(filter: Filter.custom((record) {
    final value = record['name'] as String;
    return value.contains('Ng');
  }));

  final finderStartsWith = Finder(filter: Filter.custom((record) {
    final value = record['name'] as String;
    return value.startsWith('C');
  }));

  final finderAnd = Finder(
    filter: Filter.and([
      Filter.greaterThan('age', 30), // Điều kiện 1: tuổi > 30
      Filter.notEquals('name', 'Jane Doe') // Điều kiện 2: tên ko là 'Jane Doe'
    ]),
  );
  final finderOr = Finder(
    filter: Filter.or([
      Filter.greaterThan('age', 50), // Điều kiện 1: tuổi > 50
      Filter.lessThan('age', 20) // Điều kiện 2: tuổi < 20
    ]),
  );
// Sử dụng Filter.matches với biểu thức chính quy:
  final finderMatches = Finder(
    filter: Filter.matches(
        'name', '^J.*Doe\$'), // bắt đầu bằn J và kết thức với Doe
  );
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sembast Web Example'),
      ),
      body: Column(
        children: [
          Text('${_todos.length} record.'), // đếm số record in list
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  title: Text('${todo.id},${todo.name}, ${todo.age} years old'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      SembastService.deleteTodo(todo.id!)
                          .then((_) => _loadTodos());
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _addTestData,
                child: const Text('Add Data'),
              ),
              ElevatedButton(
                onPressed: () => _loadTodos(
                    finder: Finder(filter: Filter.lessThan('age', 30))),
                child: const Text('Age < 30'),
              ),
              ElevatedButton(
                onPressed: () => _loadTodos(
                    finder: Finder(filter: Filter.lessThanOrEquals('age', 30))),
                child: const Text('Age =< 30'),
              ),
              ElevatedButton(
                onPressed: () => _loadTodos(
                  finder:
                      Finder(filter: Filter.inList('name', ['Tran', 'Chi'])),
                ),
                child: const Text('name inList'),
              ),
              ElevatedButton(
                onPressed: () => _loadTodos(finder: finderContains),
                child: const Text('Contains'),
              ),
              ElevatedButton(
                onPressed: () => _loadTodos(finder: finderStartsWith),
                child: const Text('StartsWith'),
              ),
              ElevatedButton(
                onPressed: () => _loadTodos(finder: finderAnd),
                child: const Text('finderAnd'),
              ),
              ElevatedButton(
                onPressed: () => _loadTodos(finder: finderOr),
                child: const Text('finderOr'),
              ),
              ElevatedButton(
                onPressed: () => _loadTodos(finder: finderMatches),
                child: const Text('finderMatches'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
