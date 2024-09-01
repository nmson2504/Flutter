import 'dart:ui';

import 'package:flutter/material.dart';
/* 
scrollDirection = Axis.vertical, (default) - cuộn bằng con lăn chuột 
scrollDirection = Axis.horizontal, - cuộn bằng Shift + con lăn chuột 

thanh trượt dọc - auto show
thanh trượt ngang - phải bao SingleChildScrollView bằng Scrollbar và set thuộc tính   interactive: true, // Cho phép người dùng tương tác với thanh cuộn

 */

class MySingleChildScrollView extends StatelessWidget {
  const MySingleChildScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior()
          .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('SingleChildScrollView  Sample')),
        body: const SingleChildScrollView4(),
      ),
    );
  }
}

//
class SingleChildScrollView0 extends StatelessWidget {
  const SingleChildScrollView0({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Phần đầu trang',
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 600.0,
            color: Colors.green,
            child: const Center(
              child: Text(
                'Nội dung dài ở đây...',
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 400.0,
            color: Colors.orange,
            child: const Center(
              child: Text(
                'Phần cuối trang',
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//
class SingleChildScrollView1 extends StatelessWidget {
  const SingleChildScrollView1({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Container(
            width: 200.0,
            height: 200.0,
            color: Colors.red,
          ),
          Container(
            width: 200.0,
            height: 200.0,
            color: Colors.blue,
          ),
          Container(
            width: 200.0,
            height: 200.0,
            color: Colors.green,
          ),
          Container(
            width: 200.0,
            height: 200.0,
            color: Colors.yellow,
          ),
          Container(
            width: 200.0,
            height: 200.0,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}

//
class SingleChildScrollView2 extends StatelessWidget {
  const SingleChildScrollView2({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          ListTile(
            title: Text('Item 1'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 2'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 3'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 4'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 5'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 6'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 7'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 8'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 9'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 10'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
        ],
      ),
    );
  }
}

// lồng SingleChildScrollView trong SingleChildScrollView
class SingleChildScrollView3 extends StatelessWidget {
  const SingleChildScrollView3({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    color: Colors.red,
                    height: 150,
                    width: 250,
                  ),
                  Container(
                    color: const Color.fromARGB(255, 211, 239, 116),
                    height: 150,
                    width: 250,
                  ),
                  Container(
                    color: Colors.green,
                    height: 150,
                    width: 250,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            color: const Color.fromARGB(255, 254, 83, 217),
          ),
          Container(
            height: 200,
            color: Colors.blueAccent,
          ),
          Container(
            height: 200,
            color: const Color.fromARGB(255, 63, 247, 216),
          ),
          Container(
            height: 200,
            color: const Color.fromARGB(255, 243, 245, 150),
          ),
        ],
      ),
    );
  }
}

//
class SingleChildScrollView4 extends StatefulWidget {
  const SingleChildScrollView4({Key? key}) : super(key: key);

  @override
  _SingleChildScrollView4State createState() => _SingleChildScrollView4State();
}

class _SingleChildScrollView4State extends State<SingleChildScrollView4> {
  /* ScrollController là một đối tượng dùng để điều khiển và theo dõi vị trí cuộn của các widget cuộn như SingleChildScrollView. Nó giúp bạn quản lý vị trí cuộn và lắng nghe các sự kiện cuộn.
  Nếu bạn không sử dụng ScrollController trong Scrollbar và SingleChildScrollView, bạn vẫn có thể sử dụng Scrollbar và SingleChildScrollView, nhưng bạn sẽ không thể điều khiển hoặc theo dõi vị trí cuộn một cách linh hoạt 
  Thực tế khi triển khai Scrollbar lồng SingleChildScrollView mà ko gán ScrollController thì run app sẽ báo lỗi
   */
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller:
          _scrollController, // Attach the ScrollController to the Scrollbar - controller: Gán ScrollController cho Scrollbar để liên kết với SingleChildScrollView.
      scrollbarOrientation: ScrollbarOrientation
          .bottom, // Use bottom orientation for horizontal scrolling
      thickness: 12, // Thickness of the scrollbar
      radius: const Radius.circular(4), // Rounded corners for the scrollbar
      interactive: true, // Make the scrollbar interactive and more visible
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // Hiệu ứng bật lại ở các cạnh
        scrollDirection: Axis.horizontal, // Horizontal scrolling
        controller:
            _scrollController, // Attach the same ScrollController to the SingleChildScrollView - controller: Gán cùng một ScrollController để đồng bộ hóa với Scrollbar.
        child: Row(
          children: List.generate(
            20,
            (index) => Container(
              width: 200.0,
              height: 200.0,
              color: Colors.primaries[index % Colors.primaries.length],
              child: Center(
                child: Text(
                  'Item $index',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//
