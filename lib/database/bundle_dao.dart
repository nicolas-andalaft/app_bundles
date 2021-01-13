import 'package:app_bundles/database/app_database.dart';
import 'package:app_bundles/models/bundle.dart';
import 'package:sqflite/sqflite.dart';

class BundleDao {
  static const String _tableName = 'bundleTable';
  static const String _id = 'id';
  static const String _name = 'name';

  static void createTable(Database db, int version) {
    db.execute('CREATE TABLE $_tableName ('
        '$_id INTEGER PRIMARY KEY, '
        '$_name TEXT)');
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
    return map;
  }

  static List<Bundle> _toList(List<Map<String, dynamic>> maps) {
    final List<Bundle> bundles = List();
    for (Map<String, dynamic> map in maps) {
      Bundle newbundle = Bundle();
      newbundle.id = map[_id];
      newbundle.name = map[_name];
      bundles.add(newbundle);
    }
    return bundles;
  }
}
