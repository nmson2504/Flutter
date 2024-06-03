import 'package:flutter/material.dart';

class MyTable extends StatelessWidget {
  const MyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(useMaterial3: true), home: const Home0());
  }
}

/// Table widget trong Flutter được sử dụng  khi bạn muốn sắp xếp các phần tử hoặc widget trong một bảng có cấu trúc cố định. Table widget cho phép bạn tạo một bảng có nhiều dòng và cột, và bạn có thể kiểm soát cách chúng sắp xếp.
// home 0 -

class Home0 extends StatelessWidget {
  const Home0({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Table Widget Demo'),
        ),
        body: Table(
          defaultColumnWidth:
              const FlexColumnWidth(), //  defaultColumnWidth - not null
          border: TableBorder.all(),
          children: [
            TableRow(
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  height: 100,
                ),
                Container(
                  color: Colors.red,
                  height: 100,
                ),
                Container(
                  color: Colors.green,
                  height: 100,
                ),
              ],
            ),
            TableRow(
              children: [
                Container(
                  color: Colors.orange,
                  height: 100,
                ),
                Container(
                  color: Colors.purple,
                  height: 100,
                ),
                Container(
                  color: Colors.yellow,
                  height: 100,
                ),
              ],
            ),
          ],
        ));
  }
}

// Home1 -

class Home1 extends StatelessWidget {
  const Home1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Table Sample')),
        body: Table(
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            ///
// Dưới đây là giải thích ý nghĩa của đoạn mã:
// columnWidths là một ánh xạ (map) từ chỉ mục cột (số nguyên) đến độ rộng mong muốn của cột đó. Chúng ta đang xác định độ rộng cho mỗi cột dựa trên chỉ mục của cột.
// Cột có chỉ mục 0 sử dụng IntrinsicColumnWidth(). Điều này có nghĩa là độ rộng của cột này sẽ được tự động điều chỉnh để phù hợp với nội dung bên trong cột. Nếu nội dung của cột đủ rộng, cột sẽ có độ rộng tối ưu, không quá lớn hoặc nhỏ. Điều này thường được sử dụng cho các cột chứa văn bản hoặc nội dung động.
// Cột có chỉ mục 1 sử dụng FlexColumnWidth(). Điều này có nghĩa rằng cột này sẽ sử dụng một mô hình phần trăm (flex) để xác định độ rộng. Cụ thể, nó sẽ sử dụng một phần trăm tương đối so với các cột khác trong bảng. Điều này cho phép bạn điều chỉnh tỷ lệ độ rộng giữa các cột.
// Cột có chỉ mục 2 sử dụng FixedColumnWidth(64). Điều này đặt độ rộng của cột này là một giá trị cố định là 64 đơn vị. Cột này sẽ có kích thước cố định không thay đổi dựa trên nội dung hay tỷ lệ.
            0: IntrinsicColumnWidth(), // auto resize column width
            1: FlexColumnWidth(),
            2: FixedColumnWidth(64),
          },
          defaultVerticalAlignment:
              TableCellVerticalAlignment.middle, // not null
          children: <TableRow>[
            // children - not null. Every row in a table must have the same number of children (số column bằng nhau), and all the children must be non-null.
            TableRow(
              children: <Widget>[
                Container(
                  height: 32,
                  color: Colors.green,
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Container(
                    height: 32,
                    width: 32,
                    color: Colors.red,
                  ),
                ),
                Container(
                  height: 64,
                  color: Colors.blue,
                ),
              ],
            ),
            TableRow(
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              children: <Widget>[
                Container(
                  height: 64,
                  width: 128,
                  color: Colors.purple,
                ),
                Container(
                  height: 32,
                  color: Colors.yellow,
                ),
                Center(
                  child: Container(
                    height: 32,
                    width: 32,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
