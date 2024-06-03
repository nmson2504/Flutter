import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyForm extends StatelessWidget {
  const MyForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // theme: ThemeData(useMaterial3: true),
      home: Home2B(),
    );
  }
}

// Home1 - demo basic
class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Sample')),
      body: Form(
        key:
            _formKey, // _formKey là một GlobalKey<FormState> defined above, a key that is unique across the entire app
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              // This is a convenience widget that wraps a TextField widget in a FormField.
              // Creates a [FormField] that contains a [TextField].
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                labelText: "Input email address",
                hintText: 'Enter your email',
              ),
              validator: (String? value) {
                // validation values inputed
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.trim().isEmpty) {
                  return 'Cannot contain only spaces.';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    //  the ! operator is used for null safety.
                    // Process data.
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Home2 - onChanged - auto update on screen change

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _inputValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form onChanged Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText:
                      "Nhập dữ liệu", // labelText and label only used 1 in 2
                  // label: Text('Enter your name'), // This is the label
                  hintText: 'hintText - Enter your name',
                ),
                // If you don't use onChanged,  must use  _formKey.currentState!.save()
                onChanged: (value) {
                  // update value on UI when the value changes
                  setState(() {
                    // update value on UI and value of _inputValue
                    _inputValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text('Giá trị nhập vào: $_inputValue'),
            ],
          ),
        ),
      ),
    );
  }
}

// Home2A - get value and show on UI when click button

class Home2A extends StatefulWidget {
  const Home2A({super.key});

  @override
  Home2AState createState() {
    return Home2AState();
  }
}

class Home2AState extends State<Home2A> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';

  void _handleFormSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!
          .save(); // must be called _formKey.currentState!.save() to save values (if don't use TextFormField.onChanged)
      // Do something with the collected data, for example, print it.
      debugPrint("Name: $_name");

      setState(() {}); // update UI when called function _handleFormSubmit
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Demo'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleFormSubmit,
                child: const Text('Submit'),
              ),
              const SizedBox(height: 20),
              Text('Name: $_name'),
            ],
          ),
        ),
      ),
    );
  }
}

// Home2B - similar 2A but onPressed: dỉrect code ...
class Home2B extends StatefulWidget {
  const Home2B({super.key});

  @override
  Home2BState createState() {
    return Home2BState();
  }
}

class Home2BState extends State<Home2B> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Form Demo 2B'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  // onTab: similar 1 lần lấy focus bằng mouse or chấm cảm ứng (đang có focus thì sẽ ko tác dụng)
                  onTap: () => {
                    _formKey.currentState!.save(),
                    debugPrint('onTab: $_name')
                  },
                  onSaved: (value) {
                    // Thực hiện khi hàm  _formKey.currentState!.save(); được gọi
                    // An optional method to call with the final value when the form is saved via FormState.save.
                    // This function is automatically called when the form is saved.
                    // You can capture the value here and perform any processing you need.
                    _name = value!;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Form saving is automatically handled by the Form widget.
                    if (_formKey.currentState!.validate()) {
                      // Do any other necessary actions.
                      _formKey.currentState!
                          .save(); // must be called _formKey.currentState!.save() to save values (if don't use TextFormField.onChanged)
                      debugPrint("Name: $_name");
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ));
  }
}

// Home3 -  SingleActivator(LogicalKeyboardKey.space): NextFocusIntent(),

class Home3 extends StatefulWidget {
  const Home3({super.key});

  @override
  State<Home3> createState() => _Home3State();
}

class _Home3State extends State<Home3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form LogicalKeyboardKey.space NextFocusIntent'),
      ),
      body: Center(
        child: Shortcuts(
          shortcuts: const <ShortcutActivator, Intent>{
            // Pressing space in the field will now move to the next field.
            SingleActivator(LogicalKeyboardKey.space): NextFocusIntent(),
          },
          child: FocusTraversalGroup(
            // FocusTraversalGroup widget: This widget groups together elements that can receive focus and ensures that they can be traversed in a specific order. It's used to manage the focus behavior.
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              // when the user enters data into any form field and the data changes (e.g., a new character is typed), the onChanged callback is triggered. It then locates the nearest Form widget using the focused widget's context and calls the save() method on the Form to save the data entered in all form fields.
              onChanged: () {
                Form.of(primaryFocus!.context!).save();
              },

              child: Wrap(
                children: List<Widget>.generate(5, (int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(200, 50)),
                      child: TextFormField(
                        // The onSaved property of each TextFormField is set to a function that will be called when the form is saved.q
                        onSaved: (String? value) {
                          debugPrint(
                              'Value for field $index saved as "$value"');
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
