import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tech/core/di/widgets/nav_details_page.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_bloc.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_event.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_state.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/widgets/fruit_tile.dart';

class FruitsPage extends StatefulWidget {
  const FruitsPage({super.key});

  @override
  State<FruitsPage> createState() => _FruitsPageState();
}

class _FruitsPageState extends State<FruitsPage>  with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<FruitsBloc>().add(LoadFruits());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FruitsBloc, FruitsState>(
      builder: (context, state) {
        if (state is FruitsError) {
          return CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(middle: Text('Error')),
            child: Center(child: Text(state.message)),
          );
        }
        
        if (state is! FruitsLoaded) {
          return const CupertinoPageScaffold(
            child: Center(child: CupertinoActivityIndicator()),
          );
        }

        return CupertinoPageScaffold(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              const CupertinoSliverNavigationBar(
                largeTitle: Text('Фрукты'),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final fruit = state.fruits[index];
                    return FruitTile(
                      fruit: fruit,
                      onTap: () => navigateDetailsPage(context, fruit),
                      onFavourites: (ctx) => ctx.read<FruitsBloc>().add(
                            AddFavouritesEvent(fruit.id),
                          ),
                    );
                  },
                  childCount: state.fruits.length,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}


