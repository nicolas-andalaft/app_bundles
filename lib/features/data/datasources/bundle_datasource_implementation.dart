import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/errors/exceptions.dart' as exceptions;
import '../models/bundle_model.dart';
import './database/main_database.dart';
import './bundle_datasource.dart';

const String _tableName = 'bundleTable';
const String _id = 'id';
const String _name = 'name';
const String _iconCode = 'iconCode';

class BundleDatasourceImplementation implements IBundleDatasource {
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

  @override
  Future<Either<Exception, List<BundleModel>>> createBundle(
      BundleModel bundle) async {
    try {
      Database db = await MainDatabase.db;

      await db.insert(_tableName, bundle.toJson());

      return Right([]);
    } catch (Exception) {
      return Left(exceptions.DatabaseException());
    }
  }
}
