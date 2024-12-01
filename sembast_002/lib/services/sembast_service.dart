import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/todo.dart';
import 'dart:io';
// 2 package dưới để run được flutter run -d chrome --web-renderer html
// thêm cấu hình vào file launch.json với thuộc tính: "args": ["--web-renderer","html"] để F5 được
import 'package:sembast_web/sembast_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SembastService {
  static const String dbName = 'todos.db';
  static const String storeName = 'todos';
  static Database? _database; // object Database lưu data
  static SembastService? _instance;
  static final _store = intMapStoreFactory.store(storeName); //  Tạo Store là một container để lưu trữ các bản ghi.
  SembastService._();
/*
Dấu gạch dưới _ trong Dart thường được sử dụng để đánh dấu các biến hoặc phương thức là "riêng tư" (private), có nghĩa là chúng chỉ có thể được truy cập từ bên trong cùng một thư viện (library) hoặc class.
SembastService._(); gọi đến một constructor có tên là _ của class SembastService. Vì đây là một constructor riêng tư, nó chỉ có thể được gọi từ bên trong class SembastService và không thể được gọi từ bên ngoài class đó.

Lệnh SembastService._(); là cách bạn gọi đến constructor riêng tư của class SembastService để tạo ra đối tượng duy nhất của class này, nhằm thực hiện mô hình Singleton. Nó đảm bảo rằng chỉ có một phiên bản của SembastService tồn tại trong ứng dụng, giúp quản lý hiệu quả việc khởi tạo và sử dụng cơ sở dữ liệu. Điều này giúp bảo vệ các tài nguyên hệ thống và đảm bảo rằng các tài nguyên như cơ sở dữ liệu không bị khởi tạo lại một cách không cần thiết. */

// database được sử dụng trong các phương thức CRUD (Create, Read, Update, Delete) để lấy đối tượng cơ sở dữ liệu.
/* Hàm này trả về một đối tượng Database và đảm bảo rằng cơ sở dữ liệu chỉ được khởi tạo một lần. Nếu cơ sở dữ liệu đã được khởi tạo, nó sẽ trả về đối tượng Database hiện có. Nếu chưa, nó sẽ gọi _initDatabase() để khởi tạo cơ sở dữ liệu. */
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _instance = SembastService._();
    await _instance!._initDatabase();
    return _database!;
  }

// instance được sử dụng khi cần truy cập đối tượng SembastService từ các phần khác nhau của ứng dụng, đảm bảo chỉ có một phiên bản được khởi tạo.
/* Trả về một đối tượng SembastService và đảm bảo rằng đối tượng này chỉ được khởi tạo một lần. Nếu đối tượng SembastService đã được khởi tạo, nó sẽ trả về đối tượng hiện có. Nếu chưa, nó sẽ gọi _initDatabase() để khởi tạo đối tượng này cùng với cơ sở dữ liệu. */
  static Future<SembastService> get instance async {
    if (_instance == null) {
      _instance = SembastService._();
      await _instance!._initDatabase();
    }
    return _instance!;
  }

  // getApplicationDocumentsDirectory() - get folder Documents của user như C:\Users\Admin\Documents
  /* Hàm này chỉ cần được gọi một lần để khởi tạo cơ sở dữ liệu. Sau đó, đối tượng cơ sở dữ liệu đã khởi tạo sẽ được sử dụng lại trong suốt thời gian ứng dụng chạy.
Đa nền tảng: Hàm đảm bảo rằng cơ sở dữ liệu được khởi tạo một cách phù hợp trên cả nền tảng web và các nền tảng khác (như mobile, desktop), cung cấp một giải pháp lưu trữ dữ liệu đồng nhất nhưng linh hoạt. */
  Future<void> _initDatabase() async {
    if (kIsWeb) {
      _database = await databaseFactoryWeb.openDatabase(dbName);
    } else {
      final dir = await getApplicationDocumentsDirectory();
      final dbPath = join(dir.path, dbName);
      _database = await databaseFactoryIo.openDatabase(dbPath);
    }
  }

// method add thêm một bản ghi mới vào cơ sở dữ liệu và tự động tạo ra một khóa (ID) mới cho bản ghi đó. Khóa này sẽ là số nguyên duy nhất.
// store.record(id).put() cho phép bạn xác định khóa và có thể cập nhật một bản ghi đã tồn tại hoặc tạo mới nếu chưa có.
  static Future<int> addTodo(Todo todo) async {
    final db = await database; // call Future<Database> get database
    return await _store.add(db, todo.toMap());
  }

// đối tượng snapshots đại diện cho danh sách các kết quả (hay "snapshot") thu được từ việc truy vấn cơ sở dữ liệu
  static Future<List<Todo>> getAllTodos() async {
    final db = await database; // call Future<Database> get database
    final snapshots = await _store
        .find(db); // _store.find(db): Hàm này tìm tất cả các mục trong store và trả về danh sách các RecordSnapshot.
    // snapshots.map(...): chuyển đổi mỗi snapshot trong danh sách snapshots thành một đối tượng Todo.
    return snapshots.map((snapshot) {
      // Hàm fromMap khởi tạo Todo từ một Map.
      final todo = Todo.fromMap(snapshot.value); // Chuyển đổi snapshots thành danh sách các đối tượng Todo
      todo.id = snapshot.key;
      return todo;
    }).toList(); //  chuyển đổi kết quả từ một Iterable thành một danh sách (List).
  }

  static Future<void> updateTodo(Todo todo) async {
    final db = await database; // call Future<Database> get database
    final filter = Finder(filter: Filter.byKey(todo.id));
    await _store.update(
      db,
      todo.toMap(),
      finder: filter,
    );
  }

  static Future<void> deleteTodo(int id) async {
    final db = await database;
    await _store.delete(
      db,
      finder: Finder(filter: Filter.byKey(id)),
    );
  }
}
