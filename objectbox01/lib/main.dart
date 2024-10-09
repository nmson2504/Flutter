import 'dart:async';
import 'package:flutter/material.dart';
import 'model.dart';
import 'objectbox.dart';

// ignore_for_file: public_member_api_docs
// Tách riêng xử lý ObjectBox ra file objectbox.dart - xử lý dư liệu asynchronous
/// Provides access to the ObjectBox Store throughout the app.
late ObjectBox objectbox;

Future<void> main() async {
  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'OB Example',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage(title: 'OB Example'),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _noteInputController = TextEditingController();

  Future<void> _addNote() async {
    if (_noteInputController.text.isEmpty) return;
    await objectbox.addNote(_noteInputController.text);
    _noteInputController.text = '';
  }

  @override
  void dispose() {
    _noteInputController.dispose();
    super.dispose();
  }

  GestureDetector Function(BuildContext, int) _itemBuilder(List<Note> notes) =>
      (BuildContext context, int index) => GestureDetector(
            onTap: () => objectbox.removeNote(notes[index].id),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            notes[index].text,
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                            // Provide a Key for the integration test
                            key: Key('list_item_$index'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              'Added on ${notes[index].dateFormat}',
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextField(
                          decoration: const InputDecoration(hintText: 'Enter a new note'),
                          controller: _noteInputController,
                          onSubmitted: (value) =>
                              _addNote(), //  gọi hàm _addNote() khi người dùng nhấn "Enter" sau khi nhập một ghi chú trong TextField.
                          // Provide a Key for the integration test
                          key: const Key('input'),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, right: 10.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Tap a note to remove it',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
              /* 
Không cần gọi setState() sau khi thêm hoặc xóa ghi chú vì sử dụng StreamBuilder để tự động cập nhật giao diện khi có thay đổi dữ liệu. Dưới đây là lý do chi tiết:

1. StreamBuilder<List<Note>> và dữ liệu động
StreamBuilder là một widget rất hữu ích trong Flutter để xây dựng giao diện dựa trên các luồng dữ liệu (streams). Nó lắng nghe các thay đổi trong luồng (stream) và tự động rebuild lại giao diện bất cứ khi nào có sự thay đổi dữ liệu phát ra từ stream đó.
Trong ví dụ này, phương thức objectbox.getNotes() trả về một Stream<List<Note>>. Stream này phát ra một danh sách các ghi chú (List<Note>) bất cứ khi nào dữ liệu trong ObjectBox thay đổi (ví dụ: khi bạn thêm hoặc xóa một ghi chú).

2. Tự động rebuild giao diện khi dữ liệu thay đổi
Vì StreamBuilder đang lắng nghe stream từ objectbox.getNotes(), nên mỗi khi ghi chú mới được thêm vào hoặc xóa đi (khi bạn gọi addNote() hoặc removeNote()), stream phát ra dữ liệu mới (danh sách các ghi chú được cập nhật), và StreamBuilder tự động thực hiện quá trình "rebuild" giao diện mà không cần phải gọi setState().
             */
              child: StreamBuilder<List<Note>>(
                  stream: objectbox.getNotes(),
                  builder: (context, snapshot) => ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                      itemBuilder: _itemBuilder(snapshot.data ?? []))))
        ]),
        // We need a separate submit button because flutter_driver integration
        // test doesn't support submitting a TextField using "enter" key.
        // See https://github.com/flutter/flutter/issues/9383
        floatingActionButton: FloatingActionButton(
          key: const Key('submit'),
          onPressed: _addNote,
          child: const Icon(Icons.add),
        ),
      );
}
