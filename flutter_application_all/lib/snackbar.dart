import 'package:flutter/material.dart';

class MySnackBar extends StatelessWidget {
  const MySnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('SnackBar  Sample')),
        body: const SnackBar2(),
      ),
    );
  }
}
//

class SnackBar1 extends StatelessWidget {
  const SnackBar1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Show Snackbar'),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Awesome Snackbar!'),
              action: SnackBarAction(
                // action button
                label: 'Action',
                onPressed: () {
                  // Code to execute.
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

//

class SnackBar2 extends StatelessWidget {
  const SnackBar2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Show Snackbar'),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              action: SnackBarAction(
                label: 'Action',
                onPressed: () {
                  // Code to execute.
                },
              ),
              content: const Text('Awesome SnackBar!'),
              duration: const Duration(
                  milliseconds: 1500), // SnackBar display duration.
              // width:250.0, // Width of the SnackBar. //  Width and margin can not be used together
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0, // Inner padding for SnackBar content.
              ),
              margin: const EdgeInsets.all(
                  20), //  Width and margin can not be used together
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
