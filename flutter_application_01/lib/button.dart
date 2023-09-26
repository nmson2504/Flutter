import 'package:flutter/material.dart';

// Khai báo các loại button
class MyButtonApp extends StatelessWidget {
  const MyButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Buttons')),
        body: const IconButtonExampleApp(),
      ),
    );
  }
}

// demo chung
class MyButton01 extends StatelessWidget {
  const MyButton01({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Xử lý khi button được nhấn
            },
            child: const Text('Elevated Button'),
          ),
          TextButton(
            onPressed: () {
              // Xử lý khi button được nhấn
            },
            child: const Text('Text Button'),
          ),
          OutlinedButton(
            onPressed: () {
              // Xử lý khi button được nhấn
            },
            child: const Text('Outlined Button'),
          ),
          IconButton(
            onPressed: () {
              // Xử lý khi button được nhấn
            },
            icon: const Icon(Icons.star),
          ),
          FloatingActionButton(
            onPressed: () {
              // Xử lý khi button được nhấn
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

// IconButton
/// Flutter code sample for [IconButton].

class IconButtonExampleApp extends StatelessWidget {
  const IconButtonExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const IconButtonExample();
  }
}

int _volume = 0;

class IconButtonExample extends StatefulWidget {
  const IconButtonExample({super.key});

  @override
  State<IconButtonExample> createState() => _IconButtonExampleState();
}

class _IconButtonExampleState extends State<IconButtonExample> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.volume_up),
          tooltip: 'Increase volume by 10',
          onPressed: () {
            setState(() {
              if (_volume < 100) _volume += 10;
            });
          },
        ),
        Text('Volume : $_volume'),
      ],
    );
  }
}

/* FlutterError (No MaterialLocalizations found - return MaterialApp(
        home: Scaffold(...
 */
class MyButtonAppError1 extends StatelessWidget {
  const MyButtonAppError1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Alert Dialog Example')),
            body: Center(
              child: FloatingActionButton(onPressed: () {
                // Hiển thị hộp thoại khi button được nhấn

                showDialog(
                    context: context,
                    builder: (ctxt) => new AlertDialog(
                          title: const Text("Text Dialog"),
                        ));
              }),
              // child: Text('Hiển thị Hộp thoại'),
            )));
  }
}

/* FlutterError (No MaterialLocalizations found - return MaterialApp(
        home: Scaffold(
 */
class MyButtonAppError2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(
            context: context,
            builder: (ctxt) => new AlertDialog(
                  title: Text("Text Dialog"),
                ));
      }),
    ));
  }
}

// return MaterialApp ở widget cha
class MyButtonApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyAppImpl());
  }
}

class MyAppImpl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Alert Dialog Example')),
        body: Center(
          child: TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctxt) => new AlertDialog(
                        title: Text("Text Dialog"),
                      ));
            },
            child: Text('Text Button'),
          ),
        ));
  }
}

// Test properties
class MyButtonApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyAppImpl1());
  }
}

class MyAppImpl1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Test Properties Example')),
        body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Color.fromARGB(255, 250, 253, 66), // cũ là primary
              foregroundColor: Color.fromARGB(163, 14, 246, 2),
              disabledBackgroundColor: Color.fromARGB(255, 223, 234, 238),
              disabledForegroundColor: const Color.fromARGB(221, 42, 29, 29),
              //  minimumSize: Size(110, 20),
              // maximumSize: Size(160, 20)
              padding: EdgeInsets.all(30),
              elevation: 10, // độ nổi (elevation) 3D so với nền
              shadowColor:
                  Colors.blue, // phải set elevation > 0 mới có tác dụng
              side: BorderSide(
                // viền button
                color: Colors.blue,
                width: 2.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    20), // Đặt hình dáng thành hình tròn với bán kính 20
              ),
            ),

            onHover: (value) {
              print('onHover: .......');
            },
            onLongPress: () {
              // ấn giữ button
              print('onLongPress:.........');
            },
            onPressed: () {
              print('onPressed - ElevatedButton');
              // Lấy chủ đề hiện tại
              ThemeData theme = Theme.of(context);

              // Lấy kiểu mặc định của nút
              ButtonThemeData buttonTheme = theme.buttonTheme;

              // In ra các giá trị kiểu mặc định của nút
              print("Height: ${buttonTheme.height}");
              print("Width: ${buttonTheme.minWidth}");
              print("Màu nền: ${buttonTheme.colorScheme?.primary}");
              print("Màu chữ: ${buttonTheme.textTheme}");
              //
              // ElevatedButtonThemeData btn2 = theme.canvasColor;
            },

            // onPressed: null, // disable button
            child: Text('Elevated Button'),
          ),
        ));
  }
}

/////
class MyButtonApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyAppImpl3());
  }
}

class MyAppImpl3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Test Properties Example 2')),
        body: Center(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Color.fromARGB(255, 250, 253, 66), // cũ là primary
              foregroundColor:
                  Color.fromARGB(163, 14, 246, 2), // cũ là onPrimary

              side: const BorderSide(
                // viền button
                color: Colors.blue,
                width: 2.0,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20), // Bán kính cho góc trái
                  right: Radius.circular(30), // Bán kính cho góc phải),
                ),
              ),
            ),
            onHover: (value) {
              print('onHover: .......');
            },
            onLongPress: () {
              // ấn giữ button
              print('onLongPress:.........');
            },
            onPressed: () {
              print('onPressed - ElevatedButton');
              // Lấy chủ đề hiện tại
            },

            label: const Text('Elevated Button Icon'),
            icon: const Icon(
              Icons.abc,
              size: 30,
              color: Colors.redAccent,
            ),
            // child: Text('Elevated Button'), // khi dùng button.icon thì thuộc tính child: sẽ bị thay thế bằng 2 thuộc tính icon: và label:
          ),
        ));
  }
}

// 3 class kết hợp
class MyButtonAppAll extends StatelessWidget {
  const MyButtonAppAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
// ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GeeksForGeeks"),
        backgroundColor: Colors.green,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Center(
          child: IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Alert Dialog Box"),
                  content: const Text("You have raised a Alert Dialog Box"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(14),
                        child: const Text("okay"),
                      ),
                    ),
                  ],
                ),
              );
            },
            //  child: const Text("Show alert Dialog box"),
          ),
        ),
      ),
    );
  }
}
