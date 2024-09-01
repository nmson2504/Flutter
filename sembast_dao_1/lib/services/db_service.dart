import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DatabaseService {
  static Database? _database;
  static final _dbName = 'user_database.db';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    final dir = await getApplicationDocumentsDirectory();
    debugPrint(dir.path);
    final dbPath = join(dir.path, _dbName);
    _database = await databaseFactoryIo.openDatabase(dbPath);
    return _database!;
  }
}
