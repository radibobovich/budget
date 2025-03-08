import 'package:budget/core/misc/extensions.dart';
import 'package:flutter/material.dart';

class CustomCupertinoButton extends StatelessWidget {
  const CustomCupertinoButton({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: context.window.width * 0.7,
      decoration: BoxDecoration(
        color: context.colors.save,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: BorderRadius.circular(16),
          child: Center(
              child: Text(
            'Сохранить',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          )),
        ),
      ),
    );
  }
}
