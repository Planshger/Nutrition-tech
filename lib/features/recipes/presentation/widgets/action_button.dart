import 'package:flutter/cupertino.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  
  const ActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemGreen,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.white.withAlpha(50),
            blurRadius: 1,
          ),
        ],
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(30),
        onPressed: onPressed,
        child: Icon(icon, color: CupertinoColors.white, size: 28),
      ),
    );
  }
}