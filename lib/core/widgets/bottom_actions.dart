import 'package:budget/core/misc/extensions.dart';
import 'package:flutter/material.dart';

class BottomActions extends StatelessWidget {
  const BottomActions(
      {super.key, required this.closeButton, required this.actionButton});
  final Widget closeButton;
  final Widget actionButton;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16,
          child: Divider(color: context.colors.border, thickness: 2),
        ),
        closeButton,
        Expanded(child: Divider(color: context.colors.border, thickness: 2)),
        actionButton,
        SizedBox(
          width: 16,
          child: Divider(color: context.colors.border, thickness: 2),
        ),
      ],
    );
  }
}
