import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/errors/exceptions.dart' as exceptions;
import '../models/bundle_model.dart';
import './database/main_database.dart';
import './bundle_datasource.dart';

class BundleDatasourceImplementation implements IBundleDatasource {
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

  @override
  Future<Either<Exception, List<BundleModel>>> getAllBundles() async {
    try {
      Database db = await MainDatabase.db;
      final result = await db.query(_tableName);
      final bundles = result.map((map) => BundleModel.fromJson(map)).toList();
      return Right(bundles);
    } catch (Exception) {
      return Left(exceptions.DatabaseException());
    }
  }
}
