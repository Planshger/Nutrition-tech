import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:nutrition_tech/core/di/injector.dart';
import 'package:nutrition_tech/features/all_fruits/data/models/fruits_model.dart';
import 'package:nutrition_tech/features/recipes/data/models/recipe_model.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_bloc.dart';
import 'package:nutrition_tech/features/home/presentation/pages/home_page.dart';
import 'package:nutrition_tech/features/sorting/presentation/bloc/sorting_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapter(FruitsModelAdapter());
  Hive.registerAdapter(RecipeModelAdapter());
  
  await configureDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => injector<FruitsBloc>()),
        BlocProvider(create: (context) => injector<SortingBloc>()),
      ],
      child: const CupertinoApp(home: HomePage()),
    );
  }
}
