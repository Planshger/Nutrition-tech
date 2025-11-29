import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_bloc.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/pages/details_page.dart';

void navigateDetailsPage(BuildContext context, Fruits fruit) {
  final bloc = context.read<FruitsBloc>();

  Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (newContext) => BlocProvider.value(
        value: bloc,
        child: DetailsPage(fruit: fruit),
      ),
    ),
  );
}