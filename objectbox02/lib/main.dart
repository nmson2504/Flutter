import 'package:flutter/material.dart';
import 'package:objectbox01/objectbox.g.dart';
import 'model.dart'; // Import model

// Dart ngầm hiểu hàm trả về một Future<void> (void main() async{... tương đương Future<void>)
void main() async {
  /* 

1. WidgetsFlutterBinding.ensureInitialized();
Dòng này đảm bảo rằng tất cả các tiện ích (widgets) và các cơ chế liên quan đến giao diện đồ họa của Flutter đã được khởi tạo.
WidgetsFlutterBinding là lớp chịu trách nhiệm liên kết giữa framework Flutter và các native widgets của hệ điều hành (như Android, iOS).
Khi bạn cần thực hiện một số tác vụ nhất định yêu cầu giao diện đã sẵn sàng, chẳng hạn như khởi tạo cơ sở dữ liệu hoặc tải dữ liệu trước khi runApp() được gọi, bạn phải đảm bảo rằng hệ thống Flutter đã được khởi tạo đầy đủ. ensureInitialized() thực hiện điều này bằng cách đảm bảo mọi tài nguyên liên quan đến widget đã sẵn sàng.
Khi nào sử dụng:
Khi bạn cần sử dụng một số tính năng hoặc khởi tạo tài nguyên trước khi ứng dụng chạy, như mở cơ sở dữ liệu, thực hiện các tác vụ không đồng bộ (asynchronous tasks), hoặc cấu hình Firebase, v.v. */
  WidgetsFlutterBinding.ensureInitialized();
/* 2. final store = await openStore();
Dòng này khởi tạo một đối tượng store, thường là từ thư viện ObjectBox để mở kết nối đến cơ sở dữ liệu ObjectBox.
openStore() là một hàm không đồng bộ (asynchronous) được sử dụng để mở hoặc tạo ra một "store" (nơi lưu trữ dữ liệu trong ObjectBox). Do đó, từ khóa await được dùng để chờ quá trình này hoàn thành trước khi tiếp tục thực hiện các dòng lệnh tiếp theo. */
  final store = await openStore();
  runApp(MyApp(store: store)); //Chạy ứng dụng MyApp, truyền store vào.
}

class MyApp extends StatelessWidget {
  final Store store;

  MyApp({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ObjectBox CRUD',
      home: NotesScreen(store: store),
    );
  }
}

class NotesScreen extends StatefulWidget {
  final Store store;

  const NotesScreen({super.key, required this.store});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  /* Box trong ObjectBox đại diện cho một "hộp" chứa các đối tượng thuộc một lớp nhất định (ở đây là Note). Đây là nơi lưu trữ và quản lý dữ liệu của các đối tượng trong cơ sở dữ liệu ObjectBox.
Box<Note> là một đối tượng chứa các ghi chú thuộc lớp Note. Bạn có thể hiểu "box" giống như một bảng trong cơ sở dữ liệu truyền thống, nơi chứa nhiều bản ghi (ở đây là các đối tượng Note).

Trước khi bạn có thể sử dụng noteBox, bạn cần khởi tạo ObjectBox và mở một "store" (kết nối đến cơ sở dữ liệu).
Lấy box từ store: Sau khi store được mở, bạn sẽ sử dụng phương thức box<T>() để lấy Box<Note>. Đây là lúc bạn khởi tạo biến noteBox. */
  late Box<Note> noteBox;
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    noteBox = widget.store.box<Note>(); //  // Khởi tạo noteBox sau khi store đã mở
  }

  void _addNote() {
    final note = Note(
      title: titleController.text,
      content: contentController.text,
    );
    noteBox.put(note); // thêm note vào box
    titleController.clear();
    contentController.clear();
    setState(() {});
  }

  void _deleteNote(int id) {
    noteBox.remove(id); // remove note có id khỏi noteBox
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final notes = noteBox.getAll(); //Returns all stored objects in this Box.

    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
          ),
          ElevatedButton(onPressed: _addNote, child: const Text('Add Note')),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteNote(note.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
