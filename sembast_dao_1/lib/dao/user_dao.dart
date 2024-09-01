// lib/dao/user_dao.dart

import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import '../models/user.dart';

abstract class UserDao {
  Future<int> addUser(User user);
  Future<User?> getUser(int id);
  Future<List<User>> getAllUsers();
  Future<void> updateUser(User user);
  Future<void> deleteUser(int id);
  Future<int> deleteUsersFilter(Finder finder);
  Future<List<User>> getUserFilter(Finder finder);
}
