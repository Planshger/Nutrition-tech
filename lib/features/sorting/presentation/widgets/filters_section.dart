import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/filter.dart';
import 'package:nutrition_tech/features/sorting/presentation/bloc/sorting_bloc.dart';
import 'package:nutrition_tech/features/sorting/presentation/bloc/sorting_event.dart';
import 'package:nutrition_tech/features/sorting/presentation/bloc/sorting_state.dart';

class FiltersSection extends StatelessWidget {
  const FiltersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortingBloc, SortingState>(
      builder: (context, state) {
        if (state is! SortingOptionsLoaded) return const SizedBox();
        
        final selectedFilters = state.selectedFilters;
        final filterDefinitions = state.filterDefinitions;
        
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Фильтры', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              ...Filter.values.map((filterType) {
                final isSelected = selectedFilters.contains(filterType);
                final filterInfo = filterDefinitions[filterType]!;
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {context.read<SortingBloc>().add(ToggleFilter(filterType));},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? CupertinoColors.activeBlue.withOpacity(0.1) : CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? CupertinoColors.activeBlue : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Row(children: [
                              Icon(
                                isSelected ? CupertinoIcons.checkmark_circle_fill : CupertinoIcons.circle,
                                color: isSelected ? CupertinoColors.activeBlue : CupertinoColors.systemGrey,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                filterInfo.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: CupertinoColors.label.resolveFrom(context),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          if (isSelected) ...[
                            const SizedBox(height: 8),
                            _buildFilterDetails(filterInfo.criteria),
                          ],
                        ],
                      ),
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

  Widget _buildFilterDetails(Map<String, dynamic> criteria) {
    final details = <Widget>[];
    
    if (criteria['calories'] != null) {
      final calories = criteria['calories'] as Map<String, dynamic>;
      details.add(_buildFilterDetailRow(
        'Калории: ${calories['min'] ?? '≤'}–${calories['max'] ?? '≥'} ккал'
      ));
    }
    
    if (criteria['carbohydrates'] != null) {
      final carbs = criteria['carbohydrates'] as Map<String, dynamic>;
      final min = carbs['min'];
      final max = carbs['max'];
      details.add(_buildFilterDetailRow(
        'Углеводы: ${min != null ? '≥ $min' : ''}${max != null ? '≤ $max' : ''} г'
      ));
    }
    
    if (criteria['sugar'] != null) {
      final sugar = criteria['sugar'] as Map<String, dynamic>;
      details.add(_buildFilterDetailRow(
        'Сахар: ≤ ${sugar['max']} г'
      ));
    }
    
    if (criteria['protein'] != null) {
      final protein = criteria['protein'] as Map<String, dynamic>;
      details.add(_buildFilterDetailRow(
        'Белок: ≥ ${protein['min']} г'
      ));
    }
    
    if (criteria['fat'] != null) {
      final fat = criteria['fat'] as Map<String, dynamic>;
      if (fat['max'] != null) {
        details.add(_buildFilterDetailRow(
          'Жиры: ≤ ${fat['max']} г'
        ));
      } else {
        details.add(_buildFilterDetailRow('Жиры: любой'));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: details,
    );
  }

  Widget _buildFilterDetailRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        text,
        style: TextStyle(
          color: CupertinoColors.secondaryLabel,
          fontSize: 14,
        ),
      ),
    );
  }
}