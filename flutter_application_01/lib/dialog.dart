import 'package:flutter/material.dart';

//
class MyDialog extends StatelessWidget {
  const MyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Dialog Demo')),
        body: const FullScreenDialog1(),
      ),
    );
  }
}

class Dialog1 extends StatelessWidget {
  const Dialog1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            onPressed: () => showDialog(
              // showDialog is a static method that takes a builder parameter
              context:
                  context, // context is the current BuildContext - required
              builder: (BuildContext context) => Dialog(
                //  builder is a function that returns a widget - required
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                shadowColor: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('This is a typical dialog.'),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // dismiss dialog - đóng dialog
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            child: const Text('Show Dialog'),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => Dialog.fullscreen(
                // fullscreen dialog - bung chiếm hết screen
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('This is a fullscreen dialog.'),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            ),
            child: const Text('Show Fullscreen Dialog'),
          ),
        ],
      ),
    );
  }
}

// AlertDialog
class AlertDialog1 extends StatelessWidget {
  const AlertDialog1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ActionChip(
            label: const Text('Open Dialog'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    icon: const Icon(Icons.warning),
                    iconColor: Colors.red,
                    title: const Text('Dialog Title'), // tiêu đề
                    content:
                        const Text('This is a dialog content.'), //  nội dung
                    actions: [
                      // nút
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('AlertDialog Title'),
                content: const Text('AlertDialog description'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            child: const Text('Show Dialog'),
          )
        ],
      ),
    );
  }
}

class AlertDialog2 extends StatelessWidget {
  const AlertDialog2({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Xác nhận'),
              content: const Text('Bạn có chắc muốn xóa mục này?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Đóng hộp thoại
                  },
                  child: const Text('Hủy'),
                ),
                TextButton(
                  onPressed: () {
                    // Thực hiện xóa mục ở đây
                    Navigator.of(context).pop(); // Đóng hộp thoại sau khi xong
                  },
                  child: const Text('Xóa'),
                ),
              ],
            );
          },
        );
      },
      child: const Text('Xóa Mục'),
    );
  }
}

class AlertDialog3 extends StatelessWidget {
  const AlertDialog3({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}

//
final List<String> items = ['Item 1', 'Item 2', 'Item 3'];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(items[index]),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showConfirmationDialog(context, index);
            },
          ),
        );
      },
    );
  }

  // This function displays a confirmation dialog with list data
  void _showConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                // Handle delete operation
                items.removeAt(index);
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

// SimpleDialog
class SimpleDialog1 extends StatelessWidget {
  const SimpleDialog1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
            child: const Text('SimpleDialog'),
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                      shadowColor: Colors.amber,
                      backgroundColor: Colors.blue,
                      title: const Text('My Options'),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Option 1',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Option 2',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ]);
                }))
      ],
    ));
  }
}

// SimpleDialog2
class SimpleDialog2 extends StatelessWidget {
  const SimpleDialog2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Khi nút được nhấn, hiển thị SimpleDialog
          _showDialog(context);
        },
        child: const Text('Mở SimpleDialog'),
      ),
    );
  }
}

// Hàm này hiển thị SimpleDialog
void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: const Text(
          'Chọn một tùy chọn',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        contentPadding: const EdgeInsets.all(16.0),
        backgroundColor: Colors.yellow[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        children: <Widget>[
          SimpleDialogOption(
              // An option used in a SimpleDialog.
              padding: const EdgeInsets.all(40), // Set padding cho option
              onPressed: () {
                // Xử lý tùy chọn 1
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: const Text('Tùy chọn 1',
                  style: TextStyle(
                    color: Colors.red,
                  ) // Set màu sắc ở đây.
                  )),
          SimpleDialogOption(
              // An option used in a SimpleDialog.
              onPressed: () {
                // Xử lý tùy chọn 2
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: const Text('Tùy chọn 2',
                  style: TextStyle(
                    color: Colors.red,
                  ) // Set màu sắc ở đây
                  )),
        ],
      );
    },
  );
}

// SimpleDialog3
class SimpleDialog3 extends StatelessWidget {
  const SimpleDialog3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Khi nút được nhấn, hiển thị SimpleDialog
          _showDialog3(context);
        },
        child: const Text('Mở SimpleDialog'),
      ),
    );
  }
}

void _showDialog3(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Set backup account'),
          children: [
            SimpleDialogItem(
              // call hàm SimpleDialogItem với các tham số kèm theo
              icon: Icons.account_circle,
              color: Colors.orange,
              text: 'user01@gmail.com',
              onPressed: () {
                Navigator.pop(context, 'user01@gmail.com');
              },
            ),
            SimpleDialogItem(
              icon: Icons.account_circle,
              color: Colors.green,
              text: 'user02@gmail.com',
              onPressed: () {
                Navigator.pop(context, 'user02@gmail.com');
              },
            ),
          ],
        );
      });
}

// Tạo item SimpleDialogOption cho SimpleDialog
class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem(
      {Key? key, this.icon, this.color, this.text, this.onPressed})
      : super(key: key);

  final IconData? icon;
  final Color? color;
  final String? text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 36.0, color: color),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: Text(text != null ? text.toString() : ''),
          ),
        ],
      ),
    );
  }
}

// FullScreenDialog
class FullScreenDialog1 extends StatelessWidget {
  const FullScreenDialog1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 182, 244, 249),
          foregroundColor: const Color.fromARGB(255, 210, 5, 203),
          padding: const EdgeInsets.all(15.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
        ),
        onPressed: () {
          // Future<T?> push<T extends Object?>(BuildContext context, Route<T> route)
          /* Dùng MaterialPageRoute để gọi FullScreenDialog() và set fullscreenDialog: true
          */
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const FullScreenDialog(),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Text("SHOW DIALOG"),
      ),
    );
  }
}

class FullScreenDialog extends StatelessWidget {
  const FullScreenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Phải có Scaffold để hiển thị AppBar
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6200EE),
        title: const Text('Full-screen Dialog'),
      ),
      body: const Center(
        child: Text("Full-screen dialog"),
      ),
    );
  }
}

// FullScreenDialog2
class FullScreenDialog2 extends StatelessWidget {
  const FullScreenDialog2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
//
