import 'package:flutter/material.dart';

class MyDecoratedBox extends StatelessWidget {
  const MyDecoratedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter DecoratedBox')),
        body: const DecoratedBox4(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

class DecoratedBox1 extends StatelessWidget {
  const DecoratedBox1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Hello, world!',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// DecoratedBox with AssetImage
class DecoratedBox2 extends StatelessWidget {
  const DecoratedBox2({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image2.jpg'), // Đảm bảo rằng đường dẫn đúng
          fit: BoxFit.cover, // Hoặc BoxFit.fill, BoxFit.contain tùy thuộc vào nhu cầu
        ),
      ),
      child: Center(
        child: Text(
          'Hello, world 2!',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            backgroundColor: Colors.black45,
          ),
        ),
      ),
    );
  }
}

// DecoratedBox with AssetImage & child: FlutterLogo
class DecoratedBox3 extends StatelessWidget {
  const DecoratedBox3({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image2.jpg'), // Đảm bảo rằng đường dẫn đúng
          fit: BoxFit.cover, // Hoặc BoxFit.fill, BoxFit.contain tùy thuộc vào nhu cầu
        ),
      ),
      child: Center(
          // flutter logo that will shown
          // above the background image
          child: FlutterLogo(
        size: 200,
      )),
    );
  }
}

// DecoratedBox with NetworkImage

class DecoratedBox4 extends StatelessWidget {
  const DecoratedBox4({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          'Background Image from Network',
          style: TextStyle(
            color: Color.fromARGB(255, 79, 241, 241),
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
