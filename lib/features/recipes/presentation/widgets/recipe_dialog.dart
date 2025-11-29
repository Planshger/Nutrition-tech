import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_bloc.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_state.dart';

class RecipeDialog extends StatefulWidget {
  final Function(String name, String description, List<Fruits> selectedFruits) onSave;
  final VoidCallback onCancel;

  const RecipeDialog({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<RecipeDialog> createState() => _RecipeDialogState();
}

class _RecipeDialogState extends State<RecipeDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<Fruits> _selectedFruits = [];

  bool _isSaveButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_validateForm);
  }

  void _validateForm() {
    final bool isEnabled = _titleController.text.isNotEmpty && _selectedFruits.isNotEmpty;
    if (_isSaveButtonEnabled != isEnabled) {
      setState(() {
        _isSaveButtonEnabled = isEnabled;
      });
    }
  }

  void _onFruitSelected(Fruits fruit) {
    setState(() {
      if (_selectedFruits.contains(fruit)) {
        _selectedFruits.remove(fruit);
      } else {
        _selectedFruits.add(fruit);
      }
      _validateForm();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Создание рецепта'),
      content: Column(
        children: [
          const SizedBox(height: 20),
          CupertinoTextField(
            controller: _titleController,
            placeholder: 'Название рецепта',
            autofocus: true,
          ),
          const SizedBox(height: 10),
          CupertinoTextField(
            controller: _descriptionController,
            placeholder: 'Описание',
            maxLines: 3,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 160, 
            child: _buildFruitList(),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: widget.onCancel,
          child: const Text('Отмена'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: _isSaveButtonEnabled
              ? () => widget.onSave(_titleController.text, _descriptionController.text, _selectedFruits)
              : null,
          child: const Text('Сохранить'),
        ),
      ],
    );
  }

  Widget _buildFruitList() {
    return BlocBuilder<FruitsBloc, FruitsState>(
      builder: (context, state) {
        if (state is! FruitsLoaded) return const CupertinoActivityIndicator();

        final favouriteFruits = state.fruits.where((f) => f.isFavourite).toList();
        if (favouriteFruits.isEmpty) return const Center(child: Text('Добавьте фрукты в избранное'));

        return ListView(
          children: favouriteFruits.map((fruit) {
            return CupertinoListTile(
              title: Text(fruit.name),
              onTap: () => _onFruitSelected(fruit),
              trailing: _selectedFruits.contains(fruit) ? const Icon(CupertinoIcons.check_mark) : null,
            );
          }).toList(),
        );
      },
    );
  }
}