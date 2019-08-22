import 'package:flutter/material.dart';

class ScreenUtil {
  static ScreenUtil instance = new ScreenUtil();

  // 设计稿的设备尺寸修改
  int _designWidth;
  int _designHeight;

  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;

  static double _bottomBarHeight;
  static double _textScaleFactor;

  ScreenUtil({int width, int height}) {
    _designWidth = width;
    _designHeight = height;
  }

  static ScreenUtil getInstance() {
    return instance;
  }

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context); // 获取上下文的媒体元素
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio; // 每个逻辑像素的设备像素数
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor; // 每个逻辑像素的字体像素数
  }

  // 类中暴露出私有属性
  static MediaQueryData get mediaQueryData => _mediaQueryData;

  // 每个逻辑像素的字体像素数，字体的缩放比
  static double get textScaleFactor => _textScaleFactor;

  // 设备的像素密度
  static double get pixelRatio => _pixelRatio;

  // 当前设备的宽度 dp
  static double get screenWidthDp => _screenWidth;

  // 当前设备的高度 dp
  static double get screenHeightDp => _screenHeight;

  // 当前设备的宽度 px
  static double get screenWidth => _screenWidth;

  // 当前设备的高度 px
  static double get screenHeight => _screenHeight;

  // 设备状态栏的高度，刘海屏会更高
  static double get statusBarHeight => _statusBarHeight;

  // 设备底部安全区域的高度
  static double get bottomBarHeight => _bottomBarHeight;

  // 实际的dp与设计稿之间的比例
  get scaleWidth => _screenWidth / instance._designWidth;
  get scaleHeight => _screenHeight / instance._designHeight;

  // 根据设计稿的设备宽度适配
  setWidth(int width) => width * scaleWidth;

  L(double width) => width * scaleWidth;

  setHeight(int height) => height * scaleHeight;

  // 字体大小适配方法
  setSp(int fontSize, [allowFontScaling = true]) => allowFontScaling
    ? setWidth(fontSize) * _textScaleFactor
    : setWidth(fontSize);
}