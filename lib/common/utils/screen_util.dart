import 'package:flutter/material.dart';

class ScreenUtil {
  static ScreenUtil instance = ScreenUtil();

  // 设计稿设备的尺寸修改
  int _desginWidth;
  int _desginHeight;

  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;
  static double _bottomBarHeight;
  static double _textScaleFactor;


  ScreenUtil({int width, int height}) {
    _desginHeight = height;
    _desginWidth = width;
  }

  static ScreenUtil getInstance() {
    return instance;
  }

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  static MediaQueryData get mediaQueryData => _mediaQueryData;

  // 每个逻辑像素的字体像素数，字体的缩放比例
  static double get textScaleFactory => _textScaleFactor;

  // 设备像素密度
  static double get pixelRatio =>_pixelRatio;

  // 当前的设备宽度 dp
  static double get screenWidthDp => _screenWidth;

  // 当前的设备高度 dp
  static double get screenHeightDp => _screenHeight;

  // 当前的设备宽度 px
  static double get screenWidth => _screenWidth;

  // 当前的设备高度 px
  static double get screenHeight => _screenHeight;

  // 状态栏高度，刘海屏会更高
  static double get statusBarHeight => _statusBarHeight;

  // 底部安全区域
  static double get bottomBarHeight => _bottomBarHeight;

  // 实际的Dp与设计稿Px的比例
  get scaleWidth => _screenWidth / instance._desginWidth;

  get scaleHeight => _screenHeight / instance._desginHeight;

  // 根据设计稿的设备适配
  // 高度也根据这个来做适配可以保证不变形
  setWidth(int width) => width * scaleWidth;
  L(double width) => width * scaleWidth;

  setHeight(int height) => height * scaleHeight;

  setSp(int fontSize, [allowFontScaling = true]) => allowFontScaling ? setWidth(fontSize) * _textScaleFactor : setWidth(fontSize);
}