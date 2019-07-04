import './provider.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class BaseModel {
  Database db;
  final String table = '';
  var query;

  BaseModel(this.db) {
    query =  this.db;
  }
}

class Sql extends BaseModel {
  final String tableName;

  Sql.setTable(String name)
    : tableName = name,
    super(Provider.db);

  Future<List> get() async {
    return await this.query(tableName);
  }

  Future<List> getAll() async {
    var result = await this.query(tableName);
    return result.toList();
  }

  String getTableName() {
    return tableName;
  }

  Future<int> delete(String key, String value) async {
    return await this.db.delete(tableName, where: '$key = ?', whereArgs: [value]);
  }

  Future<int> clearTable(String tableName) async{
    return await this.db.delete(tableName);
  }

  Future<List> getByCondidtion({Map<dynamic, dynamic> conditions}) async {
    if(conditions == null || conditions.isEmpty) {
      return this.get();
    }
    String stringConditions = '';

    int index = 0;
    conditions.forEach((key, value) {
      if(value == null) {
        return ;
      }

      if(value.runtimeType == String) {
        stringConditions = '$stringConditions $key = "$value"';
      }

      if(value.runtimeType == int) {
        stringConditions = '$stringConditions $key = $value';
      }

      if(index >= 0 && index < conditions.length - 1) {
        stringConditions = '$stringConditions and';
      }
      index++;
    });
    return await this.query(tableName, where: stringConditions);
  }

  // 搜索
  Future<List> search({Map<String, dynamic> conditions, String mods = 'Or'}) async {
    if(conditions == null || conditions.isEmpty) {
      return this.get();
    }

    String stringConditions = '';
    int index = 0;

    conditions.forEach((key, value) {
      if(value == null) {
        return ;
      }

      if(value.runtimeType == String) {
        stringConditions = '$stringConditions $key like "%$value%"';
      }
      if(value.runtimeType == int) {
        stringConditions = '$stringConditions $key = "%$value%"';
      }

      if(index > 0 && index < conditions.length - 1) {
        stringConditions = '$stringConditions $mods';
      }
      index++;
    });
    return await this.query(tableName, where: stringConditions);
  }
}