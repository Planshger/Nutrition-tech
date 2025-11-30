import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/filter.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/sort.dart';
import 'package:nutrition_tech/features/sorting/presentation/bloc/sorting_bloc.dart';
import 'package:nutrition_tech/features/sorting/presentation/bloc/sorting_event.dart';
import 'package:nutrition_tech/features/sorting/presentation/bloc/sorting_state.dart';
import 'package:nutrition_tech/features/sorting/presentation/widgets/filters_section.dart';
import 'package:nutrition_tech/features/sorting/presentation/widgets/sorting_section.dart';

class SortingPage extends StatefulWidget {
  final List<Fruits> currentFruits;
  final Sort currentSort;
  final List<Filter> currentFilters;
  final Function(List<Fruits> sortedFruits, Sort sortType, List<Filter> activeFilters) onApplyFilters;

  const SortingPage({super.key, required this.currentFruits, required this.currentSort, required this.currentFilters, required this.onApplyFilters});

  @override
  State<SortingPage> createState() => _SortingPageState();
}

class _SortingPageState extends State<SortingPage> {
  @override
  void initState() {
    super.initState();
    context.read<SortingBloc>().add(
      LoadSortingOptions(
        currentSort: widget.currentSort,
        currentFilters: widget.currentFilters,
      ),
    );
  }

  void _applyAndClose() {
    context.read<SortingBloc>().add(ApplySortingAndFilters(widget.currentFruits));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SortingBloc, SortingState>(
      listener: (context, state) {
        if (state is SortingApplied) {
          widget.onApplyFilters(
            state.sortedFruits,
            state.appliedSort,
            state.appliedFilters,
          );
          Navigator.of(context).pop();
        }
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(CupertinoIcons.back, size: 24),
          ),
          middle: const Text('Фильтры'),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: _applyAndClose,
            child: const Text(
              'Применить',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: const [
              SortingSection(),
              FiltersSection(),
            ],
          ),
        ),
      ),
    );
  }
}