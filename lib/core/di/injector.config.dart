// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce_flutter/hive_flutter.dart' as _i919;
import 'package:injectable/injectable.dart' as _i526;
import 'package:nutrition_tech/core/di/register_module.dart' as _i258;
import 'package:nutrition_tech/features/all_fruits/data/datasources/fruits_local_data_source.dart'
    as _i487;
import 'package:nutrition_tech/features/all_fruits/data/datasources/fruits_remote_data_source.dart'
    as _i574;
import 'package:nutrition_tech/features/all_fruits/data/models/fruits_model.dart'
    as _i187;
import 'package:nutrition_tech/features/all_fruits/data/repositories/fruits_repository_impl.dart'
    as _i1041;
import 'package:nutrition_tech/features/all_fruits/domain/repositories/fruits_repository.dart'
    as _i344;
import 'package:nutrition_tech/features/all_fruits/domain/usecases/add_favourites.dart'
    as _i731;
import 'package:nutrition_tech/features/all_fruits/domain/usecases/get_details.dart'
    as _i406;
import 'package:nutrition_tech/features/all_fruits/domain/usecases/get_fruits.dart'
    as _i59;
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_bloc.dart'
    as _i539;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    await gh.lazySingletonAsync<_i919.Box<_i187.FruitsModel>>(
      () => registerModule.fruitsBox,
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i919.Box<int>>(
      () => registerModule.favouritesBox,
      preResolve: true,
    );
    gh.lazySingleton<_i574.FruitsRemoteDataSource>(
      () => _i574.FruitsRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i487.FruitsLocalDataSource>(
      () => _i487.FruitsLocalDataSourceImpl(
        gh<_i919.Box<_i187.FruitsModel>>(),
        gh<_i919.Box<int>>(),
      ),
    );
    gh.factory<_i344.FruitsRepository>(
      () => _i1041.FruitsRepositoryImpl(
        gh<_i574.FruitsRemoteDataSource>(),
        gh<_i487.FruitsLocalDataSource>(),
      ),
    );
    gh.factory<_i731.AddFavourites>(
      () => _i731.AddFavourites(gh<_i344.FruitsRepository>()),
    );
    gh.factory<_i406.GetDetails>(
      () => _i406.GetDetails(gh<_i344.FruitsRepository>()),
    );
    gh.factory<_i59.GetFruits>(
      () => _i59.GetFruits(gh<_i344.FruitsRepository>()),
    );
    gh.factory<_i539.FruitsBloc>(
      () => _i539.FruitsBloc(
        getFruits: gh<_i59.GetFruits>(),
        getDetails: gh<_i406.GetDetails>(),
        addFavourites: gh<_i731.AddFavourites>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i258.RegisterModule {}
