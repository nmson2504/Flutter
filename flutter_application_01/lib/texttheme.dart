import 'package:flutter/material.dart';

class TextThemeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 30,
              color: Colors.green,
              fontWeight: FontWeight.bold), // Font chữ mặc định
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DefaultTextStyle Example'),
      ),
      body: const Center(
        child: Text(
            'Hello, World!'), // Chữ sẽ có font chữ 'Roboto' do mặc định đã thiết lập
      ),
    );
  }
}
