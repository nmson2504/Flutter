import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'inheritedwidget.dart';
import 'provider_demo.dart';
import 'provider_demo0.dart';
import 'provider_demo2.dart';
import 'provider_demo1A.dart';
import 'provider_demo1B.dart';
import 'provider_demo1C.dart';
import 'inheritedmodel.dart';

void main() {
  runApp(const MyAppProvider1B());
  // runApp(const MyAppInheritedModel());
// run Provider
  /*  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp01(),
    ),
  ); */
/*  cũng có thể đặt ChangeNotifierProvider trong  Widget build, lúc này ChangeNotifierProvider có child là MaterialApp */
}
