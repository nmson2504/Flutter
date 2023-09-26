import 'package:flutter/material.dart';

class MyStack extends StatelessWidget {
  const MyStack({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Stack')),
        body: const MyStack3(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

class MyStack0 extends StatelessWidget {
  const MyStack0({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft, // align các object trên so container cha
      // alignment: AlignmentDirectional.bottomCenter, // or AlignmentDirectional.bottomEnd
      // textDirection: TextDirection.rtl, // chiều đổ stack
      children: <Widget>[
        Container(
          width: 290,
          height: 190,
          color: Colors.green,
        ),
        Container(
          width: 300,
          height: 170,
          color: Colors.red,
        ),
        Container(
          width: 220,
          height: 400,
          color: Colors.yellow,
        ),
      ],
    );
  }
}

class MyStack1 extends StatelessWidget {
  const MyStack1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        // height: 400,
        width: 500,
        child: Stack(
          // alignment:Alignment.center, // align all object so container cha
          alignment: AlignmentDirectional
              .bottomEnd, // or AlignmentDirectional.bottomEnd
          // textDirection: TextDirection.rtl, // chiều đổ stack
          // fit: StackFit.passthrough,
          // Default is StackFit.loose - ko thay đổi kích thước;
          //StackFit.expand - bung full 2 chiều container cha;
          // StackFit.passthrough - nếu container cha có set height thì bung full width của container cha, nếu container cha có set width thì bung full height của container cha, nếu set cả height & width thì như expand;
          // clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              width: 300,
              height: 190,
              color: Colors.green,
            ),
            Container(
              width: 280,
              height: 170,
              color: Colors.red,
            ),
            Container(
              width: 220,
              height: 520,
              color: Colors.yellow,
            ),
          ],
        ));
  }
}

class MyStack2 extends StatelessWidget {
  const MyStack2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        height: 400,
        width: 500,
        child: Stack(
          // alignment:Alignment.center, // align các object trên so với object dưới cùng
          alignment: AlignmentDirectional
              .bottomEnd, // or AlignmentDirectional.bottomEnd
          clipBehavior: Clip
              .none, // xử lý khi object tràn khỏi container (set Positioned(top, left...)). Clip.none - show full object, các value khác - cắt phần tràn ngoài container
          children: <Widget>[
            Container(
              width: 300,
              height: 190,
              color: Colors.green,
            ),
            Container(
              width: 280,
              height: 170,
              color: Colors.red,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 200,
                height: 550,
                color: Colors.yellow,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 300,
              child: Container(
                width: 220,
                height: 520,
                color: const Color.fromARGB(255, 255, 59, 232),
              ),
            ),
          ],
        ));
  }
}

class MyStack3 extends StatelessWidget {
  const MyStack3({super.key});
// canh object A theo object B
  @override
  Widget build(BuildContext context) {
    double parentWidth = 400;
    double parentHeight = 380;
    double childWidth = 200;
    double childHeight = 120;

    double topCenter = (parentHeight - childHeight) / 2;
    double rightCenter = (parentWidth - childWidth) / 2;

    double heightOffset = parentHeight - childHeight;
    double widthOffset = parentWidth - childWidth;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: parentWidth,
          height: parentHeight,
          color: Colors.green,
        ),
        // align center
        Positioned(
          top: topCenter,
          right: rightCenter,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: Colors.red,
          ),
        ),
        // align bottom - left
        Positioned(
          top: heightOffset,
          right: widthOffset,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: const Color.fromARGB(255, 124, 54, 244),
          ),
        ),
        // align bottom - right
        Positioned(
          top: heightOffset,
          left: widthOffset,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: Color.fromARGB(255, 244, 238, 54),
          ),
        ),
        // align top - right
        Positioned(
          bottom: heightOffset,
          left: widthOffset,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: Color.fromARGB(255, 244, 54, 228),
          ),
        ),
        // align top - left
        Positioned(
          bottom: heightOffset,
          right: widthOffset,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: Color.fromARGB(255, 101, 219, 240),
          ),
        ),
        // align center - left
        Positioned(
          bottom: topCenter,
          right: widthOffset,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: Color.fromARGB(255, 101, 240, 191),
          ),
        ),
        // align center - right
        Positioned(
          bottom: topCenter,
          left: widthOffset,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: Color.fromARGB(255, 240, 177, 101),
          ),
        ),
        // align center - bottom
        Positioned(
          top: heightOffset,
          left: rightCenter,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: Color.fromARGB(255, 121, 174, 168),
          ),
        ),
        // align center - top
        Positioned(
          bottom: heightOffset,
          left: rightCenter,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: Color.fromARGB(255, 230, 175, 199),
          ),
        ),
      ],
    );
  }
}
