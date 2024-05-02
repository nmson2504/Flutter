import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class MyMapToList extends StatelessWidget {
  const MyMapToList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Home1(),
    );
  }
}

// Home
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> quotes = [
    'Be yourseft, Everyoine else is already taken',
    'I have nothing to declare except my genius',
    'The truth is rarely pure and never simple',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 227, 207),
      appBar: AppBar(
        title: const Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: quotes.map((quote) => Text(quote)).toList(),
      ),
    );
  }
}

// Home1 - Custom Classes
class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  List<Quote> quotes = [
    Quote('Class Quotes can be separated into another class', 'NMSon'),
    Quote('And import at the beginning of this file', 'NXTruong'),
    Quote('Custom classes can be', 'NTLuong'),
  ];

  List<Quote1> quotes1 = [
    Quote1(
      text: 'Class Quotes1 can be separated into another class',
      author: 'NMSon',
    ),
    Quote1(
      text: 'Quotes1: And import at the beginning of this file',
      author: 'NXTruong',
    ),
    Quote1(
      text: 'Quotes1: Custom classes can be',
      author: 'NTLuong',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 227, 207),
      appBar: AppBar(
        title: const Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: quotes1
            .map((quote) => Text('${quote.author} - ${quote.text}'))
            .toList(),
      ),
    );
  }
}

// class Quotes Can be separated into another class, and import it at the beginning of this file
class Quote {
  late String text;
  late String author;

  Quote(this.text, this.author);
}

//
class Quote1 {
  late String text;
  late String author;

  // Khai báo object with parameters named - phải gọi parameters named khi khai báo object
  Quote1({
    required this.text,
    required this.author,
  });
}
