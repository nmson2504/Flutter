import 'package:flutter/material.dart';

class MyGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyGridPage(),
    );
  }
}

class MyGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Overlay Example'),
      ),
      body: Stack(
        children: [
          // Your main content goes here
          Center(
            child: Text('Main Content'),
          ),
          // Overlay grid
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10, // Số cột trong lưới
            ),
            itemBuilder: (context, index) {
              //Mỗi ô trong lưới được tạo bằng cách sử dụng Container với viền để hiển thị đường kẻ giữa các ô.
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
