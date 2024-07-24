import 'package:flutter/material.dart';

class MyUI extends StatelessWidget {
  const MyUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoUI011();
  }
}

/* 
Mục đích DecoratedBox là trang trí cho object con, nên nếu ko set thuộc tính child thì sẽ không show DecoratedBox lên
Khi sử dụng BoxDecoration có thuộc tính image mà nằm trong Positioned thì phải set các giá trị top, bottom, left, right = 0(or dùng Positioned.fill) thì mới show image được
 */
class DemoUI00 extends StatelessWidget {
  const DemoUI00({super.key});

  @override
  Widget build(BuildContext context) {
    // materialApp with debugbanner false
    return MaterialApp(
      // theme of the app
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      // scaffold with app
      home: Scaffold(
        // appbat sets the title of the app
        appBar: AppBar(
          title: const Text('Set Backgound Image'),
        ),
        // Decoratedbox which takes the
        // decoration and child property
        body: const DecoratedBox(
          // BoxDecoration takes the image
          decoration: BoxDecoration(
            // Image set to background of the body
            image: DecorationImage(image: AssetImage("assets/image3.jpg"), fit: BoxFit.cover),
          ),

          child: Center(
              // flutter logo that will shown
              // above the background image
              ),
        ),
      ),
    );
  }
}

//
class DemoUI01 extends StatelessWidget {
  const DemoUI01({super.key});

  @override
  Widget build(BuildContext context) {
    // materialApp with debugbanner false
    return MaterialApp(
      // theme of the app
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      // scaffold with app
      home: Scaffold(
        // appbat sets the title of the app
        appBar: AppBar(
          title: const Text('Demo UI 01'),
        ),
        // Decoratedbox which takes the
        body: Stack(children: [
          Container(
            color: Colors.lime,
          ),
          const Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: SizedBox(
                width: 250, // Đặt chiều rộng cụ thể cho Card
                child: Card(
                    child: ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text('John Doe'),
                        subtitle: Text('Software Engineer'),
                        trailing: Icon(Icons.arrow_forward))),
              )),
        ]),
      ),
    );
  }
}

// DecoratedBox ko nằm trong Positioned - phải có DecoratedBox.child
class DemoUI011 extends StatelessWidget {
  const DemoUI011({super.key});

  @override
  Widget build(BuildContext context) {
    // materialApp with debugbanner false
    return MaterialApp(
        // theme of the app
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        // scaffold with app
        home: Scaffold(
          // appbat sets the title of the app
          appBar: AppBar(
            title: const Text('Demo UI 011'),
          ),
          // Decoratedbox which takes the
          body: Stack(
            children: <Widget>[
              // Background Image
              DecoratedBox(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(), // This container is needed to fill the space
              ),
              // Positioned ListTile
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('John Doe'),
                    subtitle: Text('Software Engineer'),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

//
class DemoUI01a extends StatelessWidget {
  const DemoUI01a({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Demo UI 01a'),
        ),
        body: Stack(
          children: <Widget>[
            /* 
            Positioned.fill
Positioned.fill là một cách thuận tiện để đặt một widget con để lấp đầy toàn bộ không gian của Stack.
Nó đặt tất cả các giá trị top, bottom, left, và right thành 0, do đó đảm bảo rằng widget con sẽ chiếm toàn bộ không gian có sẵn trong Stack. */
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/image3.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20, // Thêm để Card chiếm toàn bộ chiều rộng
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('John Doe', textScaler: TextScaler.linear(2.0)),
                  subtitle: Text(
                      style: TextStyle(fontSize: 20),
                      'In this article, we are going to implement how to set the background image in the body of the scaffold. A sample image is given below to get an idea about what we are going to do in this article.'),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DemoUI01b extends StatelessWidget {
  const DemoUI01b({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Demo UI 01b'),
        ),
        body: Stack(
          children: <Widget>[
            /* 
            Positioned.fill
Positioned.fill là một cách thuận tiện để đặt một widget con để lấp đầy toàn bộ không gian của Stack.
Nó đặt tất cả các giá trị top, bottom, left, và right thành 0, do đó đảm bảo rằng widget con sẽ chiếm toàn bộ không gian có sẵn trong Stack. */
            Positioned.fill(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset(
                  "assets/image3.jpg",
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20, // Thêm để Card chiếm toàn bộ chiều rộng
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('John Doe', textScaler: TextScaler.linear(2.0)),
                  subtitle: Text(
                      style: TextStyle(fontSize: 20),
                      'In this article, we are going to implement how to set the background image in the body of the scaffold. A sample image is given below to get an idea about what we are going to do in this article.'),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
class DemoUI02 extends StatelessWidget {
  const DemoUI02({super.key});

  @override
  Widget build(BuildContext context) {
    // materialApp with debugbanner false
    return MaterialApp(
        // theme of the app
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        // scaffold with app
        home: Scaffold(
          // appbat sets the title of the app
          appBar: AppBar(
            title: const Text('Demo UI 02'),
          ),
          // Decoratedbox which takes the
          body: const Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image3.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Add other widgets here
            ],
          ),
        ));
  }
}
