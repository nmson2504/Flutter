import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class MyMapToList extends StatelessWidget {
  const MyMapToList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Home3(),
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

// Home2 - using  Widget quote1Template return Card
class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
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

  Widget quote1Template(quote) {
    return Card(
      borderOnForeground: true,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              quote.text,
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              quote.author,
              style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }

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
        children: quotes1.map((quote) => quote1Template(quote)).toList(),
      ),
    );
  }
}

// Home3 - using class QuoteCard return Card
class Home3 extends StatefulWidget {
  const Home3({super.key});

  @override
  State<Home3> createState() => _Home3State();
}

class _Home3State extends State<Home3> {
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
            .map((quote) => QuoteCard(
                  quote: quote,
                ))
            .toList(),
      ),
    );
  }
}

// class QuoteCard return Card
class QuoteCard extends StatelessWidget {
  final Quote1 quote;
  const QuoteCard({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              quote.text,
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              quote.author,
              style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
          ],
        ),
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
