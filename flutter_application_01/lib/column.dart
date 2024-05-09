import 'package:flutter/material.dart';

class MyColumn extends StatelessWidget {
  const MyColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Columns')),
        body: Column2(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

//---------------------------
// Column1 - alignments hàng loạt
class Column1 extends StatelessWidget {
  Column1({super.key});

  final List<Quote> quotes = [
    Quote(
      text: 'Class Quotes1 can be separated into another class',
      author: 'NMSon',
    ),
    Quote(
      text: 'Quotes1: And import at the beginning of this file',
      author: 'NXTruong',
    ),
    Quote(
      text: 'Quotes1: Custom classes can be - ',
      author: 'NTLuong',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.amber,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // Khi crossAxisAlignment: CrossAxisAlignment.stretch, để alignment crossAxisAlignment vô center thì phải dùng Container với alignment: Alignment.center.
        children: quotes
            .map((quote) => Container(
                  alignment:
                      Alignment.center, // Align text within the container
                  child: Text(
                    quote.text,
                    style: const TextStyle(
                        fontSize: 16), // Adjust the text size as needed
                  ),
                ))
            .toList(),
      ),
    );
  }
}

// Column2 - alignment từng element theo conditions of each element
class Column2 extends StatelessWidget {
  Column2({super.key});
  final List<Quote> quotes = [
    Quote(
      text: 'Class Quotes1 can be separated into another class',
      author: 'NMSon',
    ),
    Quote(
      text: 'Quotes1: And import at the beginning of this file',
      author: 'NXTruong',
      alignment: 'left',
    ),
    Quote(
      text: 'Quotes1: Custom classes can be - ',
      author: 'NTLuong',
      alignment: 'right',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.amber,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // Khi crossAxisAlignment: CrossAxisAlignment.stretch, để alignment crossAxisAlignment vô center thì phải dùng Container với alignment: Alignment.center.
        // Using crossAxisAlignment: CrossAxisAlignment.stretch combined textAlign of Text widget with conditions to align each line
        children: quotes
            .map((quote) => Text(
                  textAlign: quote.alignment == 'right'
                      ? TextAlign.right
                      : quote.alignment == 'left'
                          ? TextAlign.left
                          : TextAlign.center,
                  quote.text,
                  style: const TextStyle(
                      fontSize: 14), // Adjust the text size as needed
                ))
            .toList(),
      ),
    );
  }
}

//
class Quote {
  late String text;
  late String author;
  late String? alignment;

  // Khai báo object with parameters named - phải gọi parameters named khi khai báo object
  Quote({
    required this.text,
    required this.author,
    this.alignment,
  });
}
