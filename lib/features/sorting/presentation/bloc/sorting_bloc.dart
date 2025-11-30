import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/filter.dart';
import 'package:nutrition_tech/features/sorting/domain/repositories/sorting_repository.dart';
import 'package:nutrition_tech/features/sorting/presentation/bloc/sorting_event.dart';
import 'package:nutrition_tech/features/sorting/presentation/bloc/sorting_state.dart';

@injectable
class SortingBloc extends Bloc<SortingEvent, SortingState> {
  final SortingRepository sortingRepository;

  SortingBloc({required this.sortingRepository}) : super(SortingInitial()) {
    on<LoadSortingOptions>(_onLoadSortingOptions);
    on<UpdateSortType>(_onUpdateSortType);
    on<ToggleFilter>(_onToggleFilter);
    on<ApplySortingAndFilters>(_onApplySortingAndFilters);
  }

  void _onLoadSortingOptions(LoadSortingOptions event, Emitter<SortingState> emit) {
    final filterDefinitions = sortingRepository.getFilterDefinitions();
    emit(SortingOptionsLoaded(
      selectedSort: event.currentSort,
      selectedFilters: event.currentFilters,
      filterDefinitions: filterDefinitions,
    ));
  }

  void _onUpdateSortType(UpdateSortType event, Emitter<SortingState> emit) {
    if (state is SortingOptionsLoaded) {
      final currentState = state as SortingOptionsLoaded;
      emit(currentState.copyWith(selectedSort: event.sortType));
    }
  }

  void _onToggleFilter(ToggleFilter event, Emitter<SortingState> emit) {
    if (state is SortingOptionsLoaded) {
      final currentState = state as SortingOptionsLoaded;
      final newFilters = List<Filter>.from(currentState.selectedFilters);
      
      if (newFilters.contains(event.filterType)) {
        newFilters.remove(event.filterType);
      } else {
        newFilters.add(event.filterType);
      }
      
      emit(currentState.copyWith(selectedFilters: newFilters));
    }
  }

  void _onApplySortingAndFilters(ApplySortingAndFilters event, Emitter<SortingState> emit) {
    if (state is SortingOptionsLoaded) {
      final currentState = state as SortingOptionsLoaded;
      final sortedFruits = sortingRepository.applySortingAndFilters(
        fruits: event.fruits,
        sortType: currentState.selectedSort,
        filterTypes: currentState.selectedFilters,
      );
      
      emit(SortingApplied(
        sortedFruits: sortedFruits,
        appliedSort: currentState.selectedSort,
        appliedFilters: currentState.selectedFilters,
      ));
    }
  }
}