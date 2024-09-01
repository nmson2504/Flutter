import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyDismissible extends StatelessWidget {
  const MyDismissible({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Dismissible')),
        body: const Dismissible02(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

// Example 1 - Delete item from list
class Dismissible01 extends StatefulWidget {
  const Dismissible01({super.key});

  @override
  State<Dismissible01> createState() => _DismissibleExampleState();
}

class _DismissibleExampleState extends State<Dismissible01> {
  List<int> items = List<int>.generate(100, (int index) => index);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.symmetric(vertical: 15),
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          background: Container(
            // set background when gesture on items
            color: Colors.green,
          ),
          key: ValueKey<int>(items[index]),
          onDismissed: (DismissDirection direction) {
            setState(() {
              items.removeAt(index);
            });
          },
          child: ListTile(
            title: Text(
              'Item ${items[index]}',
            ),
          ),
        );
      },
    );
  }
}

// Example 2 - Delete items from list 2
//  StatelessWidget setState(() ko lỗi index, chỉ remove items trên UI, ko update DB
class Dismissible02 extends StatelessWidget {
  const Dismissible02({super.key});
  static List<String> items = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8",
    "Item 9"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          key: Key(item),
          onDismissed: (direction) {
            // Remove the item from the data source

            // Show a snackbar with the item name
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$item dismissed'),
              ),
            );
          },
          background: Container(
            color: Colors.red,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: ListTile(
            title: Text(item),
          ),
        );
      },
    );
  }

  void setState(Null Function() param0) {}
}

// StatefulWidget - setState update data not lỗi index
class Dismissible02a extends StatefulWidget {
  const Dismissible02a({super.key});

  @override
  _DismissibleListState createState() => _DismissibleListState();
}

class _DismissibleListState extends State<Dismissible02a> {
  // Initialize the list with some items
  List<String> items = List.generate(10, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dismissible List'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            key: Key(item),
            onDismissed: (direction) {
              // setState giúp đảm bảo rằng các thay đổi trong danh sách items được đồng bộ hóa với giao diện người dùng, giúp tránh lỗi RangeError.
              setState(() {
                // Remove the item from the data source
                items.removeAt(index);
              });
              // Show a snackbar with the item name
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$item dismissed'),
                ),
              );
            },
            background: Container(
              color: Colors.red,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              title: Text(item),
            ),
          );
        },
      ),
    );
  }
}

// StatelessWidget - delete on DB
// ValueListenableBuilder theo dõi ValueNotifier và cập nhật giao diện khi ValueNotifier.value thay đổi.
/* 
Khởi Tạo: ValueNotifier là một lớp trong Flutter giúp bạn quản lý và theo dõi sự thay đổi của một giá trị. Khi giá trị của ValueNotifier thay đổi, tất cả các widget hoặc listener đăng ký sẽ được thông báo và cập nhật giao diện.
Cập Nhật Giá Trị: Bạn có thể cập nhật giá trị của ValueNotifier thông qua thuộc tính value. Mọi thay đổi giá trị sẽ kích hoạt các listener đã đăng ký với ValueNotifier.
Khi ValueListenableBuilder nhận được giá trị mới từ _itemsNotifier, nó sẽ xây dựng lại ListView.builder với danh sách mới.
 */
class Dismissible02b extends StatelessWidget {
  Dismissible02b({super.key});
  final ValueNotifier<List<String>> _itemsNotifier =
      ValueNotifier(List.generate(11, (index) => 'Item $index'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dismissible02b List'),
      ),
      body: ValueListenableBuilder<List<String>>(
        valueListenable: _itemsNotifier,
        builder: (context, items, child) {
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Dismissible(
                key: Key(item),
                onDismissed: (direction) {
                  items.removeAt(index);
                  // Notify listeners about the change
                  _itemsNotifier.value = List.from(
                      items); // cập nhật list sau khi xoá item vào _itemsNotifier
                  // Show a snackbar with the item name
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$item dismissed'),
                    ),
                  );
                },
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: ListTile(
                  title: Text(item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Example 3 - Chuyển trang khi Dismiss

class Dismissible03 extends StatelessWidget {
  const Dismissible03({super.key});
  static List<String> items = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8",
    "Item 9"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          key: Key(item),
          onDismissed: (direction) {
            // Remove the item from the data source
            items.removeAt(index);
            // Navigate to a new page when dismissed
            // Với .pushReplacement, trang hiện tại bị loại bỏ khỏi ngăn xếp và thay thế bằng trang mới. Người dùng không thể quay lại trang hiện tại từ trang mới bằng cách sử dụng nút "Back".
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => ReplacementPage(item),
              ),
            );
          },
          background: Container(
            color: Colors.red,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: ListTile(
            title: Text(item),
          ),
        );
      },
    );
  }
}

class ReplacementPage extends StatelessWidget {
  final String itemName;

  const ReplacementPage(this.itemName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Replacement Page'),
      ),
      body: Center(
        child: Text('$itemName dismissed. Do something else on this page.'),
      ),
    );
  }
}

// Example 4 - Chuyển trang khi Dismiss và back to the home page

class Dismissible04 extends StatelessWidget {
  const Dismissible04({super.key});
  static List<String> items = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8",
    "Item 9"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          // dragStartBehavior: DragStartBehavior.start,
          key: Key(item),
          onDismissed: (direction) {
            // Remove the item from the data source
            items.removeAt(index);
            // Navigate to a new page when dismissed
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => ReplacementPage(item),
              ),
            );
          },
          background: Container(
            color: Colors.red,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: ListTile(
            title: Text(item),
          ),
        );
      },
    );
  }
}

class ReplacementPage1 extends StatelessWidget {
  final String itemName;

  const ReplacementPage1(this.itemName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Replacement Page'),
      ),
      body: Center(
        child: Text('$itemName dismissed. Do something else on this page.'),
      ),
    );
  }
}
