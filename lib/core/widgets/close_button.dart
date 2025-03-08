import 'package:budget/core/misc/extensions.dart';
import 'package:flutter/material.dart';

class CloseBackButton extends StatelessWidget {
  const CloseBackButton(
      {super.key, required this.onTap, this.borderThickness = 1});
  final VoidCallback onTap;
  final double borderThickness;

  const CloseBackButton.forBottomActions({super.key, required this.onTap})
      : borderThickness = 2;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
            Border.all(color: context.colors.border, width: borderThickness),
        color: Colors.transparent,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.close),
        ),
      ),
    );
  }
}
