import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';
import 'package:nutrition_tech/features/all_fruits/domain/usecases/add_favourites.dart';
import 'package:nutrition_tech/features/all_fruits/domain/usecases/get_details.dart';
import 'package:nutrition_tech/features/all_fruits/domain/usecases/get_fruits.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_event.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_state.dart';

@injectable
class FruitsBloc extends Bloc<FruitsEvent, FruitsState> {
  final GetFruits getFruits;
  final GetDetails getDetails;
  final AddFavourites addFavourites;

  List<Fruits> _fruits = [];

  FruitsBloc({
    required this.getFruits,
    required this.getDetails,
    required this.addFavourites,
  }) : super(FruitsInitial()){
    on<LoadFruits>(_onLoadFruits);
    on<AddFavouritesEvent>(_onAddFavourites);
    on<RemoveFavouritesEvent>(_onRemoveFavourites);
    on<GetDetailsEvent>(_onGetDetails);
  }

  Future<void> _onLoadFruits(LoadFruits event, Emitter<FruitsState> emit) async {
    emit(FruitsLoading());
    try {
      _fruits = await getFruits();
      emit(FruitsLoaded(_fruits));
    } catch (e) {
      emit(FruitsError(e.toString()));
    }
  }

  Future<void> _onAddFavourites(AddFavouritesEvent event, Emitter<FruitsState> emit) async {
    try {
      await addFavourites(event.fruitId);
      add(LoadFruits());
    } catch (e) {
      emit(FruitsError(e.toString()));
    }
  }

  Future<void> _onRemoveFavourites(RemoveFavouritesEvent event, Emitter<FruitsState> emit) async {
    try {
      await addFavourites(event.fruitId);
      add(LoadFruits());
    } catch (e) {
      emit(FruitsError(e.toString()));
    }
  }

  Future<void> _onGetDetails(GetDetailsEvent event, Emitter<FruitsState> emit) async {
    emit(FruitsLoading());
    try {
      final fruit = await getDetails(event.fruitId);
      if (fruit != null) {
        emit(FruitDetailsLoaded(fruit));
      } else {
        emit(FruitsError('Fruit with id ${event.fruitId} not found'));
      }
    } catch (e) {
      emit(FruitsError(e.toString()));
    }
  }

}
