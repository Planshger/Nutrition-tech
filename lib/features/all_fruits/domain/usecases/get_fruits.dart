import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';
import 'package:nutrition_tech/features/all_fruits/domain/repositories/fruits_repository.dart';

@injectable
class GetFruits {
  final FruitsRepository repository;
  GetFruits(this.repository);
  Future<List<Fruits>> call() => repository.getFruits();
}