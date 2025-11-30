import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/sort.dart';
import 'package:nutrition_tech/features/sorting/presentation/bloc/sorting_bloc.dart';
import 'package:nutrition_tech/features/sorting/presentation/bloc/sorting_event.dart';
import 'package:nutrition_tech/features/sorting/presentation/bloc/sorting_state.dart';

class SortingSection extends StatelessWidget {
  const SortingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortingBloc, SortingState>(
      builder: (context, state) {
        if (state is! SortingOptionsLoaded) return const SizedBox();
        
        final selectedSort = state.selectedSort;
        
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Сортировка',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              ...Sort.values.map((sortType) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {context.read<SortingBloc>().add(UpdateSortType(sortType));},
                    child: Row(children: [
                        Icon(
                          selectedSort == sortType ? CupertinoIcons.checkmark_circle_fill : CupertinoIcons.circle,
                          color: selectedSort == sortType ? CupertinoColors.activeBlue : CupertinoColors.systemGrey,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _getSortTypeName(sortType),
                            style: TextStyle(
                              color: CupertinoColors.label.resolveFrom(context),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  String _getSortTypeName(Sort sortType) {
    switch (sortType) {
      case Sort.nameAsc:
        return 'По названию (A-Z)';
      case Sort.nameDesc:
        return 'По названию (Z-A)';
      case Sort.caloriesAsc:
        return 'По калориям (возрастание)';
      case Sort.caloriesDesc:
        return 'По калориям (убывание)';
    }
  }
}