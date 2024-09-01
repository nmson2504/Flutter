import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/todo.dart';

class SembastService {
  static const String dbName = 'todos.db';
  static const String storeName = 'todos';
  static Database? _database;
  static final _store =
      intMapStoreFactory.store(storeName); // Tạo Store là một container để lưu trữ các bản ghi.

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initCustomPathDatabase();
    return _database!;
  }

  //
// Tạo DB với getApplicationDocumentsDirectory() - get folder Documents của user như C:\Users\Admin\Documents
  static Future<Database> _initDatabase() async {
    final appDocDir =
        await getApplicationDocumentsDirectory(); // return Directory
    // getApplicationDocumentsDirectory() - get folder Documents của user như C:\Users\Admin\Documents
    final dbPath = join(appDocDir.path, dbName);
    debugPrint(dbPath);
    return await databaseFactoryIo.openDatabase(dbPath);
  }

// Tạo DB với getApplicationSupportDirectory() - get folder C:\Users\Admin\AppData\Roaming\com.example\sembast_001
  static Future<Database> _initDatabase2() async {
    // getApplicationSupportDirectory() - C:\Users\Admin\AppData\Roaming\com.example\sembast_001\todos.db
    final appDir = await getApplicationSupportDirectory(); // return Directory
    final dbPath = join(appDir.path, dbName);
    debugPrint(dbPath);
    return await databaseFactoryIo.openDatabase(dbPath);
  }

// Tạo DB với getApplicationDocumentsDirectory() và join custom path
  static Future<Database> initCustomPathDatabase() async {
    // Bước 1: Lấy đường dẫn đến thư mục gốc của ứng dụng (ví dụ: Documents).
    Directory appDocDir = await getApplicationDocumentsDirectory();

    // Bước 2: Tạo một đường dẫn tùy chỉnh. Ví dụ: tạo thư mục con 'custom_folder'.
    String customPath =
        join(appDocDir.path, 'custom_folder', 'my_custom_database.db');

    // Bước 3: Tạo thư mục nếu chưa tồn tại.
    Directory customDir = Directory(dirname(customPath));
    debugPrint(customDir.path); // C:\Users\Admin\Documents\custom_folder
    if (!await customDir.exists()) {
      await customDir.create(recursive: true);
    }

    // Bước 4: Mở cơ sở dữ liệu tại đường dẫn tùy chỉnh.
    Database db = await databaseFactoryIo.openDatabase(customPath);

    return db;
  }

  static Future<int> addTodo(Todo todo) async {
    final db = await database;

    return await _store.add(db, todo.toMap());
  }

  static Future<List<Todo>> getAllTodos() async {
    final db = await database;
    final snapshots = await _store.find(db);
    return snapshots.map((snapshot) {
      final todo = Todo.fromMap(snapshot.value);
      todo.id = snapshot.key;
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
}
