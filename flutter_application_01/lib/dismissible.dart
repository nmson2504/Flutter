import 'package:flutter/material.dart';

class MyDismissible extends StatelessWidget {
  const MyDismissible({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Dismissible')),
        body: const Dismissible04(),
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
            items.removeAt(index);
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
