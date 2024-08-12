import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Container')),
        body: const MyContainer3(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

class MyContainer1a extends StatelessWidget {
  const MyContainer1a({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Center(
        widthFactor: 3, // width = width object con * widthFactor
        heightFactor: 5, // height = height object con * heightFactor
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Hello, World!'),
        ),
      ),
    );
  }
}

class MyContainer1 extends StatelessWidget {
  const MyContainer1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        heightFactor: 2,
        child: Container(
          // alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(
              left: 100), // áp dụng cho lề container với widget chứa nó
          color: Colors.greenAccent[100],
          padding: const EdgeInsets.fromLTRB(
              50, 20, 50, 5), // áo dụng cho child với lề của container
          // width: 400,
          // height: 200,
          constraints: const BoxConstraints(
              maxHeight: 200, maxWidth: 200, minHeight: 100, minWidth: 100),
          child: const Text('ABC'),
        ));
  }
}
/* 
Lưu ý khi sử dụng BoxShape.circle và borderRadius cùng lúc sẽ báo lỗi
Exception has occurred.
_AssertionError ('package:flutter/src/painting/box_decoration.dart': Failed assertion: line 128 pos 12: 'shape != BoxShape.circle || borderRadius == null': is not true.)
--> bỏ set 1 trong 2
 */

//
class MyContainer2 extends StatelessWidget {
  const MyContainer2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Container')),
        body: Column(
          children: [
            Container(
              width:
                  200, // ko set - full screen - chỉ set height: auto canh top-center
              height: 200,

              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                    0.3), // ko thể set color cùng lúc với color trước đó của container (chỉ có thể chọn 1 trong 2)
                border: Border.all(
                  width: 2,
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(20), // or
                //borderRadius: const BorderRadius.all(Radius.circular(20)),
                //shape: BoxShape.circle,

                gradient: const SweepGradient(
                  colors: [Colors.red, Colors.blue],
                  center: Alignment.center, // Điểm tâm gradient
                  startAngle: 0, // Góc bắt đầu gradient (độ)
                  endAngle: 3.14, // Góc kết thúc gradient (độ)
                ),
              ), // tính chất tương tự width
              child: const Text(
                'This is container SweepGradient',
                style: TextStyle(backgroundColor: Colors.blueAccent),
              ),
            ),
            Container(
              width:
                  200, // ko set - full screen - chỉ set height: auto canh top-center
              height: 200,

              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                    0.3), // ko thể set color cùng lúc với color trước đó của container (chỉ có thể chọn 1 trong 2)
                border: Border.all(
                  width: 2,
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(20), // or
                //borderRadius: const BorderRadius.all(Radius.circular(20)),
                //shape: BoxShape.circle,
                gradient: const RadialGradient(
                  colors: [Colors.yellow, Colors.orange],
                  center: Alignment.center, // Điểm tâm gradient
                  radius: 0.8, // Bán kính gradient
                ),
              ), // tính chất tương tự width
              child: const Text(
                'This is container RadialGradient',
                style: TextStyle(backgroundColor: Colors.blueAccent),
              ),
            ),
            Container(
              width:
                  200, // ko set - full screen - chỉ set height: auto canh top-center
              height: 200,

              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                    0.3), // ko thể set color cùng lúc với color trước đó của container (chỉ có thể chọn 1 trong 2)
                border: Border.all(
                  width: 2,
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(20), // or
                //borderRadius: const BorderRadius.all(Radius.circular(20)),
                //shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.purple
                  ], // Danh sách màu tạo gradient
                  begin: Alignment.topLeft, // Điểm bắt đầu gradient
                  end: Alignment.bottomRight, // Điểm kết thúc gradient
                ),
              ), // tính chất tương tự width
              child: const Text(
                'This is container LinearGradient',
                style: TextStyle(backgroundColor: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyContainer3 extends StatelessWidget {
  const MyContainer3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Container')),
        body: Container(
          //  color: Colors.amberAccent,
          width:
              300, // ko set - full screen - chỉ set height: auto canh top-center
          height: 300,
          // alignment: Alignment.centerLeft, // alignment object con so với khung container = constant
          //alignment: Alignment(  0.5, 0.5), // alignment object con so với khung container = (x,y)
          //alignment: FractionalOffset(0.25, 0.25),
          padding: const EdgeInsets.all(
              20), // padding object con với khung container. nếu có gán alignment thì padding += alignment
          margin: const EdgeInsets.all(
              20), // margin của container này với object cha chứa nó
          // // decoration: thêm các hiệu ứng định dạng cho container
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 43, 221, 90).withOpacity(
                0.3), // ko thể set color cùng lúc với color trước đó của container (chỉ có thể chọn 1 trong 2)
            border: Border.all(
              width: 2,
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(
                20), // or borderRadius: const BorderRadius.all(Radius.circular(20)),
            // shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 109, 239, 22), // Màu của bóng
                offset: Offset(3, 3), // Vị trí tương đối của bóng (ngang, dọc)
                blurRadius: 20, // Độ mờ của bóng
                spreadRadius: 0, // Độ lan tỏa của bóng
              ),
            ],
            backgroundBlendMode: BlendMode.exclusion, // Chế độ blend
            image: const DecorationImage(
              image: AssetImage('assets/image3.jpg'), // Đường dẫn hình ảnh
              fit: BoxFit
                  .cover, // Cách hình ảnh được hiển thị (cover, contain, ...)
            ),
          ), // tính chất tương tự width
          child: const Text(
            '...This is container...This is container...This is container...This is container...This is container...',
            style: TextStyle(backgroundColor: Colors.blueAccent),
          ),
        ),
      ),
    );
  }
}
