import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:flutter/cupertino.dart';

class MyTimeRangePicker extends StatelessWidget {
  const MyTimeRangePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TimeRangePicker2A(),
    );
  }
}

/// https://pub.dev/packages/time_range_picker
/// Xem diến giải các tham số tại link trang chủ trên luôn
/// Demo 01
class TimeRangePicker1 extends StatelessWidget {
  const TimeRangePicker1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              TimeRange? result = await showTimeRangePicker(
                context: context,
              );
              // Kiểm tra xem người dùng đã chọn thời gian hay không
              if (result != null) {
                debugPrint("Selected time range: $result");
              } else {
                // Người dùng đã nhấn nút "Close" hoặc hủy bỏ, không chọn thời gian nào
                debugPrint("No time range selected");
              }
            },
            child: const Text("Open Time Range Picker"),
          ),
        ));
  }
}

/// Demo 02
class TimeRangePicker2 extends StatefulWidget {
  const TimeRangePicker2({super.key});

  @override
  State<TimeRangePicker2> createState() => _TimeRangePicker2State();
}

class _TimeRangePicker2State extends State<TimeRangePicker2> {
  TimeRange? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () async {
              TimeRange? kq = await showTimeRangePicker(
                start: const TimeOfDay(hour: 8, minute: 0),
                end: const TimeOfDay(hour: 17, minute: 0),
                // disabledTime ko cho phép chọn TimeRange đi xuyên qua nó. Vd: disabledTime từ 12h đến 13h thì ko thể chọn TimeRange với startTime trước 12h và endTime sau 13h
                disabledTime: TimeRange(
                    startTime: const TimeOfDay(hour: 12, minute: 0),
                    endTime: const TimeOfDay(hour: 13, minute: 0)),
                context: context,
              );
              // Kiểm tra xem người dùng đã chọn thời gian hay không
              if (kq != null) {
                setState(() {
                  result = kq;
                });
              }
            },
            child: const Text("Open Time Range Picker"),
          ),
          const SizedBox(height: 20.0),
          Text(
            result != null ? 'Selected Range: $result' : 'No range selected',
            style: const TextStyle(fontSize: 20),
          ),
        ])));
  }
}

/// Demo 2A - Set ticks: 12 & labels xoay theo độ clockRotation(labels sẽ luôn phù hợp với mốc 0h)
class TimeRangePicker2A extends StatefulWidget {
  const TimeRangePicker2A({super.key});

  @override
  State<TimeRangePicker2A> createState() => _TimeRangePicker2AState();
}

class _TimeRangePicker2AState extends State<TimeRangePicker2A> {
  TimeRange? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () async {
              TimeRange? kq = await showTimeRangePicker(
                start: const TimeOfDay(hour: 8, minute: 0),
                end: const TimeOfDay(hour: 17, minute: 0),
                // disabledTime ko cho phép chọn TimeRange đi xuyên qua nó. Vd: disabledTime từ 12h đến 13h thì ko thể chọn TimeRange với startTime trước 12h và endTime sau 13h
                // disabledTime: TimeRange(
                //     startTime: const TimeOfDay(hour: 12, minute: 0),
                //     endTime: const TimeOfDay(hour: 13, minute: 0)),
                // clockRotation:0(default) - labels list sẽ map với ticks: labels list từ trên xuống, ticks 0h đầu tiên tại đáy đồng hồ.
                // clockRotation:180 - ticks 0h đầu tiên xoay lên đỉnh đồng hồ
                clockRotation: 180,
                ticks: 12,
                ticksColor: Colors.green,
                ticksLength: 20,
                ticksOffset: 5,
                labels: [
                  ClockLabel.fromTime(
                      time: const TimeOfDay(hour: 0, minute: 0), text: "0h"),
                  ClockLabel.fromTime(
                      time: const TimeOfDay(hour: 3, minute: 0), text: "3h"),
                  ClockLabel.fromTime(
                      time: const TimeOfDay(hour: 6, minute: 0), text: "6h"),
                  ClockLabel.fromTime(
                      time: const TimeOfDay(hour: 9, minute: 0), text: "9h"),
                  ClockLabel.fromTime(
                      time: const TimeOfDay(hour: 12, minute: 0), text: "12h"),
                  ClockLabel.fromTime(
                      time: const TimeOfDay(hour: 15, minute: 0), text: "15h"),
                  ClockLabel.fromTime(
                      time: const TimeOfDay(hour: 18, minute: 0), text: "18h"),
                  ClockLabel.fromTime(
                      time: const TimeOfDay(hour: 21, minute: 0), text: "21h"),
                  ClockLabel.fromTime(
                      time: const TimeOfDay(hour: 24, minute: 0), text: "0h")
                ],
                context: context,
              );
              // Kiểm tra xem người dùng đã chọn thời gian hay không
              if (kq != null) {
                setState(() {
                  result = kq;
                });
              }
            },
            child: const Text("Open Time Range Picker"),
          ),
          const SizedBox(height: 20.0),
          Text(
            result != null ? 'Selected Range: $result' : 'No range selected',
            style: const TextStyle(fontSize: 20),
          ),
        ])));
  }
}
// Demo 03

class TimeRangePicker3 extends StatefulWidget {
  const TimeRangePicker3({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<TimeRangePicker3> createState() => _TimeRangePicker3State();
}

class _TimeRangePicker3State extends State<TimeRangePicker3> {
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime =
      TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 3)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(children: [
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
            );

            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("Pure"),
        ),
        ElevatedButton(
          onPressed: () {
            showTimeRangePicker(
              context: context,
              start: const TimeOfDay(hour: 22, minute: 9),
              onStartChange: (start) {
                if (kDebugMode) {
                  print("start time $start");
                }
              },
              onEndChange: (end) {
                if (kDebugMode) {
                  print("end time $end");
                }
              },
              interval: const Duration(hours: 1),
              minDuration: const Duration(hours: 1),
              use24HourFormat: false,
              padding: 30,
              strokeWidth: 20, // độ dày viền clock
              handlerRadius: 10, // bán kính icon change value
              strokeColor: const Color.fromARGB(
                  255, 140, 0, 255), // color of range time selection
              handlerColor: Colors.orange[700], // color of icon handler
              selectedColor: const Color.fromARGB(
                  255, 255, 7, 69), // color of icon handler selected
              backgroundColor: Colors.black.withOpacity(0.3),
              ticks: 12,
              ticksColor: Colors.white,
              snap: true,
              labels: [
                "12 am",
                "3 am",
                "6 am",
                "9 am",
                "12 pm",
                "3 pm",
                "6 pm",
                "9 pm"
              ].asMap().entries.map((e) {
                return ClockLabel.fromIndex(
                    idx: e.key, length: 8, text: e.value);
              }).toList(),
              labelOffset: -30,
              labelStyle: const TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
              timeTextStyle: const TextStyle(
                  // timeTextStyle - text [_startTime] and [_endTime]
                  color: Colors.orange,
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
              activeTimeTextStyle: const TextStyle(
                  // activeTimeTextStyle - text [_startTime] and [_endTime] nhưng đang được change value
                  color: Color.fromARGB(255, 47, 255, 0),
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            );
          },
          child: const Text("Interval"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
                context: context,
                start: const TimeOfDay(hour: 9, minute: 0),
                end: const TimeOfDay(hour: 12, minute: 0),
                disabledTime: TimeRange(
                    startTime: const TimeOfDay(hour: 22, minute: 0),
                    endTime: const TimeOfDay(hour: 5, minute: 0)),
                disabledColor: Colors.red.withOpacity(0.5),
                strokeWidth: 4,
                ticks: 24,
                ticksOffset: -7,
                ticksLength: 15,
                ticksColor: Colors.grey,
                labels: [
                  "12 am",
                  "3 am",
                  "6 am",
                  "9 am",
                  "12 pm",
                  "3 pm",
                  "6 pm",
                  "9 pm"
                ].asMap().entries.map((e) {
                  return ClockLabel.fromIndex(
                      idx: e.key, length: 8, text: e.value);
                }).toList(),
                labelOffset: 35,
                rotateLabels:
                    false, // rotateLabels: true - label rotate theo đường kính clock; false - label luôn hiển thị ngang
                padding: 60);

            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("Disabled Times"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
              paintingStyle: PaintingStyle.fill,
              backgroundColor: Colors.grey.withOpacity(0.2),
              labels: [
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 7, minute: 0),
                    text: "Start Work"),
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 18, minute: 0), text: "Go Home")
              ],
              start: const TimeOfDay(hour: 10, minute: 0),
              end: const TimeOfDay(hour: 13, minute: 0),
              ticks: 8,
              strokeColor: Theme.of(context)
                  .primaryColor
                  .withOpacity(0.5), // color of khu vực chọn
              ticksColor: Theme.of(context).primaryColor,
              labelOffset: 15,
              padding: 60,
              disabledTime: TimeRange(
                  startTime: const TimeOfDay(hour: 18, minute: 0),
                  endTime: const TimeOfDay(hour: 7, minute: 0)),
              disabledColor: Colors.red.withOpacity(0.5),
            );

            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("Filled Style"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
              strokeColor: Colors.teal,
              handlerColor: Colors.teal[200],
              selectedColor: Colors.tealAccent,
              strokeWidth: 16,
              handlerRadius: 18,
              backgroundWidget: Image.asset(
                // set background image
                "assets/images/day-night.png",
                height: 300,
                width: 300,
              ),
              labels: [
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 6, minute: 0), text: "Get up"),
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 9, minute: 0),
                    text: "Coffee time"),
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 15, minute: 0),
                    text: "Afternoon"),
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 18, minute: 0),
                    text: "Time for a beer"),
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 22, minute: 0),
                    text: "Go to Sleep"),
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 2, minute: 0),
                    text: "Go for a pee"),
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 12, minute: 0),
                    text: "Lunchtime!")
              ],
              ticks: 12,
              ticksColor: Colors.black,
              labelOffset: 40,
              padding: 55,
              labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
            );

            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("Background Widget"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
              strokeWidth: 4,
              ticks: 24,
              ticksOffset: 2,
              ticksLength: 8,
              handlerRadius: 8,
              ticksColor: Colors.grey,
              rotateLabels: false,
              labels: [
                "24 h",
                "3 h",
                "6 h",
                "9 h",
                "12 h",
                "15 h",
                "18 h",
                "21 h"
              ].asMap().entries.map((e) {
                return ClockLabel.fromIndex(
                    idx: e.key, length: 8, text: e.value);
              }).toList(),
              labelOffset: 30,
              padding: 55,
              labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
              start: const TimeOfDay(hour: 12, minute: 0),
              end: const TimeOfDay(hour: 15, minute: 0),
              disabledTime: TimeRange(
                  startTime: const TimeOfDay(hour: 6, minute: 0),
                  endTime: const TimeOfDay(hour: 10, minute: 0)),
              // clockRotation:0(default) - labels list sẽ map với ticks: labels list từ trên xuống, ticks 0h đầu tiên tại đáy đồng hồ.
              // clockRotation:180 - ticks 0h đầu tiên xoay lên đỉnh đồng hồ
              clockRotation: 0.0,
            );

            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("Rotated Clock"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
              rotateLabels: false,
              ticks: 12,
              ticksColor: Colors.grey,
              ticksOffset: -12,
              labels: [
                "24 h",
                "3 h",
                "6 h",
                "9 h",
                "12 h",
                "15 h",
                "18 h",
                "21 h"
              ].asMap().entries.map((e) {
                return ClockLabel.fromIndex(
                    idx: e.key, length: 8, text: e.value);
              }).toList(),
              labelOffset: -30,
              padding: 55,
              start: const TimeOfDay(hour: 12, minute: 0),
              end: const TimeOfDay(hour: 18, minute: 0),
              disabledTime: TimeRange(
                startTime: const TimeOfDay(hour: 4, minute: 0),
                endTime: const TimeOfDay(hour: 10, minute: 0),
              ),
              maxDuration: const Duration(hours: 6),
            );

            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("Max duration"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
              rotateLabels: false,
              ticks: 12,
              ticksColor: Colors.grey,
              ticksOffset: -12,
              labels: [
                "24 h",
                "3 h",
                "6 h",
                "9 h",
                "12 h",
                "15 h",
                "18 h",
                "21 h"
              ].asMap().entries.map((e) {
                return ClockLabel.fromIndex(
                    idx: e.key, length: 8, text: e.value);
              }).toList(),
              labelOffset: -30,
              padding: 55,
              start: const TimeOfDay(hour: 12, minute: 0),
              end: const TimeOfDay(hour: 18, minute: 0),
              disabledTime: TimeRange(
                startTime: const TimeOfDay(hour: 4, minute: 0),
                endTime: const TimeOfDay(hour: 10, minute: 0),
              ),
              minDuration: const Duration(hours: 3),
            );
            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("Min duration"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
                context: context, barrierDismissible: false);

            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("No barrier dismissable"),
        ),
        const Divider(),
        Text(
          'As a regular widget:',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Start: ${_startTime.format(context)}"),
            Text("End: ${_endTime.format(context)}"),
          ],
        ),
        SizedBox(
          height: 300,
          child: TimeRangePicker(
            hideButtons: true, //  show/hide 2 buttons Cancel and OK
            hideTimes:
                true, // show/hide time texts From [_startTime] and To [_endTime]
            paintingStyle: PaintingStyle.fill, // fill time range selected
            backgroundColor: Colors.grey.withOpacity(0.2),
            labels: [
              // set labels for time ranges
              ClockLabel.fromTime(
                  time: const TimeOfDay(hour: 7, minute: 0),
                  text: "Start Work"),
              ClockLabel.fromTime(
                  time: const TimeOfDay(hour: 18, minute: 0), text: "Go Home")
            ],
            start: _startTime,
            end: _endTime,
            ticks: 12, // vạch khoảng cách cho clock
            ticksOffset: -5, // position of the ticks within đường kính clock
            strokeColor: Theme.of(context).primaryColor.withOpacity(0.5),
            ticksColor: Theme.of(context).primaryColorDark,
            labelOffset: 20, // spacing giữa label and đường kính clock
            padding: 30,
            onStartChange: (start) {
              // event khi change start value
              setState(() {
                _startTime = start;
              });
            },
            onEndChange: (end) {
              // event khi change end value
              setState(() {
                _endTime = end;
              });
            },
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showDialog(
              context: context,
              builder: (BuildContext context) {
                TimeOfDay startTime = TimeOfDay.now();
                TimeOfDay endTime = TimeOfDay.now();
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Choose a nice timeframe"),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 450,
                    child: TimeRangePicker(
                      hideButtons: true,
                      onStartChange: (start) {
                        setState(() {
                          startTime = start;
                        });
                      },
                      onEndChange: (end) {
                        setState(() {
                          endTime = end;
                        });
                      },
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        child: const Text('My custom cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    TextButton(
                      child: const Text('My custom ok'),
                      onPressed: () {
                        Navigator.of(context).pop(
                            TimeRange(startTime: startTime, endTime: endTime));
                      },
                    ),
                  ],
                );
              },
            );

            if (kDebugMode) {
              print(result.toString());
            }
          },
          child: const Text("Custom Dialog"),
        ),
        ElevatedButton(
            onPressed: () async {
              TimeRange? result = await showCupertinoDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  TimeOfDay startTime = TimeOfDay.now();
                  TimeOfDay endTime = TimeOfDay.now();
                  return CupertinoAlertDialog(
                    content: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 340,
                        child: Column(
                          children: [
                            TimeRangePicker(
                              padding: 22,
                              hideButtons: true,
                              handlerRadius: 8,
                              strokeWidth: 4,
                              ticks: 12,
                              activeTimeTextStyle: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 22,
                                  color: Colors.white),
                              timeTextStyle: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 22,
                                  color: Colors.white70),
                              onStartChange: (start) {
                                setState(() {
                                  startTime = start;
                                });
                              },
                              onEndChange: (end) {
                                setState(() {
                                  endTime = end;
                                });
                              },
                            ),
                          ],
                        )),
                    actions: <Widget>[
                      CupertinoDialogAction(
                          isDestructiveAction: true,
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      CupertinoDialogAction(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop(
                            TimeRange(startTime: startTime, endTime: endTime),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
              if (kDebugMode) {
                print(result.toString());
              }
            },
            child: const Text("Cupertino style"))
      ]),
    );
  }
}
