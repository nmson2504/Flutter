import 'dart:ui';
import 'package:flutter/material.dart';

// Khai báo các loại button
class MyGridView extends StatelessWidget {
  const MyGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter GridView')),
        body: const GridView2(),
      ),
    );
  }
}

//----------------------------------
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
//----------------------------------

// GridView thường
class GridView01 extends StatelessWidget {
  const GridView01({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Required - Số cột trong grid
        crossAxisSpacing: 5.0, // Khoảng cách giữa các cột
        mainAxisSpacing: 5.0, // Khoảng cách giữa các dòng
        childAspectRatio:
            0.8, // Tỷ lệ khung hình của mỗi phần tử - tỉ lệ nghịch với kích thước item (theo crossAxis)
      ),
      children: <Widget>[
        // Các phần tử trong grid
        Container(
          color: Colors.red,
          child: const Center(
            child: Text('Item 1'),
          ),
        ),
        Container(
          color: Colors.blue,
          child: const Center(
            child: Text('Item 2'),
          ),
        ),
        Container(
          color: Colors.green,
          child: const Center(
            child: Text('Item 3'),
          ),
        ),
        Container(
          color: Colors.orange,
          child: const Center(
            child: Text('Item 4'),
          ),
        ),
      ],
    );
  }
}

class GridView02 extends StatelessWidget {
  const GridView02({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150.0, // required -  chiều rộng tối đa cho mỗi item
        mainAxisSpacing: 5.0, // Khoảng cách giữa các dòng
        crossAxisSpacing: 5.0, // khoảng cách giữa các column
        // childAspectRatio: 2.0, // Tỷ lệ khung hình của mỗi phần tử - tỉ lệ nghịch với kích thước item (theo crossAxis)
      ),
      children: <Widget>[
        // Các phần tử trong grid
        Container(
          color: Colors.red,
          child: const Center(
            child: Text('Item 1'),
          ),
        ),
        Container(
          color: Colors.blue,
          child: const Center(
            child: Text('Item 2'),
          ),
        ),
        Container(
          color: Colors.green,
          child: const Center(
            child: Text('Item 3'),
          ),
        ),
        Container(
          color: Colors.orange,
          child: const Center(
            child: Text('Item 4'),
          ),
        ),
      ],
    );
  }
}

class GridView03 extends StatelessWidget {
  GridView03({super.key});
  final List numbers = List.generate(30, (index) => 'Item $index');
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20),
      children: numbers
          .map((e) => Container(
              color: Colors.amber, alignment: Alignment.center, child: Text(e)))
          .toList(),
    );
  }
}

// GridView.builder
final List<String> items = List<String>.generate(50, (index) => 'Item $index');

class GridViewBuilder1 extends StatelessWidget {
  const GridViewBuilder1({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Số cột
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red, // Màu của viền
              width: 2.0, // Độ dày của viền
            ),
          ),
          child: ListTile(
            title: Text(items[index]),
          ),
        );
      },
      itemCount: items.length,
    );
  }
}

//
class ItemTile extends StatelessWidget {
  final int itemNo;

  const ItemTile(this.itemNo, {super.key});

  @override
  Widget build(BuildContext context) {
    // itemNo % Colors.primaries.length sẽ là một số nguyên trong khoảng từ 0 đến Colors.primaries.length - 1, và nó được sử dụng để chọn một màu cụ thể từ danh sách Colors.primaries.
    final Color color = Colors.primaries[itemNo % Colors.primaries.length];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: color.withOpacity(0.2),
        onTap: () {},
        leading: Container(
          width: 50,
          height: 30,
          color: color.withOpacity(0.5),
          child: Placeholder(
            color: color,
          ),
        ),
        title: Text(
          'Product $itemNo',
          key: Key('text_$itemNo'),
        ),
      ),
    );
  }
}

class GridViewBuilder2 extends StatelessWidget {
  const GridViewBuilder2({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 100,
      itemBuilder: (context, index) => ItemTile(index),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
      ),
    );
  }
}

// GridView.count
class GridViewCount1 extends StatelessWidget {
  const GridViewCount1({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // Requỉed - Số lượng cột
      children: const <Widget>[
        // Danh sách các phần tử
        Text('Item 1'),
        Text('Item 2'),
        Text('Item 3'),
        Text('Item 4'),
        Text('Item 5'),
        Text('Item 6'),
        // ...
      ],
    );
  }
}

//
class DialKey extends StatelessWidget {
  final String? number;
  final String? letters;

  const DialKey({super.key, this.number, this.letters});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.grey.withOpacity(0.7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$number',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '$letters',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GridViewCount2 extends StatelessWidget {
  const GridViewCount2({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 24, right: 24),
      children: const [
        DialKey(
          number: '1',
          letters: '',
        ),
        DialKey(
          number: '2',
          letters: 'ABC',
        ),
        DialKey(
          number: '3',
          letters: 'DEF',
        ),
        // DialKey(...)
      ],
    );
  }
}

//
class Choice {
  const Choice({this.title, this.icon});
  final String? title;
  final IconData? icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Home', icon: Icons.home),
  Choice(title: 'Contact', icon: Icons.contacts),
  Choice(title: 'Map', icon: Icons.map),
  Choice(title: 'Phone', icon: Icons.phone),
  Choice(title: 'Camera', icon: Icons.camera_alt),
  Choice(title: 'Setting', icon: Icons.settings),
  Choice(title: 'Album', icon: Icons.photo_album),
  Choice(title: 'WiFi', icon: Icons.wifi),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.headlineSmall;
    return Card(
        color: const Color.fromARGB(255, 252, 198, 117),
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child:
                        Icon(choice.icon, size: 50.0, color: textStyle?.color)),
                Text(choice.title!, style: textStyle),
              ]),
        ));
  }
}

class GridViewCount3 extends StatelessWidget {
  const GridViewCount3({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 4.0,
      mainAxisSpacing: 8.0,
      children: List.generate(choices.length, (index) {
        return Center(
          child: SelectCard(choice: choices[index]),
        );
      }),
    );
  }
}

// GridView.custom
class GridViewCustom1 extends StatelessWidget {
  const GridViewCustom1({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Required
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          // Xây dựng các phần tử dựa trên dữ liệu hoặc logic phức tạp
          return ListTile(title: Text('Item $index'));
        },
        childCount: 20, // Số lượng phần tử trong lưới, ko set sẽ scroll vô hạn
      ),
    );
  }
}

//
final List<String> items2 = List<String>.generate(30, (index) => 'Item $index');

class GridViewCustom2 extends StatelessWidget {
  const GridViewCustom2({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent:
              200.0, // Required - Chiều rộng tối đa của mỗi ô con
          mainAxisSpacing: 10.0, // Khoảng cách giữa các ô con theo chiều dọc
          crossAxisSpacing: 10.0, // Khoảng cách giữa các ô con theo chiều ngang
        ),
        childrenDelegate: SliverChildListDelegate(
          items2.map((String item) {
            return Card(
                elevation: 2.0, // Độ nổi của thẻ
                child: Center(child: Text(item)));
          }).toList(),
        ));
  }
}

//
// GridView.extend
class GridViewExtend extends StatelessWidget {
  const GridViewExtend({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
        maxCrossAxisExtent: 150.0, // Required - Chiều rộng tối đa của mỗi ô con
        mainAxisSpacing: 10.0, // Khoảng cách giữa các ô con theo chiều dọc
        crossAxisSpacing: 10.0, // Khoảng cách giữa các ô con theo chiều ngang
        children: List.generate(30, (index) {
          return Center(
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 246, 235, 201),
                      border: Border.all(
                        color: Colors.red, // Màu của viền
                        width: 1.5, // Độ dày của viền
                      )),
                  // color: const Color.fromRGBO(239, 184, 184, 1),
                  child: Text('Item $index')));
        }));
  }
}

// Demo scroll
/* 
Default: chỉ có thanh cuộn dọc, chỉ vuốt-chạm bằng cảm ứng.
 */
class GridView1 extends StatelessWidget {
  const GridView1({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis
          .vertical, // Axis.horizontal -> crossAxisCount là số row;  Axis.vertical -> crossAxisCount là số column
      crossAxisCount: 2, // Số cột trong grid
      children: List.generate(20, (index) {
        return Center(
          child: Container(
            width: 150,
            height: 150,
            color: Colors.blue, // Màu nền cho mỗi ô trong grid
            child: Text(
              'Item $index',
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        );
      }),
    );
  }
}

class GridView1b extends StatelessWidget {
  const GridView1b({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridView.builder(
        physics:
            NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn của GridView
        shrinkWrap:
            true, // Đảm bảo rằng GridView sẽ co lại kích thước của nội dung
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Số cột trong grid
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(8.0),
            color: Colors.blue,
            height: 100.0,
            child: Center(
              child: Text(
                'Item $index',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          );
        },
        itemCount: 20, // Số lượng phần tử trong grid
      ),
    );
  }
}

//---------

class GridView2 extends StatelessWidget {
  const GridView2({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
      child: GridView.count(
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis
            .vertical, // Axis.horizontal -> crossAxisCount là số row;  Axis.vertical -> crossAxisCount là số column
        crossAxisCount: 2, // Số cột trong grid
        children: List.generate(20, (index) {
          return Center(
            child: Container(
              width: 150,
              height: 150,
              color: Colors.blue, // Màu nền cho mỗi ô trong grid
              child: Text(
                'Item $index',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          );
        }),
      ),
    );
  }
}
//
