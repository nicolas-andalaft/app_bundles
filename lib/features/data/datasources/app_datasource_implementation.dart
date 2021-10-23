import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/errors/exceptions.dart' as exceptions;
import '../models/app_model.dart';
import '../models/bundle_model.dart';
import './database/main_database.dart';
import './app_datasource.dart';

const String _tableName = 'appTable';
const String _id = 'id';
const String _bundleId = 'bundleId';
const String _appId = 'appId';
const String _title = 'title';
const String _iconUrl = 'iconUrl';
const String _iconImage = 'iconImage';
const String _storeUrl = 'storeUrl';

class AppDatasourceImplementation implements IAppDatasource {
  static void createTable(Database db, int version) {
    db.execute('CREATE TABLE $_tableName ('
        '$_id INTEGER PRIMARY KEY, '
        '$_bundleId INTEGER, '
        '$_appId INTEGER, '
        '$_title TEXT, '
        '$_iconUrl TEXT, '
        '$_iconImage TEXT, '
        '$_storeUrl TEXT)');
  }

  @override
  Future<Either<Exception, AppModel>> createApp(AppModel app) async {
    try {
      Database db = await MainDatabase.db;

      await db.insert(_tableName, app.toJson());

      return Right(app);
    } catch (Exception) {
      return Left(exceptions.DatabaseException());
    }
  }

  @override
  Future<Either<Exception, List<AppModel>>> getAppsFromBundle(
      BundleModel bundle) async {
    try {
      Database db = await MainDatabase.db;

      await db
          .query(_tableName, where: '$_bundleId = ?', whereArgs: [bundle.id]);

      return Right([]);
    } catch (Exception) {
      return Left(exceptions.DatabaseException());
    }
  }
}
