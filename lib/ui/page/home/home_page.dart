import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/model/kingkong.dart';
import 'package:flutter_taobao/common/model/tab.dart';
import 'package:flutter_taobao/common/services/search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<KingKongItem> kingkongItems;

  int _diffScaleNext = 0;

  List<TabModel> _tabModels = [];

  List _hotWords = [];

  AnimationController _animationController;

  TabController _tabController;
  int _currentIndex = 0;

  Timer _countdownTimer;

  Size _sizeRed;

  String get hoursString {
    Duration duration = _animationController.duration * _animationController.value;
    return '${(duration.inHours)..toString().padLeft(2, '0')}';
  }

  String get minutesString {
    Duration duration = _animationController.duration * _animationController.value;
    return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}';
  }

  String get secondsString {
    Duration duration = _animationController.duration * _animationController.value;
    return '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }


  ScrollController _scrollController = ScrollController();
  ScrollController _scrollViewController;
  GlobalKey _keyFilter = GlobalKey();

  void initData() async {
    List querys = await getHotSugs();
    setState(() {
      _hotWords = querys;
    });
  }

  // 获取元素的位置和尺寸
  _getPositions(log, GlobalKey globalKey) {
    RenderBox renderBoxRed = globalKey.currentContext.findRenderObject();
    var positionRed = renderBoxRed.localToGlobal(Offset.zero);
    print("Position of $log: $positionRed");
  }

  _getSizes(log, GlobalKey globalKey) {
    RenderBox renderBox = globalKey.currentContext.findRenderObject();
    _sizeRed = renderBox.size;
    setState(() {});
    print('SIZE of $log: $_sizeRed');
  }

  _afterLayout(_) {
    _getPositions('_keyFilter', _keyFilter);
    _getSizes('_keyFilter', _keyFilter);
  }


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);

    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}