import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'bundle_dao.dart';
import 'app_dao.dart';

class MainDatabase {
  static const String dbName = 'appBundles.db';

  static Database? _db;
  static Future<Database> get db async {
    if (_db != null) return _db as Database;

    String path = join(await getDatabasesPath(), dbName);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        BundleDao.createTable(db, version);
        AppDao.createTable(db, version);
      },
    );
    return _db as Database;
  }
}
