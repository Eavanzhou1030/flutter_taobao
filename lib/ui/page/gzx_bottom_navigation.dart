import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/common/utils/screen_util.dart';

class GZXBottomNavigationBar extends StatefulWidget {
  static final String sName = 'home';

  @override
  _GZXBottomNavigationBarState createState() => _GZXBottomNavigationBarState();
}

class _GZXBottomNavigationBarState extends State<GZXBottomNavigationBar> {
  final PageController topPageControl = new PageController();
  Color foreColor = GZXColors.tabBarDefaultForeColor;
  List tabItemForeColor = new List();

  final _bottomNavigationColor = Color(0xFF585858);
  Color _bottomNavigationActiveColor = Colors.blue;

  int _currentIndex = 0;
  var _controller = PageController(
    initialPage: 0
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _bottomNavigationActiveColor = Theme.of(context).primaryColor;
  }

  Widget _buildBarItemTitle(String text, int index) {
    return Text(
      text,
      style: TextStyle(
        color: _currentIndex == index ? _bottomNavigationActiveColor : _bottomNavigationColor,
        fontSize: 12
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 360)..init(context);

    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              GZXIcons.home,
              color: _currentIndex == 0 ? _bottomNavigationActiveColor : _bottomNavigationColor,
            ),
            activeIcon: Icon(
              GZXIcons.home_active,
              color: _currentIndex == 0 ? _bottomNavigationActiveColor : _bottomNavigationColor,
              size: 34,
            ),
            title: _currentIndex == 0 ? Container() : _buildBarItemTitle('首页', 0)
          ),
          BottomNavigationBarItem(
            icon: Icon(
              GZXIcons.we_tao,
              color: _currentIndex == 1 ? _bottomNavigationActiveColor : _bottomNavigationColor
            ),
            activeIcon: Icon(
              GZXIcons.we_tao_fill,
              color: _currentIndex == 1 ? _bottomNavigationActiveColor : _bottomNavigationColor,
            ),
            title: _buildBarItemTitle('微淘', 1)
          ),
          BottomNavigationBarItem(
            icon: Icon(
              GZXIcons.message,
              color: _currentIndex == 2 ? _bottomNavigationActiveColor : _bottomNavigationColor,
            ),
            activeIcon: Icon(
              GZXIcons.message_fill,
              color: _currentIndex == 2 ? _bottomNavigationActiveColor : _bottomNavigationColor,
            ),
            title: _buildBarItemTitle('消息', 2)
          ),
          BottomNavigationBarItem(
            icon: Icon(
              GZXIcons.cart,
              color: _currentIndex == 3 ? _bottomNavigationActiveColor : _bottomNavigationColor,
            ),
            activeIcon: Icon(
              GZXIcons.cart_fill,
              color: _currentIndex == 3 ? _bottomNavigationActiveColor : _bottomNavigationColor,
            ),
            title: _buildBarItemTitle('购物车', 3)
          ),
          BottomNavigationBarItem(
            icon: Icon(
              GZXIcons.my,
              color: _currentIndex == 4 ? _bottomNavigationActiveColor : _bottomNavigationColor,
            ),
            activeIcon: Icon(
              GZXIcons.my_fill,
              color: _currentIndex == 4 ? _bottomNavigationActiveColor : _bottomNavigationColor,
            ),
            title: _buildBarItemTitle('我的淘宝', 4)
          ),
        ],
      ),
    );
  }
}