import 'package:flutter/material.dart';

/*
https://www.geeksforgeeks.org/flutter-flexible-widget/ 
 */
class MyLayout extends StatelessWidget {
  const MyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('GeeksforGeeks'),
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
    return Center(
      child: Container(
          child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 175,
                  height: 175,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ), //BoxDecoration
                ), //Container
                const SizedBox(
                  width: 20,
                ), //SizedBox
                Container(
                    width: 175,
                    height: 175,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ) //BoxDecoration
                    ) //Container
              ],
            ), //Row
            Container(
              width: 380,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue), //BoxDecoration
            ), //Container
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 180,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.cyan,
                  ), //BoxDecoration
                ), //Container
                const SizedBox(
                  width: 20,
                ), //SizedBox
                Container(
                    width: 180,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.cyan,
                    ) //BoxedDecoration
                    ) //Container
              ],
            ), //Row
          ],
        ), //Column
      ) //Padding
          ), //Container
    ); //Center
  }
}
