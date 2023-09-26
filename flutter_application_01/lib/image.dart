import 'package:flutter/material.dart';
import 'dart:io';

class MyImage extends StatelessWidget {
  const MyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Image Example'),
        ),
        body: const MyImageConstruct(),
      ),
    );
  }
}

// Example - constructor not "."
class MyImageConstruct extends StatelessWidget {
  const MyImageConstruct({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: FileImage(File('assets/Lion.jpg')),
          height: 200,
        ),
        const Image(
          image: AssetImage('assets/image_a.webp'),
          height: 200,
        ),
        const Image(
          image: NetworkImage(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
          height: 200,
        ),
      ],
    );
  }
}

/* 
Example 01:
Lưu ý rằng trong ví dụ này, chúng ta đang sử dụng Image.asset để hiển thị các hình ảnh từ thư mục assets. Bạn cần đảm bảo rằng bạn đã cấu hình đúng đường dẫn và thêm các hình ảnh vào thư mục assets trong dự án của mình.
Trong ImageRow, chúng ta sử dụng Row widget để xếp các hình ảnh cạnh nhau. mainAxisAlignment: MainAxisAlignment.spaceEvenly giúp căn đều các hình ảnh theo chiều ngang. Các hình ảnh được hiển thị bằng cách sử dụng Image.asset và chỉ định width và height để xác định kích thước.

 */
class ImageRow extends StatelessWidget {
  const ImageRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset('assets/buom.jfif', width: 150, height: 150),
        Image.asset('assets/image_a.webp', width: 150, height: 150),
        Image.asset('assets/Lion.jpg', width: 150, height: 150),
        const Image(
            width: 150,
            height: 150,
            image: NetworkImage(// Fetches the given URL from the network
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')),
        Image.network(
            // Image.network for a shorthand of an Image widget backed by NetworkImage.
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
            width: 150,
            height: 150),
      ],
    );
  }
}

// Example 02:
// Image.file, for obtaining an image from a File.
// Call app in void main():  runApp(MyFileImageWidget(File('assets/bear.jpg')));

class MyFileImageWidget extends StatelessWidget {
  final File imageFile; // import 'dart:io';

  const MyFileImageWidget(this.imageFile, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('File Image Example'),
        ),
        body: Center(
          child: Image.file(imageFile),
        ),
      ),
    );
  }
}

// Example 03:
class SemanticLabel extends StatelessWidget {
  // List<Animation<double>> scaleAnimations = 0.5 as List<Animation<double>>;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image with Semantic Label'),
        ),
        body: Center(
          child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/image2.jpg',
                width: 500, // ưu tiên hơn cacheWidth/cacheHeight, scale
                height: 500,
                // scale:
                // 0.5, // ko ưu tiên bằng width/height. Thay đổi kích thước ảnh, default = 1, scale càng lớn ảnh càng nhỏ và ngược lại
                cacheWidth: 300, // Ước tính chiều rộng
                cacheHeight: 100, // Ước tính chiều cao
                semanticLabel: 'Hình ảnh mẫu',
                // opacity: scaleAnimations ,
              )),
        ),
      ),
    );
  }
}

// Example 04:
class Animation_01 extends StatelessWidget {
  // List<Animation<double>> scaleAnimations = 0.5 as List<Animation<double>>;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image with Semantic Label'),
        ),
        body: Center(
          child: Image.asset(
            'assets/image2.jpg',
            width: 500, // ưu tiên hơn cacheWidth/cacheHeight, scale
            height: 500,
            // scale:
            // 0.5, // ko ưu tiên bằng width/height. Thay đổi kích thước ảnh, default = 1, scale càng lớn ảnh càng nhỏ và ngược lại
            // cacheWidth: 300, // Ước tính chiều rộng
            // cacheHeight: 100, // Ước tính chiều cao
            semanticLabel: 'Hình ảnh mẫu',
            opacity: const AlwaysStoppedAnimation(
                0.7), // trườn hợp animation tĩnh - phải truyền bằng An animation that is always stopped at a given value.
          ),
        ),
      ),
    );
  }
}

// Example 05:
class Image05 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Fit Test'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/bear.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Image.asset(
                'assets/bear.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Image.asset(
                'assets/bear.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.scaleDown, // default
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Color Test'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/bear.jpg',
                width: 200,
                height: 200,
                color: Colors.yellow[500],
                colorBlendMode: BlendMode.color,
              ),
              SizedBox(height: 10),
              Image.asset(
                'assets/bear.jpg',
                width: 200,
                height: 200,
                color: Colors.yellow[500],
                colorBlendMode: BlendMode.colorBurn,
              ),
              SizedBox(height: 10),
              Image.asset(
                'assets/bear.jpg',
                width: 200,
                height: 200,
                color: Colors.yellow[500],
                colorBlendMode: BlendMode.difference,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageAlignment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Color Test'),
        ),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.0),
                ),
                child: Image.asset(
                  'assets/bear.jpg',
                  // width: 150,
                  // height: 150,
                  scale:
                      4.0, // size gốc ảnh > size container: set width/height thì ảnh tự bung ra full size container --> phải set qua scale
                  // fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.0),
                ),
                child: Image.asset(
                  'assets/bear.jpg',
                  scale: 6,
                  alignment: Alignment.topRight,
                  repeat: ImageRepeat.repeat,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.0),
                ),
                child: Image.asset(
                  'assets/bear.jpg',
                  scale: 4,
                  alignment: Alignment.centerRight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
