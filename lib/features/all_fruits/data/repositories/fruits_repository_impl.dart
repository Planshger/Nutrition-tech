import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/all_fruits/data/models/fruits_model.dart';
import 'package:nutrition_tech/features/all_fruits/data/datasources/fruits_local_data_source.dart';
import 'package:nutrition_tech/features/all_fruits/data/datasources/fruits_remote_data_source.dart';
import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';
import 'package:nutrition_tech/features/all_fruits/domain/repositories/fruits_repository.dart';

@Injectable(as: FruitsRepository)
class FruitsRepositoryImpl implements FruitsRepository {
  final FruitsRemoteDataSource _remoteDataSource;
  final FruitsLocalDataSource _localDataSource;

  FruitsRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<List<Fruits>> getFruits() async {
    List<FruitsModel> fruitModels;
    final localFruits = await _localDataSource.getFruits(); 
    if (localFruits.isEmpty) {
      try {
        final remoteFruits = await _remoteDataSource.getFruits();
        await _localDataSource.cacheFruits(remoteFruits);
        fruitModels = remoteFruits;
      } catch (e) {
        return [];
      }
    } else {
      fruitModels = localFruits;
    }

    final favouriteIds = await _localDataSource.getFavouriteIds(); 
    final favouriteIdsSet = favouriteIds.toSet();

    return fruitModels
        .map((model) => model.toEntity(isFavourite: favouriteIdsSet.contains(model.id)))
        .toList();
  }

  @override
  Future<void> addFavourites(int fruitId) async {
    return _localDataSource.toggleFavourite(fruitId);
  }

  @override
  Future<Fruits?> getDetails(int fruitId) async {
    final favouriteIds = await _localDataSource.getFavouriteIds();
    final isFav = favouriteIds.contains(fruitId);

    final fruitModel = await _localDataSource.getFruitDetails(fruitId);
    return fruitModel?.toEntity(isFavourite: isFav);
  }
}