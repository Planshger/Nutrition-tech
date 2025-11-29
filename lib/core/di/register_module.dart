import 'package:dio/dio.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/all_fruits/data/models/fruits_model.dart';
import 'package:nutrition_tech/features/recipes/data/models/recipe_model.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @preResolve
  @lazySingleton
  Future<Box<FruitsModel>> get fruitsBox async {
    return Hive.openBox<FruitsModel>('fruits');
  }

  @preResolve
  @lazySingleton
  Future<Box<int>> get favouritesBox async {
    return Hive.openBox<int>('favourites');
  }

  @preResolve
  @lazySingleton
  Future<Box<RecipeModel>> get recipesBox async {
    return Hive.openBox<RecipeModel>('recipes');
  }
}