import 'package:flutter/material.dart';

// print textStyle.getParagraphStyle & textStyle.getTextStyle
void printText_Para_Style({required BuildContext context}) {
  TextStyle textStyle = DefaultTextStyle.of(context).style;
  List<String> listA = textStyle.getParagraphStyle().toString().split(',');
  List<String> listB = textStyle.getTextStyle().toString().split(',');

  print('getParagraphStyle:\n');
  for (var style in listA) {
    // Kiểm tra các thuộc tính của style để xem nó có chứa từ 'unspecified' hay không
    if (!style.contains('unspecified')) {
      print(style.toString());
    }
  }
  print('----------------');
  print('getTextStyle:\n');

  for (var style in listB) {
    // Kiểm tra các thuộc tính của style để xem nó có chứa từ 'unspecified' hay không
    if (!style.contains('unspecified')) {
      print(style.toString());
    }
  }
}

// get textStyle.getParagraphStyle & textStyle.getTextStyle
String? getText_Para_Style({required BuildContext context}) {
  TextStyle textStyle = DefaultTextStyle.of(context).style;
  List<String> listA = textStyle.getParagraphStyle().toString().split(',');
  List<String> listB = textStyle.getTextStyle().toString().split(',');

  String kq =
      'getParagraphStyle\n ${listA.where((element) => !element.contains('unspecified')).toList().toString()}';
  kq +=
      '\ngetTextStyle\n ${listB.where((element) => !element.contains('unspecified')).toList().toString()}';
  return kq;
}

void clearScreen() {
  print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
  print("-------------------------"); // just to show where the cursor is
}
