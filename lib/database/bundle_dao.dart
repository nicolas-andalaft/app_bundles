import 'package:app_bundles/database/app_database.dart';
import 'package:app_bundles/models/bundle.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class BundleDao {
  static const String _tableName = 'bundleTable';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _iconCode = 'iconCode';

  static void createTable(Database db, int version) {
    db.execute('CREATE TABLE $_tableName ('
        '$_id INTEGER PRIMARY KEY, '
        '$_name TEXT, '
        '$_iconCode Integer)');
  }

  static Future<int> create(Bundle bundle) async {
    Database db = await AppDatabase.db;
    return await db.insert(_tableName, _toMap(bundle));
  }

  static Future<int> update(Bundle bundle) async {
    Database db = await AppDatabase.db;
    return await db.update(_tableName, _toMap(bundle),
        where: '$_id=?', whereArgs: [bundle.id]);
  }

  static Future<int> delete(Bundle bundle) async {
    Database db = await AppDatabase.db;
    return await db.delete(_tableName, where: '$_id=?', whereArgs: [bundle.id]);
  }

  static Future<List<Bundle>> readAll() async {
    Database db = await AppDatabase.db;
    return await db.query(_tableName).then((data) => _toList(data));
  }

  static Map<String, dynamic> _toMap(Bundle bundle) {
    final Map<String, dynamic> map = Map();
    map[_id] = bundle.id;
    map[_name] = bundle.name;
    map[_iconCode] = bundle.icon!.codePoint;
    return map;
  }

  static List<Bundle> _toList(List<Map<String, dynamic>> maps) {
    final List<Bundle> bundles = [];
    for (Map<String, dynamic> map in maps) {
      Bundle newbundle = Bundle()
        ..id = map[_id]
        ..name = map[_name]
        ..icon = IconData(
          map[_iconCode],
          fontFamily: 'MaterialIcons',
        );
      bundles.add(newbundle);
    }
    return bundles;
  }
}
