import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_sqflite/sembast_sqflite.dart';
// import 'package:sqflite_common/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/* 
Nếu báo lỗi:
SqfliteFfiException (SqfliteFfiException(error, Invalid argument(s): Failed to load dynamic library 'sqlite3.dll': The specified module could not be found. (error code: 126)}) DatabaseException(Invalid argument(s): Failed to load dynamic library 'sqlite3.dll': The specified module could not be found. (error code: 126)))
thì đown file sqlite3.dll tại https://www.dll-files.com/download/1afdf73c0d1ba126c63927b423c55205/sqlite3.dll.html?c=WUE4bHYzTlNxKzdWTE5EM1E1UWZuZz09
chép vàp folder C:\Windows\System32
 */
Future main() async {
  // The sqflite base factory

  var factory = getDatabaseFactorySqflite(databaseFactoryFfi);

  var db = await factory.openDatabase('example.db');
  // Use the main store for storing key values as String
  var store = StoreRef<String, String>.main();

  // Writing the data
  await store.record('username').put(db, 'my_username');
  await store.record('url').put(db, 'my_url');

  // Reading the data
  var url = await store.record('url').get(db);
  var username = await store.record('username').get(db);

  debugPrint('url: $url');
  debugPrint('username: $username');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Sembast Sqflite Demo')),
        body:
            const Center(child: Text('Check console for database operations.')),
      ),
    );
  }
}
