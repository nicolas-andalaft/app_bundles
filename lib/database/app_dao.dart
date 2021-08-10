import 'package:app_bundles/database/main_database.dart';
import 'package:app_bundles/models/app.dart';
import 'package:app_bundles/models/bundle.dart';
import 'package:sqflite/sqflite.dart';

class AppDao {
  static const String _tableName = 'appTable';
  static const String _id = 'id';
  static const String _bundleId = 'bundleId';
  static const String _appId = 'appId';
  static const String _title = 'title';
  static const String _iconUrl = 'iconUrl';
  static const String _storeUrl = 'storeUrl';

  static void createTable(Database db, int version) {
    db.execute('CREATE TABLE $_tableName ('
        '$_id INTEGER PRIMARY KEY, '
        '$_bundleId INTEGER, '
        '$_appId TEXT, '
        '$_title TEXT, '
        '$_iconUrl TEXT, '
        '$_storeUrl TEXT)');
  }

  static Future<int> create(App app) async {
    Database db = await MainDatabase.db;
    return await db.insert(_tableName, _toMap(app));
  }

  static Future<dynamic> createAll(List<App> appList) async {
    if (appList.isEmpty) return;

    Database db = await MainDatabase.db;
    Batch batch = db.batch();

    for (App app in appList)
      batch.insert(
        _tableName,
        {
          _appId: app.appId,
          _bundleId: app.bundleId,
          _title: app.title,
          _iconUrl: app.iconUrl,
        },
      );

    return await batch.commit();
  }

  static Future<int> update(App app) async {
    Database db = await MainDatabase.db;
    return await db
        .update(_tableName, _toMap(app), where: '$_id=?', whereArgs: [app.id]);
  }

  static Future<int> delete(App app) async {
    Database db = await MainDatabase.db;
    return await db.delete(_tableName, where: '$_id=?', whereArgs: [app.id]);
  }

  static Future<List<App>> readAll() async {
    Database db = await MainDatabase.db;
    return await db.query(_tableName).then((data) => _toList(data));
  }

  static Future<List<App>> readFromBundle(Bundle bundle) async {
    Database db = await MainDatabase.db;
    return await db.query(_tableName,
        where: '$_bundleId=?',
        whereArgs: [bundle.id]).then((data) => _toList(data));
  }

  static Future<int> countApps(Bundle bundle) async {
    Database db = await MainDatabase.db;
    return await db.query(_tableName,
        where: '$_bundleId=?',
        whereArgs: [bundle.id]).then((value) => value.length);
  }

  static Map<String, Object?> _toMap(App app) {
    Map<String, Object?> map = {}
      ..[_id] = app.id
      ..[_bundleId] = app.bundleId
      ..[_appId] = app.appId
      ..[_title] = app.title
      ..[_iconUrl] = app.iconUrl
      ..[_storeUrl] = app.storeUrl;

    return map;
  }

  static List<App> _toList(List<Map<String, dynamic>> maps) {
    final List<App> apps = [];
    for (Map<String, dynamic> map in maps) {
      App newapp = App(
        id: map[_id] as int?,
        bundleId: map[_bundleId] as int?,
        appId: map[_appId] as String?,
        title: map[_title] as String?,
        iconUrl: map[_iconUrl] as String?,
        storeUrl: map[_storeUrl] as String?,
      );
      apps.add(newapp);
    }
    return apps;
  }
}
