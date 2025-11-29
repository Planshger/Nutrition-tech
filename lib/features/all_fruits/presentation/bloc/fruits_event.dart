abstract class FruitsEvent {}

class LoadFruits extends FruitsEvent {}

class AddFavouritesEvent extends FruitsEvent {
  final int fruitId;
  AddFavouritesEvent(this.fruitId);
}

class RemoveFavouritesEvent extends FruitsEvent {
  final int fruitId;
  RemoveFavouritesEvent(this.fruitId);
}

class GetDetailsEvent extends FruitsEvent {
  final int fruitId;
  GetDetailsEvent(this.fruitId);
}