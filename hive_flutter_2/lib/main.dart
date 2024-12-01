import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
// Split database model in contact_model.dart
import 'contact_model.dart'; // Import file model

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(RelationshipAdapter());
  // contactsBoxName đã được defined in contact_model.dart
  await Hive.openBox<Contact>(contactsBoxName);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // defined buildDivider widget để dùng bên dưới
    Widget buildDivider() => const SizedBox(height: 5);

    return MaterialApp(
      title: 'Contacts App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Contacts App with Hive'),
        ),
        /* 
        ValueListenableBuilder là một widget đặc biệt trong Flutter giúp theo dõi và cập nhật UI tự động khi giá trị của một ValueListenable thay đổi
        Tham số valueListenable là nguồn dữ liệu mà widget sẽ theo dõi. Mỗi khi valueListenable phát hiện thay đổi, builder sẽ được gọi lại để cập nhật UI.
         */
        body: ValueListenableBuilder(
          // .listenable(): Tạo ra một đối tượng ValueListenable theo dõi các thay đổi trong hộp box. Khi dữ liệu bên trong hộp box thay đổi (ví dụ: thêm, xóa, hoặc cập nhật một đối tượng Contact), ValueListenableBuilder sẽ tự động rebuild UI.
          valueListenable: Hive.box<Contact>(contactsBoxName).listenable(),
          // Box<Contact> box: Đối tượng box của kiểu Box<Contact> chứa các giá trị Contact. Đây là nguồn dữ liệu được lấy từ valueListenable.
          // _: Đại diện cho child, là widget con không thay đổi trong builder. Ở đây không sử dụng child, nên _ chỉ là một biến placeholder để bỏ qua tham số.
          builder: (context, Box<Contact> box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text("No contacts"),
              );
            }
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                // box.getAt(index): Truy xuất đối tượng Contact tại vị trí index từ box.
                Contact? c = box.getAt(index);
                // relationships defined is Map<Relationship, String> in contact_model.dart
                String relationship = relationships[c!.relationship]!;
                return InkWell(
                  // gọi showDialog trên callback onLongPress
                  onLongPress: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => AlertDialog(
                        content: Text(
                          "Do you want to delete ${c!.name}?",
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text("No"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          ElevatedButton(
                            child: const Text("Yes"),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await box.deleteAt(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  // nội dung mỗi contact
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildDivider(),
                          Text(c.name),
                          buildDivider(),
                          Text(c.phoneNumber),
                          buildDivider(),
                          Text("Age: ${c.age}"),
                          buildDivider(),
                          Text("Relationship: $relationship"),
                          buildDivider(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        // button Add contact
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddContact()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class AddContact extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  AddContact({super.key});

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  late String name;
  late int age;
  late String phoneNumber;
  late Relationship relationship = Relationship.Family;

  void onFormSubmit() {
    /*
    + widget.formKey: Tham chiếu đến khóa (formKey) của form, có thể là một GlobalKey<FormState>. formKey được khai báo trong StatefulWidget và giúp quản lý trạng thái của form.
    + currentState!: Lấy trạng thái hiện tại của form bằng cách sử dụng formKey. Toán tử ! khẳng định rằng currentState không null.
    + .validate(): Gọi phương thức validate() trên FormState. Phương thức này sẽ kiểm tra từng FormField trong form và thực hiện các hàm validator của chúng.
    Nếu tất cả các trường hợp hợp lệ, validate() trả về true.
    Nếu có trường không hợp lệ, validate() trả về false.
    Chỉ khi validate() trả về true, đoạn mã bên trong khối if mới được thực thi. */
    if (widget.formKey.currentState!.validate()) {
      Box<Contact> contactsBox = Hive.box<Contact>(contactsBoxName);
      contactsBox.add(Contact(name, age, phoneNumber, relationship!));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: widget.formKey,
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: <Widget>[
              TextFormField(
                autofocus: true,
                initialValue: "",
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: "",
                maxLength: 3,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: const InputDecoration(
                  labelText: "Age",
                ),
                onChanged: (value) {
                  setState(() {
                    age = int.parse(value);
                  });
                },
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                initialValue: "",
                decoration: const InputDecoration(
                  labelText: "Phone",
                ),
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
              ),
              DropdownButtonFormField<Relationship>(
                items: relationships.keys.map((Relationship value) {
                  return DropdownMenuItem<Relationship>(
                    value: value,
                    child: Text(relationships[value]!),
                  );
                }).toList(),
                value: relationship,
                hint: const Text("Relationship"),
                onChanged: (value) {
                  setState(() {
                    relationship = value!;
                  });
                },
                validator: (value) => value == null ? "Please select a relationship" : null,
              ),
              OutlinedButton(
                onPressed: onFormSubmit,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
