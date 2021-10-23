import 'package:app_bundles/features/domain/entities/bundle_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import './../../data/repositories/bundle_repository_implementation.dart';
import '../../../core/usecases/usecase.dart';
import '../../../core/errors/failure.dart';
import '../../data/datasources/bundle_datasource_implementation.dart';
import '../../domain/usecases/create_bundle_usecase.dart';
import '../../domain/usecases/get_all_bundles_usecase.dart';
import '../../data/repositories/bundle_repository_implementation.dart';
import '../../data/datasources/bundle_datasource.dart';
import '../../domain/repositories/bundle_repository.dart';
import './bundle_event.dart';
import './bundle_state.dart';

class BundleBloc extends Bloc<BundleEvent, BundleState> {
  late IBundleDatasource _datasource;
  late IBundleRepository _repository;
  late GetAllBundlesUsecase _getAllBundles;
  late CreateBundleUsecase _createBundle;

  BundleBloc() : super(Empty()) {
    _datasource = BundleDatasourceImplementation();
    _repository = BundleRepositoryImplementation(_datasource);
    _getAllBundles = GetAllBundlesUsecase(_repository);
    _createBundle = CreateBundleUsecase(_repository);
  }

  @override
  Stream<BundleState> mapEventToState(BundleEvent event) async* {
    yield Loading();

    if (event is GetAllBundlesEvent) {
      final failureOrData = await _getAllBundles(NoParams());

      yield* _eitherFailureOrData(failureOrData);
    } else if (event is CreateBundleEvent) {
      final failureOrData = await _createBundle(event.data)
          as Either<Failure, List<BundleEntity>>;

      yield* _eitherFailureOrData(failureOrData);
    }
  }

  Stream<BundleState> _eitherFailureOrData(
      Either<Failure, List<BundleEntity>> failureOrData) async* {
    yield failureOrData.fold((failure) => Error(''),
        (data) => Loaded(failureOrData as List<BundleEntity>));
  }
}
