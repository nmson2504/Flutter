import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Khởi tạo Hive

  await Hive.initFlutter();
  await Hive.openBox('demoBox'); // Mở box tên là demoBox

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive CRUD Demo Full Method',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box box;
  String? startKey;
  String? endKey;
  @override
  void initState() {
    super.initState();
    box = Hive.box('demoBox'); // Lấy box để làm việc
  }

  // Hàm phát sinh 5 record ban đầu
  void _generateRecords() {
    for (int i = 0; i < 5; i++) {
      box.add('Value $i');
    }
    setState(() {}); // Refresh giao diện
  }

  // Hàm thêm record mới
  /* box.put(key,value) - Thêm hoặc cập nhật dữ liệu bằng key.
      - Nếu key đã tồn tại, nó sẽ cập nhật giá trị.
      - Nếu key không tồn tại, nó sẽ thêm một cặp key-value mới.
   */
  void _addRecordPut() {
    int newIndex = box.length;
    box.put('key_$newIndex', 'Value put $newIndex');
    setState(() {});
  }

//  box.add('value') - Thêm dữ liệu không cần key, Hive tự động gán key dạng index(int start from 0 & auto increment)
// các records được thêm bằng hàm .add index luôn liền kề nhau dù có các record thêm bằng .put xen kẽ vào, các record thêm với put sẽ bị đẩy ra phía sau
  void _addRecordAdd() {
    int newIndex = box.length;
    box.add('Value add $newIndex');
    setState(() {});
  }

  // Hàm đọc dữ liệu
  // box.get('key'); - Lấy giá trị dựa trên key
  // Returns the value associated with the given [key]. If the key does not exist, null is returned.
// If [defaultValue] is specified, it is returned in case the key does not exist.
  void _getRecord(String key) {
    final value = box.get(key, defaultValue: 'Not Found');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Key: $key, Value: $value')),
    );
  }

//  box.getAt(0) - getAt(int index); // Lấy giá trị theo index
  void _getAtRecord(int key) {
    final value = box.getAt(
      key,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Index: $key, Value: $value'),
        behavior: SnackBarBehavior.floating, // Giúp snackbar dễ tương tác hơn
        dismissDirection: DismissDirection.up, // Cho phép vuốt ẩn. Default is [DismissDirection.down].
      ),
    );
  }

//  keyAt(int index) - Get the n-th key in the box theo index.
  void _keyAt() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select an Index'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: box.keys.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Index: $index'),
                  onTap: () {
                    final key = box.keyAt(index);
                    Navigator.of(context).pop(); // Đóng hộp thoại
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Key at index $index: $key'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

// get list keys
  void getSelectedKeys() {
    final keys = box.keys.toList(); // Lấy danh sách key từ box
    final selectedKeys = <dynamic>[]; // Danh sách các key được chọn

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select Keys'),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    final key = keys[index];
                    return ListTile(
                      leading: Checkbox(
                        value: selectedKeys.contains(key),
                        onChanged: (bool? isSelected) {
                          setState(() {
                            if (isSelected == true) {
                              selectedKeys.add(key);
                            } else {
                              selectedKeys.remove(key);
                            }
                          });
                        },
                      ),
                      title: Text('Key: $key'),
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Hiển thị danh sách các key đã chọn
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Selected Keys: ${selectedKeys.join(', ')}'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.of(context).pop(); // Đóng hộp thoại
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Hàm sửa record
  // box.put(key, value) - cập nhật dữ liệu qua key(if key not tồn tại thì tạo mới)
  void _updateRecordPut(key) {
    if (box.containsKey(key)) {
      box.put(key, '_updateRecordPut Value for $key');
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Key $key not found!')),
      );
    }
  }

  // box.putAt(index, value) - cập nhật dữ liệu qua index(if index không tồn tại, Hive sẽ ném ngoại lệ RangeError)
  void _updateRecordPutAt(key) {
    int index = key;
    if (index >= 0 && index < box.length) {
      // cách kiểm tra sự tồn tại của index
      box.putAt(key, '_updateRecordPutAt Value for $key');
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Index $key not found!')),
      );
    }
  }

  // putAll(Map<dynamic, dynamic> entries) - Saves all the key - value pairs in the [entries] map.
  void _updateRecordPutAll() {
    Map<dynamic, dynamic> data = {
      1: 'John Doe',
      2: 30,
      'name': 'nmson',
    };
    box.putAll(data);
    setState(() {});
  }

  // Hàm xóa record
  /*
  Nên khai báo key có type is dynamic để tương thích với các record thêm bằng lệnh box.add 
   */
  //   box.delete(key);
  void _deleteRecord(key) {
    if (box.containsKey(key)) {
      box.delete(key);
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Key $key not found!')),
      );
    }
  }

  // Xóa tại index 0, các index phía sau sẽ dồn lên
  // delete(dynamic key)
  void _deleteAtRecord() {
    // kiểm tra với box.containsKey thì chỉ xoá được lần đầu tiên dù index 0 luôn tồn tại và print ra được
    // Dùng cách của hàm _deleteAtRecord1 để xử lý
    if (box.containsKey(0)) {
      box.delete(0);
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Key 0 not found!')),
      );
    }
  }

// deleteAt(int index)
  void _deleteAtRecord1() {
    int indexToDelete = 0;
    if (indexToDelete < box.length) {
      // box.
      box.deleteAt(indexToDelete);
      indexToDelete = 0; // Phải Reset lại index cho lần xóa tiếp theo
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Key $indexToDelete not found!')),
      );
    }
  }

  // deleteAll(Iterable<dynamic> keys)
  // Deletes all the given [keys] from the box.
  // If a key does not exist, it is skipped.
  void deleteAllKeys() {
    final keys = box.keys.toList(); // Lấy danh sách key từ box
    final selectedKeys = <dynamic>[]; // Danh sách các key được chọn

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select Keys to Delete'),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    final key = keys[index];
                    return ListTile(
                      leading: Checkbox(
                        value: selectedKeys.contains(key),
                        onChanged: (bool? isSelected) {
                          setState(() {
                            if (isSelected == true) {
                              selectedKeys.add(key);
                            } else {
                              selectedKeys.remove(key);
                            }
                          });
                        },
                      ),
                      title: Text('Key: $key'),
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    box.deleteAll(selectedKeys); // Xóa các key được chọn
                    setState(() {}); // Làm mới giao diện sau khi xóa
                    Navigator.of(context).pop(); // Đóng hộp thoại
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Hàm xóa tất cả record - Removes all entries from the box
  // box.clear();
  void _clearRecords() {
    box.clear();
    setState(() {});
  }

  // Hàm get all keys
  // box.keys.toList()
  void _getAllKeys() {
    var keys = box.keys.toList(); // Lấy danh sách key
    debugPrint(keys.toString());
    for (int index = 0; index < box.keys.length; index++) {
      var key = box.keys.toList()[index];
      var value = box.getAt(index);
      print('Index: $index, Key: $key, Value: $value');
    }
    setState(() {});
  }

//  box.values; - Chỉ get values, ko kèm key
  void _getValues() {
    var allValues = box.values; // Lấy tất cả giá trị trong box
    debugPrint(allValues.runtimeType.toString());
    debugPrint(allValues.toString());
    for (var value in allValues) {
      debugPrint(value.toString()); // In từng record
    }
    setState(() {});
  }

  // not use method valuesBetween({dynamic startKey, dynamic endKey})
// dùng for để lọc    
  void _getValuesBetween() {
    var allKeys = box.keys.toList(); // Lấy tất cả key từ box

    // Khởi tạo giá trị mặc định cho startKey và endKey
    dynamic startKey;
    dynamic endKey;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select startKey and endKey'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Dropdown để chọn startKey
                    DropdownButton<dynamic>(
                      hint: const Text('Select startKey'),
                      value: startKey,
                      items: allKeys.map((key) {
                        return DropdownMenuItem<dynamic>(
                          value: key,
                          child: Text('$key'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          startKey = value;
                        });
                      },
                    ),
                    // Dropdown để chọn endKey
                    DropdownButton<dynamic>(
                      hint: const Text('Select endKey'),
                      value: endKey,
                      items: allKeys.map((key) {
                        return DropdownMenuItem<dynamic>(
                          value: key,
                          child: Text('$key'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          endKey = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Kiểm tra xem người dùng đã chọn startKey và endKey hay chưa
                    if (startKey != null && endKey != null) {
                      List<dynamic> filteredKeys = [];
                      bool isInRange = false;

                      // Lọc các key nằm giữa startKey và endKey
                      for (var key in allKeys) {
                        if (key == startKey) {
                          isInRange = true;
                        }
                        if (isInRange) {
                          filteredKeys.add(key);
                        }
                        if (key == endKey) {
                          break;
                        }
                      }

                      // Lấy các giá trị tương ứng với các key đã chọn
                      List<dynamic> filteredValues = [];
                      for (var key in filteredKeys) {
                        filteredValues.add(box.get(key));
                      }

                      // Hiển thị kết quả
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Filtered Values: ${filteredValues.join(', ')}'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select both startKey and endKey')),
                      );
                    }

                    Navigator.of(context).pop();
                  },
                  child: const Text('Get Values'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // use method valuesBetween({dynamic startKey, dynamic endKey})
  void _getValuesBetween2() {
    // Lấy tất cả các key trong box
    var allKeys = box.keys.toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select startKey and endKey'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Dropdown cho startKey
                    DropdownButton<dynamic>(
                      hint: const Text('Select startKey'),
                      value: startKey,
                      items: allKeys.map((key) {
                        return DropdownMenuItem<dynamic>(
                          value: key,
                          child: Text('$key'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          startKey = value;
                        });
                      },
                    ),
                    // Dropdown cho endKey
                    DropdownButton<dynamic>(
                      hint: const Text('Select endKey'),
                      value: endKey,
                      items: allKeys.map((key) {
                        return DropdownMenuItem<dynamic>(
                          value: key,
                          child: Text('$key'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          endKey = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (startKey != null && endKey != null) {
                      // Lấy giá trị nằm trong phạm vi startKey và endKey
                      var filteredValues = box.valuesBetween(startKey: startKey, endKey: endKey);

                      // Hiển thị kết quả
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Filtered Values: ${filteredValues.join(', ')}'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select both startKey and endKey')),
                      );
                    }

                    Navigator.of(context).pop();
                  },
                  child: const Text('Get Values'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive CRUD Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, Box box, _) {
                if (box.isEmpty) {
                  return const Center(
                    child: Text('No data available.'),
                  );
                }
                return ListView.builder(
                  itemCount: box.keys.length,
                  itemBuilder: (context, index) {
                    final key = box.keys.toList()[index];
                    final value = box.get(key);
                    return ListTile(
                      title: Text('$key: $value'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            tooltip: "_updateRecordPut",
                            onPressed: () => _updateRecordPut(key),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit_attributes),
                            tooltip: "_updateRecordPutAt",
                            onPressed: () => _updateRecordPutAt(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            tooltip: "Delete",
                            onPressed: () => _deleteRecord(key),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _generateRecords,
                    child: const Text('Generate 5 Records'),
                  ),
                  ElevatedButton(
                    onPressed: _addRecordPut,
                    child: const Text('box.put Record'),
                  ),
                  ElevatedButton(
                    onPressed: _addRecordAdd,
                    child: const Text('box.add Record'),
                  ),
                  ElevatedButton(
                    onPressed: () => _updateRecordPutAll(),
                    child: const Text('box.putAll Records'),
                  ),
                ],
              ),
              /* 
              onPressed nhận một hàm dạng void Function(), nghĩa là một hàm không có tham số và không trả về giá trị.
              Khi bạn viết   onPressed: _getRecord('key'), bạn đang thực thi ngay lập tức hàm đó, và giá trị trả về (trong trường hợp này là void) được gán vào onPressed, dẫn đến lỗi.
              Thay vì gọi trực tiếp, bạn cần bọc lời gọi hàm trong một lambda hoặc closure để trì hoãn việc gọi hàm.
               onPressed: () => _getRecord('key'), // Dùng lambda để trì hoãn việc gọi hàm
               */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _clearRecords,
                    child: const Text('Clear All'),
                  ),
                  ElevatedButton(
                    onPressed: deleteAllKeys,
                    child: const Text('Delete list keys'),
                  ),
                  ElevatedButton(
                    onPressed: _deleteAtRecord1,
                    child: const Text('_deleteAtRecord1 index 0'),
                  ),
                  ElevatedButton(
                    onPressed: _deleteAtRecord,
                    child: const Text('_deleteAtRecord index 0'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _getAllKeys,
                    child: const Text('Get all keys'),
                  ),
                  ElevatedButton(
                    onPressed: _getValues,
                    child: const Text('Get all values'),
                  ),
                  ElevatedButton(
                    onPressed: getSelectedKeys,
                    child: const Text('Get selected keys'),
                  ),
                  ElevatedButton(
                    onPressed: () => _getRecord('key_5'), // Dùng lambda để trì hoãn việc gọi hàm
                    child: const Text('Get by key'),
                  ),
                  ElevatedButton(
                    onPressed: () => _getAtRecord(1),
                    child: const Text('Get by index'),
                  ),
                  ElevatedButton(
                    onPressed: () => _keyAt(),
                    child: const Text('Get key by keyAt'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _getValuesBetween,
                    child: const Text('Get Values Between'),
                  ),
                  ElevatedButton(
                    onPressed: _getValuesBetween2,
                    child: const Text('Get Values Between 2'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
