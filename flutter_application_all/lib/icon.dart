import 'package:flutter/material.dart';

class MyIconWidget extends StatelessWidget {
  const MyIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Icon Widget'),
        ),
        body: const IconDemo(),
      ),
    );
  }
}

//
// Tra cứu thư viện icons tại: https://fonts.google.com/icons
class IconDemo extends StatelessWidget {
  const IconDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Text('Icon 01: '),
            Icon(
              Icons.star,
              // color: Colors.yellow,
              size: 40.0,
            ),
          ],
        ),
        Row(
          children: [
            Text('Icon 02: '),
            Icon(
              Icons.event,
              // color: Colors.yellow,
              size: 40.0,
            ),
          ],
        ),
        Row(
          children: [
            Text('Icon 03: '),
            Icon(
              Icons.favorite,
              color: Colors.yellow,
              size: 40.0,
            ),
          ],
        ),
        Row(
          children: [
            Text('Icon 04: '),
            Icon(
              Icons.favorite_border,
              color: Colors.yellow,
              size: 40.0,
            ),
          ],
        ),
      ],
    );
  }
}

//
class MyIconWidget2 extends StatelessWidget {
  const MyIconWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(children: [
          //Hiển thị Icon đơn giản
          SizedBox(
            height: 50,
            child: Text('Icon đơn giản'),
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 60.0,
          ),
        ]),
        //Icon trong Button
        Row(children: [
          const SizedBox(
            height: 20,
            child: Text('Icon trong Button'),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text('Add'),
          ),
        ]),
        // Icon cùng dòng với text
        const Row(children: [
          SizedBox(
            height: 20,
            child: Text(
              'Icon cùng dòng với text',
            ),
          ),
          Row(
            children: [
              Icon(Icons.email, color: Colors.blue),
              SizedBox(width: 5),
              Text('nmson2504@gmail.com'),
            ],
          ),
        ]),
        //
        /*  
            Đặt ListTile trực tiếp vào Row sẽ gây lỗi:
            Exception caught by scheduler library ═════════════════════════════════
Updated layout information required for RenderParagraph#b0f3f NEEDS-LAYOUT NEEDS-PAINT to calculate semantics.
'package:flutter/src/rendering/object.dart':
object.dart:1
Failed assertion: line 3457 pos 12: '!_needsLayout'
           const Row(
              children: [
                Text('Icon trong ListTile'),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('John Doe'),
                  subtitle: Text('Software Engineer'),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ],
            ), */

        // Icon trong ListTitle
        const Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('Icon trong ListTile'),
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('John Doe'),
                    subtitle: Text('Software Engineer'),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          ],
        ),

        Row(children: [
          const Text('Icon trong nền 1 object'),
          // Icon trong nền 1 object
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.ac_unit,
              color: Colors.white,
              size: 20.0,
            ),
          ),
        ]),

        Row(children: [
          const Text('Icon cho 1 hành động'),
          // Icon cho 1 hành động
          GestureDetector(
            onTap: () {
              // Hành động khi người dùng chạm vào icon
            },
            child: const Icon(Icons.touch_app),
          )
        ])
      ],
    );
  }
}
