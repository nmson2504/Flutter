import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class NetNinja21 extends StatelessWidget {
  const NetNinja21({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Home(),
    );
  }
}

// Home3 - using class QuoteCard return Card
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  delete: () {
                    setState(() {
                      quotes1.remove(quote);
                    });
                  }))
              .toList()),
    );
  }
}

// class QuoteCard return Card
class QuoteCard extends StatelessWidget {
  final Quote1 quote;
  final Function delete;
  const QuoteCard({super.key, required this.quote, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 150,
              child: TextButton(
                // if using: onPresed: delete(); an error will occur "FlutterError (setState() or markNeedsBuild() called during build...."
                onPressed: () {
                  delete();
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 239, 150, 189), // Set the button's background color
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize
                      .min, // Make the row only as big as its content
                  children: [
                    Icon(Icons.delete), // Your icon here

                    Text(
                      'Delete', // Your text here
                      style: TextStyle(
                        fontSize: 16.0, // Adjust the text size as needed
                      ),
                    ),
                  ],
                ),
              ),
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
