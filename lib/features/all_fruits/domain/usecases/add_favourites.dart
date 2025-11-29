import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/all_fruits/domain/repositories/fruits_repository.dart';

@injectable
class AddFavourites {
  final FruitsRepository repository;
  AddFavourites(this.repository);
  Future<void> call(int fruitId) => repository.addFavourites(fruitId);
}
