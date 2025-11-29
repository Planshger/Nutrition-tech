import 'package:flutter/cupertino.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorDisplay({
    super.key,
    this.message = 'Произошла ошибка',
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 10),
          CupertinoButton(onPressed: onRetry, child: const Text('Повторить')),
        ],
      ),
    );
  }
}