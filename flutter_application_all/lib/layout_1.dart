import 'package:flutter/material.dart';

/*
Bài thực hành số 1
https://www.youtube.com/watch?v=Ee-76v4pgWg&list=PL3Ob3F0T-08brnWfs8np2ROjICeT-Pr6T&index=50
 */
class MyLayout extends StatelessWidget {
  const MyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Form thông tin cá nhân'),
            backgroundColor: Colors.greenAccent[400],
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
              tooltip: 'Menu',
            ) //IconButton
            ), //AppBar
        body: const MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        const Row(children: [
          SizedBox(
              width: 80,
              child: Text(
                'User name:',
                style: TextStyle(color: Colors.blueGrey),
              )),
          Text('Nguyen Minh')
        ]),
        const Row(children: [
          SizedBox(
              width: 80,
              child: Text(
                'Email:',
                style: TextStyle(color: Colors.blueGrey),
              )),
          Text('ngminh@gmail.com')
        ]),
        const Row(children: [
          SizedBox(
              width: 80,
              child: Text(
                'Address:',
                style: TextStyle(color: Colors.blueGrey),
              )),
          Text('179 Tran Van Dang - F11, Q3')
        ]),
        const SizedBox(
          height: 10,
        ),
        Row(children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: () {},
              child: const Text('Cancel'),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Submit'),
            ),
          ),
        ]),
      ]),
    );
  }
}
