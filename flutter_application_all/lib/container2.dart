import 'package:flutter/material.dart';

class Container2 extends StatelessWidget {
  const Container2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Container 2')),
        body: const ContainerText6(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

class ContainerText1 extends StatelessWidget {
  const ContainerText1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 100,
        color: Colors.blue,
        child: const Center(
          child: Text(
            'Text được canh giữa',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ContainerText2 extends StatelessWidget {
  const ContainerText2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 100,
        color: Colors.blue,
        child: const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Text được canh trái và trên',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// Container set width - height
class ContainerText3 extends StatelessWidget {
  const ContainerText3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Column with Containers Demo'),
        ),
        body: Column(
          children: [
            // Container 1: Text aligned to the start (left)
            Container(
              color: Colors.blue,
              // width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Left aligned text',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.start,
              ),
            ),
            // Container 2: Text aligned to the center
            Container(
              color: Colors.green,
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Center aligned text',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
            // Container 3: Text aligned to the end (right)
            Container(
              color: Colors.red,
              width: 400,
              height: 100,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Right aligned text',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Column set mainAxisAlignment and Container set width - height
class ContainerText4 extends StatelessWidget {
  const ContainerText4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alignment Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 300,
            height: 100,
            color: Colors.red,
            alignment: Alignment.centerLeft,
            child: const Text(
              'Left Aligned',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Container(
            width: 300,
            height: 100,
            color: Colors.green,
            alignment: Alignment.center,
            child: const Text(
              'Center Aligned',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Container(
            width: 300,
            height: 100,
            color: Colors.blue,
            alignment: Alignment.centerRight,
            child: const Text(
              'Right Aligned',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

// Container set width - height, lồng Align, Padding
class ContainerText5 extends StatelessWidget {
  const ContainerText5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alignment Demo'),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Canh giữa',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Colors.green,
            child: const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Canh phải',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Colors.purple,
            child: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Canh trái với padding',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Container set width - height, lồng Align, Padding
class ContainerText6 extends StatelessWidget {
  const ContainerText6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alignment Demo 6'),
      ),
      body: Column(
        children: [
          Container(
            // height: 50,
            color: Colors.blue,
            child: const Text(
              'Không set hight/width, canh chỉnh gì hết',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            height: 50,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Canh giữa với Center',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            // height: 50,
            width: 200,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Canh giữa với Center',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Colors.green,
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                'Canh center với Align',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 300,
            color: Colors.green,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Canh centerLeft với Align',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 300,
            color: Colors.green,
            child: const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Canh topCenter với Align',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 300,
            color: Colors.green,
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Canh bottomCenter với Align',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 400,
            color: Colors.purple,
            child: const Padding(
              padding: EdgeInsets.only(left: 0),
              child: Text(
                'Canh trái với padding EdgeInsets.only(left: 0)',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          // Lưu ý: khi container set height thì padding mặc dịnh set top=0 và set padding bottom ko tác dụng
          Container(
            height: 100,
            color: Colors.purple,
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              // padding: EdgeInsets.symmetric(vertical: 60.0),
              child: Text(
                'Canh  EdgeInsets.only(right: 20) với padding',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            // height: 100,
            color: Colors.purple,
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              // padding: EdgeInsets.symmetric(vertical: 60.0),
              child: Text(
                'Canh  EdgeInsets.only(right: 20) với padding',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
