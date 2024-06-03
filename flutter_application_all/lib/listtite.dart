import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('ListTile Sample')),
        body: const MyListTile3(),
      ),
    );
  }
}

class MyListTile1 extends StatelessWidget {
  const MyListTile1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://icon-library.com/images/avatar-icon-images/avatar-icon-images-4.jpg')),
        const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 131, 230, 243),
          child: Text('AH'),
        ),
        const ListTile(
          leading: Icon(Icons.star),
          title: Text('ListTile Example'),
          subtitle: Text('This is a ListTile in a Flutter app.'),
          trailing: Icon(Icons.arrow_forward),
        ),

        const ListTile(
          leading: Icon(Icons.album),
          title: Text('The Enchanted Nightingale'),
          subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          trailing: Icon(Icons.arrow_back_ios),
          //
          // tileColor: Color.fromARGB(255, 248, 173, 167),
          iconColor: Color.fromARGB(255, 90, 113, 239),

          focusColor: Colors.greenAccent,
          hoverColor: Colors.limeAccent,
          selectedColor: Colors.indigo,
          selectedTileColor: Colors.purple,
          //
          // minLeadingWidth:
          //     40, // Đặt giá trị tối thiểu cho chiều rộng của leading
        ),
        // dùng ListTileTheme - shape: để tạo border cho ListTile
        ListTileTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
                color: Color.fromARGB(255, 79, 22, 236), width: 1.0),
          ),
          child: const ListTile(
            leading: Icon(Icons.album, color: Colors.cyan, size: 45),
            title: Text(
              "Let's Talk About Love",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text('Modern Talking Album'),
            //
            horizontalTitleGap:
                40, // space giữa icon và title, subtitle (ko có leading ko tác dụng)
            minLeadingWidth: 50, // giá trị tối thiểu cho chiều rộng của leading
            minVerticalPadding:
                40, // The minimum padding on the top + bottom of the title and subtitle widgets.
          ),
        ),
        ListTileTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
                color: Color.fromARGB(255, 79, 22, 236), width: 2.0),
          ),
          child: const ListTile(
            tileColor: Color.fromARGB(255, 237, 203, 227),
            leading: Icon(Icons.album, color: Colors.cyan, size: 45),
            title: Text(
              "Let's Talk About Love",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text('Modern Talking Album'),
          ),
        ),
        ListTile(
          leading: Checkbox(
            value: false, // Đặt giá trị ban đầu của Checkbox
            onChanged: (bool? value) {
              // Xử lý sự kiện thay đổi giá trị của Checkbox
              print("Checkbox value changed: $value");
            },
          ),
          title: const Text('Checkbox ListTile Example'),
          subtitle: const Text('This ListTile has a Checkbox.'),
          trailing: const Icon(Icons.arrow_forward_sharp),
          //
          focusColor: Colors.purpleAccent,
          hoverColor: Colors.yellowAccent,
        ),
        ListTile(
          leading: Checkbox(
            value: false,
            onChanged: (bool? value) {
              print("Checkbox value changed: $value");
            },
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Complex ListTile Example'),
              Text('This ListTile has multiple components.'),
              Text('This ListTile has multiple components.'),
            ],
          ),
          subtitle: const Row(
            children: [
              Icon(Icons.star),
              SizedBox(width: 4.0),
              Text('Subheading'),
            ],
          ),
          trailing: Image.asset(
              'assets/lion.jpg'), // Thay thế 'assets/image.png' bằng đường dẫn thật
        ),
      ],
    );
  }
}

class MyListTile2 extends StatelessWidget {
  const MyListTile2({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        Card(child: ListTile(title: Text('One-line ListTile'))),
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('One-line with leading widget'),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('One-line with trailing widget'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('One-line with both widgets'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('One-line dense ListTile'),
            dense: true,
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 56.0),
            title: Text('Two-line ListTile'),
            subtitle: Text('Here is a second line'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text('Three-line ListTile'),
            subtitle:
                Text('A sufficiently long subtitle warrants three lines.'),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          ),
        ),
      ],
    );
  }
}

class MyListTile3 extends StatelessWidget {
  const MyListTile3({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTileExample();
  }
}

class ListTileExample extends StatefulWidget {
  const ListTileExample({super.key});

  @override
  State<ListTileExample> createState() => _ListTileExampleState();
}

class _ListTileExampleState extends State<ListTileExample> {
  bool _selected = false;
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        enabled:
            _enabled, // true/false - xác định trạng thái có thể tương tác được như có thể selected được
        selected:
            _selected, // true/false - chỉ thay đổi được khi thuộc tịnh enabled = true
        onTap: () {
          // khi click trên ListTile (ko tính Switch)
          setState(() {
            // This is called when the user toggles the switch.
            _selected = !_selected;
          });
        },
        // This sets text color and icon color to red when list tile is disabled and
        // green when list tile is selected, otherwise sets it to black.
        iconColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.red;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.green;
          }
          return Colors.black;
        }),
        // This sets text color and icon color to red when list tile is disabled and
        // green when list tile is selected, otherwise sets it to black.
        textColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.red;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.green;
          }
          return Colors.black;
        }),
        leading: const Icon(Icons.person),
        title: const Text('Headline'),
        subtitle: Text('Enabled: $_enabled, Selected: $_selected'),
        trailing: Switch(
          onChanged: (bool? value) {
            // khi click trên Switch
            // This is called when the user toggles the switch.
            setState(() {
              _enabled = value!; // update thuộc tính enabled: của ListTile
            });
          },
          value: _enabled,
        ),
      ),
    );
  }
}
