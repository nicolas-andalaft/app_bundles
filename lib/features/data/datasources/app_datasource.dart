import 'package:dartz/dartz.dart';

import '../models/app_model.dart';
import '../models/bundle_model.dart';

abstract class IAppDatasource {
  Future<Either<Exception, List<AppModel>>> getAppsFromBundle(
      BundleModel bundle);
  Future<Either<Exception, AppModel>> createApp(AppModel app);
}
