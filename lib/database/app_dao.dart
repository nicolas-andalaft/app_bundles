import 'package:app_bundles/database/app_database.dart';
import 'package:app_bundles/models/app.dart';
import 'package:app_bundles/models/bundle.dart';
import 'package:sqflite/sqflite.dart';

class AppDao {
  static const String _tableName = 'appTable';
  static const String _id = 'id';
  static const String _bundleId = 'bundleId';
  static const String _appId = 'appId';

  static void createTable(Database db, int version) {
    db.execute('CREATE TABLE $_tableName ('
        '$_id INTEGER PRIMARY KEY, '
        '$_bundleId INTEGER, '
        '$_appId TEXT)');
  }

  static Future<int> create(App app) async {
    Database db = await AppDatabase.db;
    return await db.insert(_tableName, _toMap(app));
  }

  static Future<int> update(App app) async {
    Database db = await AppDatabase.db;
    return await db
        .update(_tableName, _toMap(app), where: '$_id=?', whereArgs: [app.id]);
  }

  static Future<int> delete(App app) async {
    Database db = await AppDatabase.db;
    return await db.delete(_tableName, where: '$_id=?', whereArgs: [app.id]);
  }

  static Future<List<App>> readAll() async {
    Database db = await AppDatabase.db;
    return await db.query(_tableName).then((data) => _toList(data));
  }

  static Future<List<App>> readFromBundle(Bundle bundle) async {
    Database db = await AppDatabase.db;
    return await db.query(_tableName,
        where: '$_bundleId=?',
        whereArgs: [bundle.id]).then((data) => _toList(data));
  }

  static Map<String, dynamic> _toMap(App app) {
    final Map<String, dynamic> map = Map();
    map[_id] = app.id;
    map[_bundleId] = app.bundleId;
    map[_appId] = app.appId;
    return map;
  }

  static List<App> _toList(List<Map<String, dynamic>> maps) {
    final List<App> apps = List();
    for (Map<String, dynamic> map in maps) {
      App newapp = App();
      newapp.id = map[_id];
      newapp.bundleId = map[_bundleId];
      newapp.appId = map[_appId];
      apps.add(newapp);
    }
    return apps;
  }
}
