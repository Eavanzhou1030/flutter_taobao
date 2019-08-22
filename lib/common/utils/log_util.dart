class LogUtil {
  static const String _TAG_DEF = '###LogUtil####';

  static bool debuggable = true; // 是否是debug模式， true： log v不输出
  static String TAG = _TAG_DEF;

  // 使用默认值输入
  static void init({bool isDebug: false, String tag: _TAG_DEF}) {
    debuggable = isDebug;
    TAG = tag;
  }

  static void e(Object object, {String tag}) {
    _printLog(tag, '   e    ',  object);
  }

  static void v(Object object, {String tag}) {
    _printLog(tag, '   v   ', object);
  }

  static void _printLog(String tag, String stag, Object object) {
    StringBuffer sb = new StringBuffer();
    sb.write((tag == null || tag.isEmpty) ? TAG : tag);
    sb.write(stag);
    sb.write(object);
    print(sb.toString());
  }

}