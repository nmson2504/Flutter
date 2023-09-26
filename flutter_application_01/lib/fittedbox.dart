import 'package:flutter/material.dart';

class MyFittedBox extends StatelessWidget {
  const MyFittedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('FittedBox Sample')),
        body: const FittedBoxExample(),
      ),
    );
  }
}

class FittedBoxExample extends StatelessWidget {
  const FittedBoxExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: 300,
          color: Colors.blue,
          child: FittedBox(
            // TRY THIS: Try changing the fit types to see how they change the way
            // the placeholder fits into the container.
            fit: BoxFit.fitHeight,
            child: Image.asset('assets/lion.jpg'),
          ),
        ),
        Container(
          height: 200,
          width: 300,
          color: Colors.blue,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Image.asset('assets/lion.jpg'),
          ),
        ),
        // Container(
        //   height: 200,
        //   width: 300,
        //   color: Colors.blue,
        //   child: FittedBox(
        //     fit: BoxFit.scaleDown,
        //     child: Image.asset('assets/lion.jpg'),
        //   ),
        // ),
        Container(
          height: 200,
          width: 300,
          color: Colors.blue,
          child: FittedBox(
            fit: BoxFit.contain, // lấn sang các space lân cận: fitWidth, cover
            child: Image.asset('assets/lion.jpg'),
          ),
        ),
      ],
    );
  }
}
