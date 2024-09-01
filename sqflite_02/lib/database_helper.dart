import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'dart:io' show Directory, File, Platform;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    // Lấy đường dẫn đến thư mục tài liệu của người dùng
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // Tạo đường dẫn cho thư mục con 'f1'
    String subdirectoryPath = '${documentsDirectory.path}/f2';

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
    debugPrint('Database created at: $dbPath');
    // Khởi tạo cơ sở dữ liệu
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> getTodos() async {
    final db = await database;
    return await db.query('todos');
  }

  Future<void> addTodo(Map<String, dynamic> todo) async {
    final db = await database;
    await db.insert('todos', todo);
  }

  Future<void> updateTodo(int id, Map<String, dynamic> todo) async {
    final db = await database;
    await db.update('todos', todo, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteTodo(int id) async {
    final db = await database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
