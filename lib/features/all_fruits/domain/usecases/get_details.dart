import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';
import 'package:nutrition_tech/features/all_fruits/domain/repositories/fruits_repository.dart';

@injectable
class GetDetails {
  final FruitsRepository repository;
  GetDetails(this.repository);
  Future<Fruits?> call(int fruitId) => repository.getDetails(fruitId);
}