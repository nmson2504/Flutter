import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Example5(title: 'Home'),
    );
  }
}

// MyHomePage & MyHomePage2 -  MyHomePage chưa Refactor code, MyHomePage1 đã Refactor code
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Flutter Refactoring Tutorial',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 16),
            const Text('Press the below button to follow me on Twitter'),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Pressed Follow on Twitter button"),
                    duration: Duration(seconds: 1),
                  ),
                );
                // Open Twitter app
              },
              child: const Text("Follow on Twitter"),
            ),
            const SizedBox(height: 16),
            const Text('Press the below button to follow me on Instagram'),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Pressed Follow on Instagram button"),
                    duration: Duration(seconds: 1),
                  ),
                );
                // Open Instagram app
              },
              child: const Text("Follow on Instagram"),
            ),
          ],
        ),
      ),
    );
  }
}

// MyHomePage2 đã Refactor code - StatefulWidget
class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage2> createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Flutter Refactoring Tutorial',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 16),
            CustomButton(
              platform: 'Twitter',
              onPressed: () {
                // Open Twitter App
              },
            ),
            const SizedBox(height: 16),
            CustomButton(
              platform: 'Instagram',
              onPressed: () {
                // Open Instagram App
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Widget
class CustomButton extends StatelessWidget {
  final String platform;
  final VoidCallback onPressed;
  const CustomButton(
      {super.key, required this.platform, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Press the below button to follow me on $platform"),
      OutlinedButton(
        style: OutlinedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 7, 189, 13)),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Pressed Follow on $platform button"),
              duration: const Duration(seconds: 1),
            ),
          );
          onPressed();
        },
        child: Text("Follow on $platform"),
      )
    ]));
  }
}

//  Example 2
class Example2 extends StatelessWidget {
  const Example2({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title - Custom Widget Demo 2'),
      ),
      body: Center(
        child: CustomButton2(
          text: 'Press Me',
          onPressed: () {
            print('Button pressed!');
          },
          backgroundColor: Colors.green,
          textColor: Colors.white,
        ),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const CustomButton2({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Example 3
class Example3 extends StatelessWidget {
  const Example3({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title Custom Button 3'),
      ),
      body: Center(
        child: CustomButton3(
          text: 'Click me',
          onPressed: () {
            // Thực hiện hành động khi button được nhấn
            print('Button clicked!');
          },
        ),
      ),
    );
  }
}

class CustomButton3 extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  final Color color;

  const CustomButton3({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton3> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onPressed();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isPressed ? widget.color.withOpacity(0.8) : widget.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// Example 4
class Example4 extends StatelessWidget {
  const Example4({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('$title Custom Widget Demo 4'),
        ),
        body: const Center(
          child: ColoredBoxWidget(
            backgroundColor: Colors.blue,
            text: 'Hello, Flutter!',
          ),
        ),
      ),
    );
  }
}

class ColoredBoxWidget extends StatelessWidget {
  final Color backgroundColor;
  final String text;

  const ColoredBoxWidget(
      {super.key, required this.backgroundColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

// Example 5 - StatefulWidget
class Example5 extends StatelessWidget {
  const Example5({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('$title Widget Demo 5'),
        ),
        body: const Center(
          child: CounterWidget(),
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Button tapped $_counter times',
          style: const TextStyle(fontSize: 20.0),
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: const Text('Tap me'),
        ),
      ],
    );
  }
}
