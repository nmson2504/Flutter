import 'package:flutter/material.dart';

class MyNavigation3 extends StatelessWidget {
  const MyNavigation3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Returning Data Demo'),
        ),
        body: const Center(
          child: TodosScreen(
              todos: []), // Pass the todos to the TodosScreen widget.
        ),
      ),
    );
  }
}

// Return data from a screen về màn hình trước đó
// Example 1
class ScreenA extends StatefulWidget {
  const ScreenA({super.key});

  @override
  State<ScreenA> createState() => _ScreenAState();
}

class _ScreenAState extends State<ScreenA> {
  String _displayText = ''; // Biến để lưu trữ giá trị result

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Result:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            _displayText, // Hiển thị giá trị result
            style: const TextStyle(fontSize: 20, color: Colors.red),
          ),
          ElevatedButton(
            onPressed: () {
              _navigateToScreenB(
                  context); // Navigate to the second screen when tapped.
            },
            child: const Text('Pick an option, any option!'),
          ),
        ],
      ),
    );
  }

  _navigateToScreenB(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScreenB()),
    );
    // Xử lý dữ liệu trả về từ Màn hình chi tiết
    if (result != null) {
      setState(() {
        _displayText = result;
      });
    }
  }
}

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  // Close the screen and return 'ABC!' as the result.
                  Navigator.pop(context,
                      'ABC!'); // void pop<T extends Object?>(BuildContext context, [T? result])
                },
                child: const Text('ABC!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  // Close the screen and return '123.' as the result.
                  Navigator.pop(context,
                      '123.'); // void pop<T extends Object?>(BuildContext context, [T? result])
                },
                child: const Text('123.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Example 2 - Shows a SnackBar with the new result
class SelectionButton extends StatefulWidget {
  const SelectionButton({super.key});

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  String displayText = ''; // Biến để lưu trữ giá trị result

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Result:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            displayText, // Hiển thị giá trị result
            style: const TextStyle(fontSize: 20, color: Colors.red),
          ),
          ElevatedButton(
            onPressed: () {
              _navigateAndDisplaySelection(context);
            },
            child: const Text('Pick an option, any option!'),
          ),
        ],
      ),
    );
  }

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop.
  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectionScreen()),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) {
      return; // If the widget was removed from the tree while the asynchronous gap was waiting, we should not do anything.
    }

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar() // Removes the current SnackBar, if any.
      ..showSnackBar(SnackBar(
          content: Text('$result'))); // Shows a SnackBar with the new result.

    //get result from SelectionScreen and gán vô _displayText, show lên màn hình
    setState(() {
      displayText = result; // Cập nhật giá trị _displayText với kết quả result
    });
  }
}

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  // Close the screen and return "Yep!" as the result.
                  Navigator.pop(context,
                      'Yep!'); // void pop<T extends Object?>(BuildContext context, [T? result])
                },
                child: const Text('Yep!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  // Close the screen and return "Nope." as the result.
                  Navigator.pop(context,
                      'Nope.'); // void pop<T extends Object?>(BuildContext context, [T? result])
                },
                child: const Text('Nope.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//Send 1 data in list to a new screen
class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);
}

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key, required this.todos});

  final List<Todo> todos; // chỉ có thể gán giá trị 1 lần qua hàm constructor

  @override
  Widget build(BuildContext context) {
    final todos = List.generate(
      20,
      (i) => Todo(
        'Todo $i',
        'A description of Todo $i',
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(todo: todos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Todo.
  const DetailScreen({super.key, required this.todo});

  // Declare a field that holds the Todo.
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(todo.description),
      ),
    );
  }
}
