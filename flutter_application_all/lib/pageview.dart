import 'package:flutter/material.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter PageView')),
        body: PageView4(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}
//---------------------------

class PageView1 extends StatelessWidget {
  const PageView1({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      controller: controller,
      reverse: true, // reverse order pages
      children: const <Widget>[
        Center(
          child: Text('First Page'),
        ),
        Center(
          child: Text('Second Page'),
        ),
        Center(
          child: Text('Third Page'),
        ),
      ],
    );
  }
}

// PageView2 - PageView.builder - Creates a scrollable list that works page by page using widgets that are created on demand.
class PageView2 extends StatelessWidget {
  PageView2({super.key});

  final List<String> imageUrls = [
    'https://images.pexels.com/photos/276267/pexels-photo-276267.jpeg',
    'https://images.pexels.com/photos/2280549/pexels-photo-2280549.jpeg',
    'https://images.pexels.com/photos/34299/herbs-flavoring-seasoning-cooking.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: imageUrls
          .length, // tránh lỗi: RangeError (RangeError (index): Invalid value: Not in inclusive range 0....)
      itemBuilder: (context, index) {
        return Image.network(
          imageUrls[index],
          fit: BoxFit.scaleDown,
        );
      },
    );
  }
}

//  PageController.initialPage - set the initial page
class PageView3 extends StatelessWidget {
  PageView3({super.key});
  final List<String> imageUrls = [
    'https://images.pexels.com/photos/276267/pexels-photo-276267.jpeg',
    'https://images.pexels.com/photos/2280549/pexels-photo-2280549.jpeg',
    'https://images.pexels.com/photos/34299/herbs-flavoring-seasoning-cooking.jpg',
  ];

  final PageController _pageController = PageController(
      initialPage: 2); //PageController.initialPage - set the initial page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Viewer'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Image.network(
            imageUrls[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}

// PageView.custom

class PageView4 extends StatelessWidget {
  PageView4({super.key});
  final List<String> data = ['Page 1', 'Page 2', 'Page 3'];

  @override
  Widget build(BuildContext context) {
    return PageView.custom(
      childrenDelegate: SliverChildBuilderDelegate(
        // required
        (context, index) {
          return Container(
            color: index % 2 == 0 ? Colors.blue : Colors.green,
            alignment: Alignment.center,
            child: Text(
              data[index],
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          );
        },
        childCount: data
            .length, // tránh lỗi: RangeError (RangeError (index): Invalid value: Not in inclusive range 0...)
      ),
      onPageChanged: (index) {
        // whenever the page changes
        debugPrint('Page changed to: $index');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('This is a ${data[index]}'),
            duration: const Duration(seconds: 1)));
      },
      controller: PageController(initialPage: 1),
    );
  }
}
