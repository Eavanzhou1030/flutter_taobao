import 'package:http/http.dart' as http;
import 'dart:convert';

Future get(String url) async {
  var res = await http.get(url);
  if(res.statusCode == 200) {
    var body = res.body;
    return jsonDecode(body); // 将json转化为map
  } else {
    return null;
  }
}

Future getHotSugs() async {
  var url = 'https://suggest.taobao.com/sug?area=sug_hot&wireless=2';
  var res = await http.get(url);
  if(res.statusCode == 200) {
    List querys = jsonDecode(res.body)['querys'] as List;
    return querys;
  } else {
    return [];
  }
}