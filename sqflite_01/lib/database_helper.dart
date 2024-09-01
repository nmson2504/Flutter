import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' show Directory, File, Platform;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<void> initDatabase() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    _database = await _initDatabase();
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

 

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo.db');
    debugPrint(
        path); // print default path database (D:\son\Flutter\sqflite_01\.dart_tool\sqflite_common_ffi\databases\todo.db)
    printDatabasePath();
    getDatabasePath();
    saveFile();
    saveFileToSubdirectory();
    saveFileToParentDirectory();

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT
          )
        ''');
      },
    );
  }

  Future<void> printDatabasePath() async {
    // Lấy đường dẫn default thư mục cơ sở dữ liệu - getDatabasesPath() là folder chứa project
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');

    debugPrint("getDatabasesPath path: $path");
  }

// getApplicationDocumentsDirectory - folder Documents của user mặc định(như C:\Users\Admin\Documents)
  Future<void> getDatabasePath() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = '${appDocumentDir.path}/example.db';

    debugPrint("getApplicationDocumentsDirectory path: $dbPath");
  }

  Future<int> insertTodo(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('todos', row);
  }

  Future<List<Map<String, dynamic>>> queryAllTodos() async {
    Database db = await database;
    return await db.query('todos');
  }

  Future<int> deleteTodo(int id) async {
    Database db = await database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

// save file vào folder Documents của user mặc định(như C:\Users\Admin\Documents)
  Future<void> saveFile() async {
    // Lấy đường dẫn đến thư mục tài liệu của ứng dụng
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // Tạo đường dẫn đầy đủ cho tệp mà bạn muốn lưu
    String filePath = '${documentsDirectory.path}/my_data.txt';

    // Tạo và ghi dữ liệu vào tệp
    File file = File(filePath);
    await file.writeAsString('Hello, Flutter!'); // ghi đè khi file trùng tên

    debugPrint('File saved at: $filePath');
  }

// save file vào saveFileToSubdirectory của user mặc định(như C:\Users\Admin\Documents\f1)
  Future<void> saveFileToSubdirectory() async {
    // Lấy đường dẫn đến thư mục tài liệu của ứng dụng
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // Tạo đường dẫn cho thư mục con 'f1'
    String subdirectoryPath = '${documentsDirectory.path}/f1';

    // Tạo thư mục 'f1' nếu chưa tồn tại
    Directory subdirectory = Directory(subdirectoryPath);
    if (!await subdirectory.exists()) {
      await subdirectory.create(
          recursive: true); // Tạo thư mục cùng các thư mục cha nếu cần
    }

    // Tạo đường dẫn đầy đủ cho tệp mà bạn muốn lưu trong thư mục 'f1'
    String filePath = '$subdirectoryPath/my_data2.txt';

    // Tạo và ghi dữ liệu vào tệp
    File file = File(filePath);
    await file.writeAsString(
        'Hello, Flutter in f1 directory!'); // ghi đè khi file trùng tên

    debugPrint('File saved at: $filePath');
  }

// save file vào saveFileToParentDirectory của user mặc định(như C:\Users\Admin)
  Future<void> saveFileToParentDirectory() async {
    // Lấy đường dẫn đến thư mục app_flutter (thư mục tài liệu của ứng dụng)
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // Lấy đường dẫn đến thư mục cha của app_flutter
    Directory parentDirectory = documentsDirectory.parent;

    // Tạo đường dẫn đầy đủ cho tệp mà bạn muốn lưu trong thư mục cha của app_flutter
    String filePath = '${parentDirectory.path}/my_datapapa.txt';

    // Tạo và ghi dữ liệu vào tệp
    File file = File(filePath);
    await file.writeAsString('Hello, Flutter in the parent directory!');

    debugPrint('File saved at: $filePath');
  }
}
