import 'package:app_bundles/features/data/datasources/bundle_datasource.dart';
import 'package:app_bundles/features/data/datasources/bundle_datasource_implementation.dart';
import 'package:app_bundles/features/data/repositories/bundle_repository_implementation.dart';
import 'package:app_bundles/features/domain/repositories/bundle_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecases/usecase.dart';
import '../../../core/errors/failure.dart';
import '../../domain/usecases/get_all_bundles_usecase.dart';
import '../../domain/entities/bundle_entity.dart';
import './bundle_event.dart';
import './bundle_state.dart';

class BundleBloc extends Bloc<BundleEvent, BundleState> {
  late IBundleDatasource _datasource;
  late IBundleRepository _repository;
  late GetAllBundlesUsecase _getAllBundles;

  BundleBloc() : super(Empty()) {
    _datasource = BundleDatasourceImplementation();
    _repository = BundleRepositoryImplementation(_datasource);
    _getAllBundles = GetAllBundlesUsecase(_repository);
  }

  @override
  Stream<BundleState> mapEventToState(BundleEvent event) async* {
    yield Loading();

    if (event is GetAllBundles) {
      final failureOrData = await _getAllBundles.call(NoParams());

      yield* _eitherFailureOrData(failureOrData);
    }
  }

  Stream<BundleState> _eitherFailureOrData(
      Either<Failure, List<BundleEntity>> failureOrData) async* {
    yield failureOrData.fold((failure) => Error(''), (data) => Loaded(data));
  }
}
