// lib/main.dart

import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'services/db_service.dart';
import 'dao/dao_impl.dart';
import 'models/user.dart';
import 'services/user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await DatabaseService.database;
  final userDao = UserDaoImpl(db);

  runApp(MyApp(userDao: userDao));
}

class MyApp extends StatelessWidget {
  final UserDaoImpl userDao;

  MyApp({required this.userDao});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DAO Example',
      home: UserListScreen(userDao: userDao),
    );
  }
}

class UserListScreen extends StatefulWidget {
  final UserDaoImpl userDao;

  UserListScreen({required this.userDao});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> _users = [];
  int countCheck = 0;
  int coundVIP = 0;
  bool _isAllChecked = false;
  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final users = await widget.userDao.getAllUsers();
    List<User> vipItems = users.where((item) => item.VIP == true).toList();
    coundVIP = vipItems.length;
    List<User> checkItems = users.where((item) => item.check == true).toList();
    countCheck = checkItems.length;

    setState(() {
      _users = users; // update users list mowis tuwf DB leen UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            // Tiêu đề cột
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                defaultColumnWidth: FlexColumnWidth(),
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(1), // Thêm cột cho nút update
                  5: FlexColumnWidth(1), // Thêm cột cho nút delete
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Select'))),
                      TableCell(child: Center(child: Text('VIP'))),
                      TableCell(child: Center(child: Text('Name'))),
                      TableCell(child: Center(child: Text('Age'))),
                      TableCell(child: Center(child: Text('Update'))),
                      TableCell(child: Center(child: Text('Delete'))),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Select')),
                    DataColumn(label: Text('VIP')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Age')),
                    DataColumn(label: Text('Update')),
                    DataColumn(label: Text('Delete')),
                  ],
                  rows: _users.map((user) {
                    return DataRow(
                      cells: [
                        DataCell(Checkbox(
                          checkColor: const Color.fromARGB(255, 75, 218, 236),
                          activeColor: Colors.brown,
                          value: user.check,
                          onChanged: (bool? value) {
                            setState(() {
                              user.check =
                                  value ?? false; // update UI, non update DB
                            });
                            _updateCheckState();
                          },
                        )),
                        DataCell(Checkbox(
                          value: user.VIP,
                          onChanged: (bool? value) {
                            setState(() {
                              user.VIP = value ?? false;
                              widget.userDao.updateUser(user); // update in DB
                              coundVIP += (value == true) ? 1 : -1;
                            });
                          },
                        )),
                        DataCell(
                            Text('${_users.indexOf(user) + 1} ${user.name}')),
                        DataCell(Text('${user.age}')),
                        DataCell(IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.blue,
                          tooltip: 'Update',
                          onPressed: () async {
                            // Show the dialog to edit the user
                            final updatedUser = await showDialog<User>(
                              context: context,
                              builder: (BuildContext context) {
                                String? newName = user.name;
                                String? newAge = user.age.toString();
                                return AlertDialog(
                                  title: Text('Edit User'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: TextEditingController(
                                            text: newName),
                                        decoration:
                                            InputDecoration(labelText: 'Name'),
                                        onChanged: (value) {
                                          newName = value;
                                        },
                                      ),
                                      TextField(
                                        controller:
                                            TextEditingController(text: newAge),
                                        decoration:
                                            InputDecoration(labelText: 'Age'),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          newAge = value;
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Update'),
                                      onPressed: () {
                                        Navigator.of(context).pop(User(
                                          id: user.id,
                                          name: newName ?? user.name,
                                          age: int.tryParse(newAge ?? '') ??
                                              user.age,
                                          VIP: user.VIP,
                                          check: user.check,
                                        ));
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

                            if (updatedUser != null) {
                              // Update the user in the database
                              await widget.userDao.updateUser(updatedUser);
                              _loadUsers(); // Refresh the list
                            }
                          },
                        )),
                        DataCell(IconButton(
                          icon: Icon(Icons.delete),
                          color: const Color.fromARGB(255, 161, 37, 28),
                          tooltip: 'Delete',
                          onPressed: () async {
                            bool? confirmed = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete Confirmation'),
                                  content: Text(
                                      'Are you sure you want to delete ${user.name}?'),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(false); // Dismiss the dialog
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Delete'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(true); // Confirm the deletion
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmed == true) {
                              await widget.userDao.deleteUser(user.id);
                              _loadUsers();
                            }
                          },
                        )),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.delete_sweep),
              onPressed: () async {
                debugPrint('Delete sweep pressed');
                _deleteCheckedUsers(); // tuy chưa update khoá 'check' vào DB nhưng vẫn delete ok
                _loadUsers();
              },
              tooltip: 'Delete check items col 1 - check on UI',
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                debugPrint('Delete VIP pressed');
                final finder = Finder(filter: Filter.equals('VIP', true));
                var countDelete =
                    await widget.userDao.deleteUsersFilter(finder);
                debugPrint('Đã xoá $countDelete users');
                _loadUsers();
              },
              tooltip: 'Delete check items col2- check on DB',
            ),
            Text('Items Select: $countCheck'),
            Text(' || '),
            Text('Items VIP: $coundVIP'),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            mini: true,
            tooltip: 'Add User',
            onPressed: () async {
              final newUser = UserService.generateRandomUser();
              await widget.userDao.addUser(newUser);
              _loadUsers();
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            mini: true,
            tooltip: _isAllChecked ? 'Uncheck All' : 'Check All',
            onPressed: _toggleCheckAll,
            child: Icon(
              _isAllChecked ? Icons.check_box : Icons.check_box_outline_blank,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
    );
  }

// tuy chưa update khoá 'check' vào DB nhưng vẫn delete ok do check trạng thái checkbox
  void _deleteCheckedUsers() async {
    final usersToDelete = _users.where((user) => user.check).toList();
    for (var user in usersToDelete) {
      await widget.userDao.deleteUser(user.id);
    }
    _loadUsers();
  }

  void _toggleCheckAll() {
    setState(() {
      _isAllChecked = !_isAllChecked;
      _users.forEach((user) {
        user.check = _isAllChecked;
      });
      countCheck = _isAllChecked ? _users.length : 0; // Cập nhật countCheck
    });
  }

  void _updateCheckState() {
    setState(() {
      int checkedCount = _users.where((user) => user.check).length;
      _isAllChecked = checkedCount == _users.length;
      countCheck =
          checkedCount; // Cập nhật countCheck dựa trên số items đã check
    });
  }
}
