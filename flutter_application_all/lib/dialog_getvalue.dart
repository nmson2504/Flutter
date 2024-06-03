import 'package:flutter/material.dart';

//
class MyDialogGetValue extends StatelessWidget {
  const MyDialogGetValue({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Dialog Get Value Demo')),
        body: const GetValue4(),
      ),
    );
  }
}

// Get input value from dialog dùng .then((result) { ... })
class GetValue0 extends StatelessWidget {
  const GetValue0({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyWidget();
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String _inputValue = ''; // Biến để lưu trữ giá trị nhập từ hộp thoại

  void _openDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter a Value'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                _inputValue = value;
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(_inputValue);
                debugPrint(_inputValue);
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((result) {
      // .then((result) { ... }) để lấy giá trị trả về từ hộp thoại
      setState(() {
        _inputValue = result ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Entered Value: $_inputValue'), // Hiển thị giá trị nhập vào
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _openDialog,
            child: const Text('Open Dialog'),
          ),
        ],
      ),
    );
  }
}

// Get input value from dialog dùng async/await - sử dụng trong trường hợp cần xử lý bất đồng bộ
class GetValue1 extends StatelessWidget {
  const GetValue1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _inputValue = ''; // Biến để lưu trữ giá trị nhập từ hộp thoại

  void _openDialog() async {
    String? result = await showDialog(
      // async/await để chờ kết quả trả về từ hộp thoại. sử dụng trong trường hợp cần xử lý bất đồng bộ
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter a Value'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                _inputValue = value;
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(_inputValue);
                debugPrint(_inputValue);
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    setState(() {
      _inputValue = result ??
          ''; // Nếu người dùng không nhập giá trị thì gán giá trị rỗng
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Entered Value: $_inputValue'), // Hiển thị giá trị nhập vào
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _openDialog,
            child: const Text('Open Dialog'),
          ),
        ],
      ),
    );
  }
}

//
// Get values from CheckboxListTile and RadioListTile from dialog
class GetValue2 extends StatelessWidget {
  const GetValue2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage2();
  }
}

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({super.key});

  @override
  State<MyHomePage2> createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  List<String> _selectedValues = [];
  String _selectedRadioValue = '';

  void _openCheckboxDialog() async {
    List<String>? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select values'),
          content: StatefulBuilder(
              // StatefulBuilder để cập nhật lại giao diện khi click trên checkbox
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CheckboxListTile(
                  title: const Text('Value 1'),
                  value: _selectedValues.contains(
                      'Value 1'), // nếu list chứa 'Value 1' thì value = true, ngược lại value = false
                  onChanged: (bool? value) {
                    setState(() {
                      if (value ?? false) {
                        // nếu value = true thì add 'Value 1' vào list, ngược lại remove 'Value 1' khỏi list
                        _selectedValues.add('Value 1');
                      } else {
                        _selectedValues.remove('Value 1');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Value 2'),
                  value: _selectedValues.contains('Value 2'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value ?? false) {
                        _selectedValues.add('Value 2');
                      } else {
                        _selectedValues.remove('Value 2');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Value 3'),
                  value: _selectedValues.contains('Value 3'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value ?? false) {
                        _selectedValues.add('Value 3');
                      } else {
                        _selectedValues.remove('Value 3');
                      }
                    });
                  },
                ),
              ],
            );
          }),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context)
                    .pop(_selectedValues); // result = .pop(value)
                debugPrint(_selectedValues.toString());
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // result = null
                debugPrint(_selectedValues.toString());
              },
            ),
          ],
        );
      },
    );
    if (result != null) {
      setState(() {
        _selectedValues = result;
      });
    }
  }

  void _openRadioDialog() async {
    String? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a value'),
          content: StatefulBuilder(
              // StatefulBuilder để cập nhật lại giao diện khi click trên radio button
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: const Text('Value 1'),
                  value: 'Value 1',
                  groupValue: _selectedRadioValue,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRadioValue = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Value 2'),
                  value: 'Value 2',
                  groupValue: _selectedRadioValue,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRadioValue = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Value 3'),
                  value: 'Value 3',
                  groupValue: _selectedRadioValue,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRadioValue = value!;
                    });
                  },
                ),
              ],
            );
          }),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context)
                    .pop(_selectedRadioValue); // result = .pop(value)
                debugPrint(_selectedRadioValue);
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // result = null
                debugPrint(_selectedRadioValue.toString());
              },
            ),
          ],
        );
      },
    );
    if (result != null) {
      setState(() {
        _selectedRadioValue = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              'Selected Values: ${_selectedValues.join(', ')}'), // Show the selected values from the checkbox list
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _openCheckboxDialog,
            child: const Text('Open Checkbox Dialog'),
          ),
          const SizedBox(height: 20),
          Text(
              'Selected Value: $_selectedRadioValue'), // Show the selected value from the radio button list
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _openRadioDialog,
            child: const Text('Open Radio Dialog'),
          ),
        ],
      ),
    );
  }
}

// Get 1 value in list item on SimpleDialog - click choose item là gọi action luôn
class GetValue3 extends StatelessWidget {
  const GetValue3({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage3();
  }
}

class MyHomePage3 extends StatefulWidget {
  const MyHomePage3({super.key});

  @override
  State<MyHomePage3> createState() => _MyHomePage3State();
}

class _MyHomePage3State extends State<MyHomePage3> {
  String _selectedValue = '';

  void _openDialog() async {
    String result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select a value'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop('Value 1');
              },
              child: const Text('Value 1'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop('Value 2');
              },
              child: const Text('Value 2'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop('Value 3');
              },
              child: const Text('Value 3'),
            ),
          ],
        );
      },
    );

    setState(() {
      _selectedValue = result;
    });
    debugPrint(_selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Selected Value: $_selectedValue'), // Show the selected value
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _openDialog,
            child: const Text('Open SimpleDialogOption'),
          ),
        ],
      ),
    );
  }
}

// Get values from ListView in AlertDialog
class GetValue4 extends StatelessWidget {
  const GetValue4({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyWidgetListView();
  }
}

class MyWidgetListView extends StatefulWidget {
  const MyWidgetListView({super.key});

  @override
  State<MyWidgetListView> createState() => _MyWidgetListViewState();
}

class _MyWidgetListViewState extends State<MyWidgetListView> {
  String _selectedItem = ''; // Biến để lưu trữ mục được chọn từ danh sách

  void _openDialog() async {
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select an Item'),
          content: SizedBox(
            width: 300,
            child: ListView.builder(
                itemCount: 50, // Số lượng phần tử bạn muốn tạo
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                    onTap: () {
                      Navigator.of(context).pop('Item $index');
                    },
                  );
                }),
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedItem = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Selected Value: $_selectedItem'), // Show the selected value
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _openDialog,
            child: const Text('Open AlertDialog ListView'),
          ),
        ],
      ),
    );
  }
}
