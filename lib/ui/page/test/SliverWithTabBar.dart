import 'package:flutter/material.dart';
import 'dart:math' as math;

class SliverWithTabBar extends StatefulWidget {
  @override
  _SliverWithTabBarState createState() => _SliverWithTabBarState();
}

// AnimationController生成的时候需要传递vynsc参数，vynsc会绑定一个可视的widget，所以当widget不显示时，
// 动画定时器将会暂停，当widget再次显示时，动画定时器重新恢复执行，这样就可以避免动画相关UI不在当前屏幕时消耗资源。 如果要使用自定义的State对象作为vsync时，请包含TickerProviderStateMixin

class _SliverWithTabBarState extends State<SliverWithTabBar>  with SingleTickerProviderStateMixin{
  TabController controller;
  var _tabs = ['1', '2', '3'];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              primary: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: ListView(
                  children: <Widget>[
                    Container(
                      height: 200.0,
                      width: double.infinity,
                      color: Colors.grey,
                      child: FlutterLogo(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Bussiness Office',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Open now\nStreet Address, 299\nCity, State',
                        style: TextStyle(fontSize: 15.0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(Icons.share),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Icon(Icons.favorite),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              expandedHeight: 380.0,
              bottom: TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                tabs: <Widget>[
                  Tab(text: 'POST'),
                  Tab(text: 'DETAILS'),
                  Tab(text: 'FOLLOWERS'),
                ],
                controller: controller,
              ),
            ),
          ];
        },
        body: ListView.builder(
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: index % 2 == 0 ? Colors.blue : Colors.green,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 100.0,
                child: Text(
                  'Flutter is awasome',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}