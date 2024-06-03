import 'dart:ui';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

// Class cấu hình scroll bằng mouse
// Bước 1: Định nghĩa class cấu hình
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch, // cảm ứng
        PointerDeviceKind.mouse, // vuốt màn hình bằng chuột. default ko có
        // etc.
      };
}

/* 
Bước 2: Áp dụng cấu hình
Tại Widget build thêm như dưới đây
Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
child: GridView.count(……..

 */
//
class MyListView extends StatelessWidget {
  const MyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter ListView')),
        body: const MyEnglishWords3(),
      ),
    );
  }
}

// demo package:english_words/english_words.dart - 2
class MyEnglishWords extends StatelessWidget {
  const MyEnglishWords({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items =
        List.generate(50, (index) => WordPair.random().asPascalCase);
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${index + 1} - ${items[index]}'),
          );
        });
  }
}

// demo package:english_words/english_words.dart
class MyEnglishWords3 extends StatefulWidget {
  const MyEnglishWords3({super.key});

  @override
  State<MyEnglishWords3> createState() => _MyEnglishWords3State();
}

class _MyEnglishWords3State extends State<MyEnglishWords3> {
  final _listWords = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
      child: ListView.builder(
          itemCount: 50,
          // itemCount: _listWords.length,
          itemBuilder: (context, index) {
            _listWords.addAll(generateWordPairs().take(1));
            // if (index == _listWords.length) {
            // _listWords.addAll(generateWordPairs().take(5));
            // }
            return ListTile(
              title: Text('$index - ${_listWords[index].asPascalCase}'),
            );
          }),
    );
  }
}

// ListView() default
class ListView1 extends StatelessWidget {
  const ListView1({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          height: 50,
          color: Colors.amber[600],
          child: const Center(child: Text('Entry A')),
        ),
        Container(
          height: 50,
          color: Colors.amber[500],
          child: const Center(child: Text('Entry B')),
        ),
        Container(
          height: 50,
          color: Colors.amber[100],
          child: const Center(child: Text('Entry C')),
        ),
      ],
    );
  }
}

class ListView2 extends StatelessWidget {
  ListView2({super.key});

  final List<int> items = List.generate(50, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 240, 234, 215),
      child: ListView(
        // itemExtent: set fix height cho items
        itemExtent: 50,
        // Thuộc tính padding để thêm khoảng cách xung quanh danh sách
        padding: const EdgeInsets.all(15.0),
        // Đảo list
        reverse: true,
        // Thuộc tính scrollDirection để thiết lập hướng cuộn (mặc định là vertical)
        scrollDirection: Axis.vertical,
        // Thuộc tính shrinkWrap để đóng gói danh sách theo chiều dọc
        shrinkWrap: true,
        // Thuộc tính physics để điều khiển cách cuộn
        physics: const BouncingScrollPhysics(),
        // lưu giữ trạng thái các item khi cuộn qua và quay về lại
        addAutomaticKeepAlives: true,
        children: items.map((item) {
          return Container(
            color: const Color.fromARGB(255, 184, 192, 240),
            child: Column(
              children: [
                ListTile(
                  title: Text('Item $item'),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ListView3 extends StatelessWidget {
  const ListView3({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Chỉ có thể set 1 trong 2 thuộc tính itemExtent: or prototypeItem:
      // itemExtent: 200.0, // Đặt chiều cao cho tất cả các mục
      prototypeItem: Container(
        // Mục mẫu là một Container
        color: Colors.grey[300],
        child: Center(
          child: Image.asset(
            'assets/bear.jpg', // Đường dẫn tới hình ảnh mẫu
            height: 120.0, // Chiều cao của hình ảnh
            width: 120.0, // Chiều rộng của hình ảnh
          ),
        ),
      ),
      children: [
        // Các mục thực tế trong danh sách
        Container(
          color: const Color.fromARGB(255, 243, 28, 28),
          child: Center(
            child: Image.asset(
              'assets/bear.jpg', // Đường dẫn tới hình ảnh thứ nhất
              height: 120.0,
              width: 120.0,
            ),
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: Center(
            child: Image.asset(
              'assets/lion.jpg', // Đường dẫn tới hình ảnh thứ hai
              height: 140.0,
              width: 120.0,
            ),
          ),
        ),
        // Thêm các mục hình ảnh khác tại đây
      ],
    );
  }
}
//
// ListView.builder

class ListViewBuider1 extends StatelessWidget {
  ListViewBuider1({super.key});
  final List<String> entries =
      List.generate(50, (index) => 'Item ${index + 1}');
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemExtent: 50,
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 50,
            child: Center(child: Text('Entry ${entries[index]}')),
          );
        });
  }
}

class ListViewBuilder2 extends StatelessWidget {
  // Tạo danh sách 30 mã màu
  final List<String> colorCodes = List.generate(30, (index) {
    // Tạo mã màu ngẫu nhiên (ví dụ: "#RRGGBB")
    final r = (index * 10 % 256).toRadixString(16).padLeft(2, '0');
    final g = (index * 5 % 256).toRadixString(16).padLeft(2, '0');
    final b = (index * 20 % 256).toRadixString(16).padLeft(2, '0');
    return "0xFF$r$g$b";
  });

  ListViewBuilder2({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // prototypeItem: ,
      itemCount: colorCodes.length,
      itemBuilder: (context, index) {
        final colorCode = colorCodes[index];
        return Container(
          color: Color(int.parse(colorCode.replaceAll("#", "0xFF"))),
          height: 100, // Đặt chiều cao cho từng mục
          child: Center(
            child: Text(
              colorCode,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}

// ListView.separated
class ListViewSeparated extends StatelessWidget {
  // Tạo danh sách 30 mã màu
  final List<String> colorCodes = List.generate(30, (index) {
    // Tạo mã màu ngẫu nhiên (ví dụ: "#RRGGBB")
    final r = (index * 5 % 256).toRadixString(16).padLeft(2, '0');
    final g = (index * 20 % 256).toRadixString(16).padLeft(2, '0');
    final b = (index * 30 % 256).toRadixString(16).padLeft(2, '0');
    return "#$r$g$b";
  });

  ListViewSeparated({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: colorCodes.length,
      // separatorBuilder: list xen kẻ list itemBuilder:
      separatorBuilder: (BuildContext context, index) => const Divider(),
      itemBuilder: (context, index) {
        final colorCode = colorCodes[index];
        return Container(
          color: Color(int.parse(colorCode.replaceAll("#", "0xFF"))),
          height: 100, // Đặt chiều cao cho từng mục
          child: Center(
            child: Text(
              colorCode,
              style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        );
      },
    );
  }
}

// ListView.custom
//  childrenDelegate: SliverChildBuilderDelegate
class ListViewCustom2 extends StatelessWidget {
  final List<String> items =
      List<String>.generate(50, (index) => 'Item $index');

  ListViewCustom2({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.custom(
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ListTile(
            title: Text(items[index]),
          );
        },
        childCount: items.length,
      ),
    );
  }
}

class ListViewCustom3 extends StatelessWidget {
  const ListViewCustom3({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.custom(
      // physics: const AlwaysScrollableScrollPhysics(),
      childrenDelegate: SliverChildBuilderDelegate(
        // index auto increment từ 0 đến childCount - 1. Nếu ko set childCount thì load vô hạn
        (BuildContext context, int index) {
          return ListTile(
            title: Text('Item: $index'),
          );
        },
        childCount: 20,
      ),
    );
  }
}

// childrenDelegate: SliverChildListDelegate
class ListViewCustom1 extends StatelessWidget {
  const ListViewCustom1({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.custom(
      childrenDelegate: SliverChildListDelegate(
        [
          const Text('Item 1'),
          const Text('Item 2'),
          const Text('Item 3'),
        ],
      ),
    );
  }
}

// Vidu n: đã gồm MaterialApp()
class ListViewCustom extends StatefulWidget {
  const ListViewCustom({super.key});

  @override
  State<ListViewCustom> createState() => _ListViewCustomState();
}

class _ListViewCustomState extends State<ListViewCustom> {
  List<String> items = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '11',
    '21',
    '31',
    '41',
    '51'
  ];

  void _reverse() {
    setState(() {
      items = items.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: ListView.custom(
            childrenDelegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return KeepAlive(
                    data: items[index],
                    key: ValueKey<String>(items[index]),
                  );
                },
                childCount: items.length,
                findChildIndexCallback: (Key key) {
                  final ValueKey<String> valueKey = key as ValueKey<String>;
                  final String data = valueKey.value;
                  return items.indexOf(data);
                }),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () => _reverse(),
                child: const Text('Reverse items'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KeepAlive extends StatefulWidget {
  const KeepAlive({
    required Key key,
    required this.data,
  }) : super(key: key);

  final String data;

  @override
  State<KeepAlive> createState() => _KeepAliveState();
}

class _KeepAliveState extends State<KeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Text(widget.data);
  }
}
