import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;

class Provider {
  static Database db;

  // 获取数据库中所有的表,返回的是一个Future对象
  Future<List> getTables() async {
    if(db == null) {
      return Future.value([]);
    }
    List tables = await db.rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    List<String> targetList = [];
    tables.forEach((item) {
      targetList.add(item['name']);
    });
    return targetList;
  }

  // 检查数据库中，表是否完整，在部分的Android中国，会出现表丢失的情况
  Future checkTableIsRight() async {
    List<String> expectTables = ['conversation'];

    List<String> tables = await getTables();

    for(int i = 0; i < expectTables.length; i++) {
      if(!tables.contains(expectTables[i])) {
        return false;
      }
    }
    return true;
  }

  // 初始化数据库
  Future init(bool isCreate) async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'flutter.db');
    print(path);
    try {
      db = await openDatabase(path);
    }catch(e) {
      print("Error $e");
    }
    bool tableIsRight = await this.checkTableIsRight();

    if(!tableIsRight) {
      db.close();
      await deleteDatabase(path);
      // 加载数据库数据
      ByteData data = await rootBundle.load(join('static', 'app.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await new File(path).writeAsBytes(bytes);

      db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          print('db created version is $version');
        },
        onOpen: (Database db) async {
          print('new db opened');
        }
      );
    } else {
      print('Opening existing database');
    }
  }
}