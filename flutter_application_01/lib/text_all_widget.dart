import 'package:flutter/material.dart';

class MyWidgetTextAll extends StatelessWidget {
  const MyWidgetTextAll({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Image Row Example'),
        ),
        body: const TextWidgetRichText(),
      ),
    );
    initialSize:
    const Size(400, 400);
  }
}

// Text widget
class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Tiện ích Văn bản hiển thị một chuỗi văn bản với một kiểu duy nhất. Chuỗi có thể ngắt trên nhiều dòng hoặc tất cả có thể được hiển thị trên cùng một dòng tùy thuộc vào các ràng buộc về bố cục.',
      textAlign: TextAlign.left,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: 1.8,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          wordSpacing: 0.5,
          letterSpacing: 1,
          //decoration: TextDecoration.lineThrough,
          decorationColor: Color.fromARGB(255, 200, 59, 49),
          //  color: Colors.greenAccent,
          backgroundColor: Color.fromARGB(255, 248, 169, 193),
          color: Color(0xFF3366FF)),
    );
  }
}

// TextSpan widget
class TextSpanWidget extends StatelessWidget {
  const TextSpanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      style: TextStyle(fontSize: 20 * 1.5, fontFamily: 'Roboto'),
      TextSpan(
        text: 'Hello', // default text style

        children: <TextSpan>[
          TextSpan(
              text: ' beautiful ',
              style: TextStyle(fontStyle: FontStyle.italic)),
          TextSpan(
              text: 'world',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                fontStyle: FontStyle.italic,
              )),
        ],
      ),
    );
  }
}

// RichText widget
class TextWidgetRichText extends StatelessWidget {
  const TextWidgetRichText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        // style: const TextStyle(fontSize: 20),
        children: <TextSpan>[
          TextSpan(
            text: "You don't have the votes.\n",
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
          TextSpan(
            text: "You don't have the votes!\n",
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize),
          ),
          TextSpan(
            text:
                "You're gonna need congressional approval and you don't have the votes!\n",
            style: TextStyle(color: Colors.black.withOpacity(1.0)),
          ),
        ],
      ),
    );
  }
}
