import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/all_fruits/data/models/fruits_model.dart';

abstract class FruitsRemoteDataSource {
  Future<List<FruitsModel>> getFruits();
}

@LazySingleton(as: FruitsRemoteDataSource)
class FruitsRemoteDataSourceImpl implements FruitsRemoteDataSource {
  final Dio _dio;

  FruitsRemoteDataSourceImpl(this._dio);

  @override
  Future<List<FruitsModel>> getFruits() async {
    final response = await _dio.get('https://www.fruityvice.com/api/fruit/all');

    if (response.statusCode == 200 && response.data != null) {
      final List<dynamic> fruitListJson = response.data;
      return fruitListJson.map((json) => FruitsModel.fromJson(json)).toList();
    }
    throw Exception('Failed to load fruits');
  }
}