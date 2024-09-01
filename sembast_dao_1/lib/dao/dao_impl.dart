// lib/dao/user_dao_impl.dart

import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import '../models/user.dart';
import 'user_dao.dart';

class UserDaoImpl implements UserDao {
  final Database _database;
  final _store = intMapStoreFactory.store('users');

  UserDaoImpl(this._database);

  @override
  Future<int> addUser(User user) async {
    return await _store.add(_database, user.toMap());
  }

  @override
  Future<User?> getUser(int id) async {
    final snapshot = await _store.record(id).getSnapshot(_database);
    if (snapshot == null) return null;
    return User.fromMap(snapshot.value);
  }

  @override
  Future<List<User>> getAllUsers() async {
    final snapshots = await _store.find(_database);
    return snapshots.map((snapshot) {
      final use = User.fromMap(snapshot.value);
      use.id = snapshot
          .key; // lấy key của record do database tự sinh(ko phải do coder gán) - rất quan trọng để thực hiện Update - Delete - Read về sau
      return use;
    }).toList();
  }

  @override
  Future<List<User>> getUserFilter(Finder finder) async {
    final db = await _database;
    final snapshots = await _store.find(db, finder: finder);
    return snapshots.map((snapshot) {
      final use = User.fromMap(snapshot.value);
      use.id = snapshot
          .key; // lấy key của record do database tự sinh - rất quan trọng để thực hiện Update - Delete - Read về sau
      return use;
    }).toList();
  }

  @override
  Future<void> updateUser(User user) async {
    await _store.record(user.id).update(_database, user.toMap());
  }

  @override
  Future<void> deleteUser(int id) async {
    int n = 0;
    try {
      n = await _store.delete(
        _database,
        finder: Finder(filter: Filter.byKey(id)),
      ); // Return the count updated. Delete all if no finder
      debugPrint('deleteUser - $n');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  @override
  Future<int> deleteUsersFilter(Finder f) async {
    int n = 0;

    try {
      n = await _store.delete(
        _database,
        finder: f,
      ); // Return the count updated. Delete all if no finder
      // debugPrint('$n');
    } catch (e) {
      print('Error deleting user: $e');
    }
    return n;
  }
}

// 