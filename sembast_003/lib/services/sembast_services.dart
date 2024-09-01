import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';
import '../models/todo.dart';

class SembastService {
  static const String dbName = 'todos.db';
  // Tên của kho lưu trữ (store) trong cơ sở dữ liệu storeName = 'todos'. Store trong Sembast tương tự như một bảng trong SQL, dùng để chứa các bản ghi (record).
  static const String storeName = 'todos';
  static final _store = intMapStoreFactory.store(storeName);
  static Database? _database;
  // chỉ định factory dùng để mở cơ sở dữ liệu trên nền tảng web. Trong trường hợp này, là databaseFactoryWeb.
  static final databaseFactory = databaseFactoryWeb;

  static Future<Database> get database async {
    if (_database == null) {
      _database = await databaseFactory.openDatabase(dbName);
    }
    return _database!;
  }

  static Future<int> addTodo(Todo todo) async {
    final db = await database;
    return await _store.add(db, todo.toMap());
  }

  static Future<List<Todo>> getTodos({Finder? finder}) async {
    final db = await database;
    final snapshots = await _store.find(db, finder: finder);
    return snapshots.map((snapshot) {
      final todo = Todo.fromMap(snapshot.value);
      todo.id = snapshot
          .key; // lấy key của record do database tự sinh - rất quan trọng để thực hiện Update - Delete - Read về sau
      return todo;
    }).toList();
  }

  static Future<void> updateTodo(Todo todo) async {
    final db = await database;
    await _store.update(
      db,
      todo.toMap(),
      finder: Finder(filter: Filter.byKey(todo.id)),
    );
  }

  static Future<void> deleteTodo(int id) async {
    final db = await database;
    await _store.delete(
      db,
      finder: Finder(filter: Filter.byKey(id)),
    );
  }

  static Future<void> deleteUsersOlderThan30() async {
    final db = await database;
    final finder = Finder(filter: Filter.greaterThan('age', 30));
    await _store.delete(db, finder: finder);
  }
}
