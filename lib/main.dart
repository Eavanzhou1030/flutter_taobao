import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
// import 'package:flutter_taobao/ui/page/test/SliverWithTabBar.dart';
import 'package:flutter_taobao/ui/page/test/gzx_dropdown_menu_test_page.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter淘宝App',
      home: GZXDropDownMenuPage(),
    );
  }
}