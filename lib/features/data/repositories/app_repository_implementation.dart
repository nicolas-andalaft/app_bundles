import 'package:dartz/dartz.dart';

import '../models/app_model.dart';
import '../models/bundle_model.dart';
import '../datasources/app_datasource.dart';

class AppDatasourceImplementation implements IAppDatasource {
  final IAppDatasource datasource;

  AppDatasourceImplementation(this.datasource);

  @override
  Future<Either<Exception, AppModel>> createApp(AppModel app) async {
    final result = await datasource.createApp(app);
    return result is Exception ? Left(Exception()) : Right(result as dynamic);
  }

  @override
  Future<Either<Exception, List<AppModel>>> getAppsFromBundle(
      BundleModel bundle) async {
    final result = await datasource.getAppsFromBundle(bundle);
    return result is Exception
        ? Left(Exception())
        : Right(result as List<AppModel>);
  }
}
