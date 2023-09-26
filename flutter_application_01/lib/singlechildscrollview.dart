import 'package:flutter/material.dart';

class MySingleChildScrollView extends StatelessWidget {
  const MySingleChildScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('SingleChildScrollView  Sample')),
        body: const SingleChildScrollView3(),
      ),
    );
  }
}

//
class SingleChildScrollView0 extends StatelessWidget {
  const SingleChildScrollView0({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Phần đầu trang',
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 600.0,
            color: Colors.green,
            child: const Center(
              child: Text(
                'Nội dung dài ở đây...',
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 400.0,
            color: Colors.orange,
            child: const Center(
              child: Text(
                'Phần cuối trang',
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//
class SingleChildScrollView1 extends StatelessWidget {
  const SingleChildScrollView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            Container(
              width: 200.0,
              height: 200.0,
              color: Colors.red,
            ),
            Container(
              width: 200.0,
              height: 200.0,
              color: Colors.blue,
            ),
            Container(
              width: 200.0,
              height: 200.0,
              color: Colors.green,
            ),
            Container(
              width: 200.0,
              height: 200.0,
              color: Colors.yellow,
            ),
            Container(
              width: 200.0,
              height: 200.0,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}

//
class SingleChildScrollView2 extends StatelessWidget {
  const SingleChildScrollView2({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          ListTile(
            title: Text('Item 1'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 2'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 3'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 4'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 5'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 6'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 7'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 8'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 9'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
          ListTile(
            title: Text('Item 10'),
            leading: Text('Leading: data '),
            subtitle: Icon(Icons.ac_unit),
          ),
        ],
      ),
    );
  }
}

// lồng SingleChildScrollView trong SingleChildScrollView
class SingleChildScrollView3 extends StatelessWidget {
  const SingleChildScrollView3({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    color: Colors.red,
                    height: 150,
                    width: 250,
                  ),
                  Container(
                    color: const Color.fromARGB(255, 211, 239, 116),
                    height: 150,
                    width: 250,
                  ),
                  Container(
                    color: Colors.green,
                    height: 150,
                    width: 250,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            color: const Color.fromARGB(255, 254, 83, 217),
          ),
          Container(
            height: 200,
            color: Colors.blueAccent,
          ),
          Container(
            height: 200,
            color: const Color.fromARGB(255, 63, 247, 216),
          ),
          Container(
            height: 200,
            color: const Color.fromARGB(255, 243, 245, 150),
          ),
        ],
      ),
    );
  }
}
