import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class MyDateTimePicker extends StatelessWidget {
  const MyDateTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Home3(),
    );
  }
}

// Home1 - showTimePicker basic
class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Time Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? time = await showTimePicker(
                  context: context,
                  // helpText: 'Time of the day', // Default 'SELECT TIME' - label displayed at the top of the dialog (title)
                  confirmText: 'Get Time', // Default 'OK'
                  cancelText: 'Close', // Default 'Cancel'
                  hourLabelText:
                      'Giờ', // Default 'Hour' - in TimePickerEntryMode.input
                  minuteLabelText:
                      'Phút', // Default 'Minute' - TimePickerEntryMode.input
                  initialTime: TimeOfDay.now(),
                  // initialTime: const TimeOfDay(hour: 10, minute: 47),
                );
                setState(() {
                  // update UI with selectedTime
                  selectedTime = time;
                });
              },
              child: const Text('Show Time Picker'),
            ),
            if (selectedTime != null)
              Text('Selected time: ${selectedTime!.format(context)}'),
          ],
        ),
      ),
    );
  }
}

// Home1a - showTimePicker - set limit time range selected
// https://pub.dev/packages/time_range_picker
class Home1a extends StatefulWidget {
  const Home1a({super.key});

  @override
  State<Home1a> createState() => _Home1aState();
}

class _Home1aState extends State<Home1a> {
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Time Picker 1a'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  // initialTime: const TimeOfDay(hour: 10, minute: 47),
                  // anchorPoint: Offset.fromDirection(100), // chưa có tác dụng
                );
                setState(() {
                  // update UI with selectedTime
                  selectedTime = time;
                });
              },
              child: const Text('Show Time Picker'),
            ),
            if (selectedTime != null)
              Text('Selected time: ${selectedTime!.format(context)}'),
          ],
        ),
      ),
    );
  }
}

// Home1A - showTimePicker with multi option

class Home1A extends StatefulWidget {
  const Home1A({super.key});

  @override
  State<Home1A> createState() => _Home1AState();
}

class _Home1AState extends State<Home1A> {
  ThemeMode themeMode = ThemeMode.dark;
  bool useMaterial3 = true;

  void setThemeMode(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }

// switch between useMaterial3 or useMaterial2
  void setUseMaterial3(bool? value) {
    setState(() {
      useMaterial3 = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: useMaterial3),
      darkTheme: ThemeData.dark(useMaterial3: useMaterial3),
      themeMode: themeMode,
      home: TimePickerOptions(
        // TimePickerOptions defined below
        themeMode: themeMode,
        useMaterial3: useMaterial3,
        setThemeMode: setThemeMode,
        setUseMaterial3: setUseMaterial3,
      ),
    );
  }
}

class TimePickerOptions extends StatefulWidget {
  const TimePickerOptions({
    super.key,
    required this.themeMode,
    required this.useMaterial3,
    required this.setThemeMode,
    required this.setUseMaterial3,
  });

  final ThemeMode themeMode;
  final bool useMaterial3;
  final ValueChanged<ThemeMode> setThemeMode;
  final ValueChanged<bool?> setUseMaterial3;

  @override
  State<TimePickerOptions> createState() => _TimePickerOptionsState();
}

class _TimePickerOptionsState extends State<TimePickerOptions> {
  // Properties of showTimePicker
  // Allow the user to select, save the value for set to showTimePicker
  TimeOfDay? selectedTime;
  TimePickerEntryMode entryMode = TimePickerEntryMode.dial;
  Orientation? orientation;
  TextDirection textDirection = TextDirection.rtl;
  MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;
  bool use24HourTime = false;

// switch between clock dial or text input
  void _entryModeChanged(TimePickerEntryMode? value) {
    if (value != entryMode) {
      setState(() {
        entryMode = value!;
      });
    }
  }

// switch between portrait, landscape or from MediaQuery
  void _orientationChanged(Orientation? value) {
    if (value != orientation) {
      setState(() {
        orientation = value;
      });
    }
  }

  void _textDirectionChanged(TextDirection? value) {
    if (value != textDirection) {
      setState(() {
        textDirection = value!;
      });
    }
  }

  void _tapTargetSizeChanged(MaterialTapTargetSize? value) {
    if (value != tapTargetSize) {
      setState(() {
        tapTargetSize = value!;
      });
    }
  }

// switch between 12H or 24H
  void _use24HourTimeChanged(bool? value) {
    if (value != use24HourTime) {
      setState(() {
        use24HourTime = value!;
      });
    }
  }

  void _themeModeChanged(ThemeMode? value) {
    widget.setThemeMode(value!);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 350,
                mainAxisSpacing: 4,
                mainAxisExtent: 200 * MediaQuery.textScaleFactorOf(context),
                crossAxisSpacing: 4,
              ),
              children: <Widget>[
                EnumCard<TimePickerEntryMode>(
                  choices: TimePickerEntryMode
                      .values, // list the values of TimePickerEntryMode
                  value:
                      entryMode, // default option when loading time (defined above),
                  onChanged:
                      _entryModeChanged, // // switch between clock dial or text input
                ),
                EnumCard<ThemeMode>(
                  choices: ThemeMode.values, // list the values of ThemeMode
                  value: widget
                      .themeMode, // default option when loading time (defined above),
                  onChanged: _themeModeChanged,
                ),
                EnumCard<TextDirection>(
                  choices: TextDirection.values,
                  value: textDirection,
                  onChanged: _textDirectionChanged,
                ),
                EnumCard<MaterialTapTargetSize>(
                  choices: MaterialTapTargetSize
                      .values, // list the values of MaterialTapTargetSize
                  value: tapTargetSize,
                  onChanged: _tapTargetSizeChanged,
                ),
                ChoiceCard<Orientation?>(
                  // Orientation enum - Whether in portrait or landscape.
                  choices: const <Orientation?>[...Orientation.values, null],
                  value: orientation,
                  title: '$Orientation',
                  choiceLabels: <Orientation?, String>{
                    for (final Orientation choice in Orientation.values)
                      choice: choice.name,
                    null: 'from MediaQuery',
                  },
                  onChanged: _orientationChanged,
                ),
                ChoiceCard<bool>(
                  choices: const <bool>[false, true],
                  value: use24HourTime,
                  onChanged: _use24HourTimeChanged, // switch between 12H or 24H
                  title: 'Time Mode',
                  choiceLabels: const <bool, String>{
                    false: '12-hour am/pm time',
                    true: '24-hour time',
                  },
                ),
                ChoiceCard<bool>(
                  choices: const <bool>[false, true],
                  value: widget.useMaterial3,
                  onChanged: widget
                      .setUseMaterial3, // // switch between useMaterial3 or useMaterial2
                  title: 'Material Version',
                  choiceLabels: const <bool, String>{
                    false: 'Material 2',
                    true: 'Material 3',
                  },
                ),
              ],
            ),
          ),
          // Button 'Open time picker' and show selectedTime
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    child: const Text('Open time picker'),
                    onPressed: () async {
                      final TimeOfDay? time = await showTimePicker(
                        // TimeOfDay? time return value selected on showTimePicker
                        context: context,
                        initialTime:
                            selectedTime ?? TimeOfDay.now(), // time initial
                        initialEntryMode:
                            entryMode, // initialEntryMode parameter can be used to determine the initial time entry selection of the picker (either a clock dial or text input).
                        orientation: orientation,
                        builder: (BuildContext context, Widget? child) {
                          // We just wrap these environmental changes around the
                          // child in this builder so that we can apply the
                          // options selected above. In regular usage, this is
                          // rarely necessary, because the default values are
                          // usually used as-is.
                          return Theme(
                            // theme of showTimePicker
                            data: Theme.of(context).copyWith(
                              materialTapTargetSize:
                                  tapTargetSize, // padding or shrinkWrap
                            ),
                            child: Directionality(
                              // Directionality - Creates a widget that determines the directionality of text and text-direction-sensitive render objects.
                              textDirection: textDirection,
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                  alwaysUse24HourFormat:
                                      use24HourTime, // true or false
                                ),
                                child: child!,
                              ),
                            ),
                          );
                        },
                      );
                      setState(() {
                        // update UI with selectedTime
                        selectedTime = time;
                      });
                    },
                  ),
                ),
                if (selectedTime != null)
                  Text('Selected time: ${selectedTime!.format(context)}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// This is a simple card that presents a set of radio buttons (inside of a
// RadioSelection, defined below) for the user to select from.
// EnumCard or ChoiceCard show on screen.
// EnumCard return ChoiceCard
// RadioSelection is the child of ChoiceCard
class ChoiceCard<T extends Object?> extends StatelessWidget {
  const ChoiceCard({
    super.key,
    required this.value,
    required this.choices,
    required this.onChanged,
    required this.choiceLabels,
    required this.title,
  });

  final T value;
  final Iterable<T> choices;
  final Map<T, String> choiceLabels;
  final String title;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      // If the card gets too small, let it scroll both directions.
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title),
                ),
                for (final T choice in choices)
                  RadioSelection<T>(
                    // RadioSelection defined below
                    value: choice,
                    groupValue: value,
                    onChanged: onChanged,
                    child: Text(choiceLabels[choice]!),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// This aggregates a ChoiceCard so that it presents a set of radio buttons for
// the allowed enum values for the user to select from.
// EnumCard return ChoiceCard (defined above)
class EnumCard<T extends Enum> extends StatelessWidget {
  const EnumCard({
    super.key,
    required this.value,
    required this.choices,
    required this.onChanged,
  });

  final T value;
  final Iterable<T> choices;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return ChoiceCard<T>(
        value: value,
        choices: choices,
        onChanged: onChanged,
        choiceLabels: <T, String>{
          for (final T choice in choices) choice: choice.name,
        },
        title: value.runtimeType.toString());
  }
}

// A button that has a radio button on one side and a label child. Tapping on
// the label or the radio button selects the item.
class RadioSelection<T extends Object?> extends StatefulWidget {
  const RadioSelection({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.child,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final Widget child;

  @override
  State<RadioSelection<T>> createState() => _RadioSelectionState<T>();
}

class _RadioSelectionState<T extends Object?> extends State<RadioSelection<T>> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 8),
          child: Radio<T>(
            groupValue: widget.groupValue,
            value: widget.value,
            onChanged: widget.onChanged,
          ),
        ),
        GestureDetector(
            onTap: () => widget.onChanged(widget.value), child: widget.child),
// GestureDetector: This is a widget that detects gestures, like taps, swipes, and more.
// onTap: () => widget.onChanged(widget.value): This is the callback that is executed when a tap gesture is detected on the widget wrapped by GestureDetector. It calls the onChanged callback provided as a parameter to the RadioSelection widget with the widget.value as an argument. This effectively triggers the change associated with the selected value.
// child: widget.child: This is the child widget inside the GestureDetector and typically represents the label or content that the user can tap on.
// In summary, this command allows users to select an option by tapping either the label or the radio button, and it updates the selected value based on the user's interaction.
      ],
    );
  }
}
//

// Home2 - showDatePicker - basic

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // initial date
      firstDate: DateTime(2000), // min date
      lastDate: DateTime(2050), // max date
      // initialDatePickerMode: DatePickerMode.year, // set select day or year first, default is day
    );
    if (picked != selectedDate && picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Parse the format  "yyyy-mm-dd" to "dd-mm-yyyy"
    String formattedDate = formatDate("${selectedDate.toLocal()}".split(' ')[
        0]); // "${selectedDate.toLocal()}".split(' ')[0] return "2023-10-27 14:30:00" is array 2 element, and return first element is "2023-10-27"
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context), // Refer step 3
              child: const Text('Select date'),
            ),
          ],
        ),
      ),
    );
  }
}

// Parse the format  "yyyy-mm-dd" to "dd-mm-yyyy"
String formatDate(String inputDate) {
  // Parse the inputDate in "yyyy-mm-dd" format to a DateTime object
  DateTime date = DateTime.parse(inputDate);

  // Format the DateTime object as a string in "dd-mm-yyyy" format
  String formattedDate =
      "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString()}";

  return formattedDate;
}

// Home2A - showDatePicker - limit the number of days selected (include ipput mode) with firstDate and lastDate

class Home2A extends StatefulWidget {
  const Home2A({super.key});

  @override
  State<Home2A> createState() => _Home2AState();
}

class _Home2AState extends State<Home2A> {
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime lastAllowedDate = currentDate.add(const Duration(
        days: 30)); // Limit selection to 30 days from the current date
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // initial date
      firstDate: currentDate, // min date
      lastDate: lastAllowedDate, // max date
    );
    if (picked != selectedDate && picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Parse the format  "yyyy-mm-dd" to "dd-mm-yyyy"
    String formattedDate = formatDate("${selectedDate.toLocal()}".split(' ')[
        0]); // "${selectedDate.toLocal()}".split(' ')[0] return "2023-10-27 14:30:00" is array 2 element, and return first element is "2023-10-27"
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Picker Example 2A'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context), // Refer step 3
              child: const Text('Select date'),
            ),
          ],
        ),
      ),
    );
  }
}
// Home2A1 - showDatePicker - selectableDayPredicate: limit the number of days selected with set range day with condition predicates

class Home2A1 extends StatefulWidget {
  const Home2A1({super.key});

  @override
  State<Home2A1> createState() => _Home2A1State();
}

class _Home2A1State extends State<Home2A1> {
  DateTime selectedDate = DateTime.now();
  bool _decideWhichDayToEnable(DateTime day) {
    // range is after now - 3 day(include now day) and before now + 10 day(not include now day)
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 3))) &&
        day.isBefore(DateTime.now().add(const Duration(days: 10))))) {
      return true;
    }
    return false;
  }

  Future<void> _selectDate(BuildContext context) async {
    // final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // initial date
      firstDate: DateTime(2023), // min date
      lastDate: DateTime(2024), // max date
      selectableDayPredicate: (day) => _decideWhichDayToEnable(
          day), // set range day with condition predicates
    );
    if (picked != selectedDate && picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Parse the format  "yyyy-mm-dd" to "dd-mm-yyyy"
    String formattedDate = formatDate("${selectedDate.toLocal()}".split(' ')[
        0]); // "${selectedDate.toLocal()}".split(' ')[0] return "2023-10-27 14:30:00" is array 2 element, and return first element is "2023-10-27"
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Picker Example 2A1 - selectableDayPredicate'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context), // Refer step 3
              child: const Text('Select date'),
            ),
          ],
        ),
      ),
    );
  }
}

// Home2B - showDatePicker

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(useMaterial3: true),
//       restorationScopeId: 'app',
//       home: const DatePickerExample(restorationId: 'main'),
//     );
//   }
// }

class Home2B extends StatefulWidget {
  const Home2B({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<Home2B> createState() => _Home2BState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
/// Sử dụng RestorationMixin và các đối tượng Restorable để tự động quản lý và khôi phục trạng thái của ứng dụng sau các sự kiện như đóng ứng dụng và mở lại. restorationId được sử dụng để xác định duy nhất đối tượng trong quá trình khôi phục.
class _Home2BState extends State<Home2B> with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2022),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            _restorableDatePickerRouteFuture.present();
          },
          child: const Text('Open Date Picker'),
        ),
      ),
    );
  }
}

// Home3 - To demonstrate the `showDateRangePicker` widget in Flutter, you can create a simple Flutter app that allows the user to select a date range. Here's a basic example:

class Home3 extends StatefulWidget {
  const Home3({super.key});

  @override
  State<Home3> createState() => _Home3State();
}

class _Home3State extends State<Home3> {
  // The range includes the [start] and [end] dates. The [start] and [end] dates may be equal to indicate a date range of a single day. The [start] date must not be after the [end] date.
  DateTimeRange? selectedDateRange; //

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now().add(const Duration(days: 7))),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
    );
    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Range Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              selectedDateRange != null
                  ? 'Selected Range: ${selectedDateRange!.start} - ${selectedDateRange!.end}'
                  : 'No range selected',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _selectDateRange(context),
              child: const Text('Select Date Range'),
            ),
          ],
        ),
      ),
    );
  }
}
