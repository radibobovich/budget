import 'package:budget/core/misc/extensions.dart';
import 'package:flutter/material.dart' hide showDatePicker;

class DateChip extends StatelessWidget {
  const DateChip(
      {super.key,
      required this.isStart,
      required this.label,
      required this.onTap,
      required this.onReset});
  final bool isStart;
  final String? label;
  final VoidCallback onTap;
  final VoidCallback onReset;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: context.colors.border),
          borderRadius: BorderRadius.circular(100)),
      child: Stack(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () => onTap(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    isStart ? 'От' : 'До',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(width: 8),
                  label != null
                      ? Text(
                          label!,
                          style: TextStyle(
                              color: context.colors.secondaryText,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                        )
                      : const SizedBox.shrink(),
                  if (label == null) const Spacer(),
                  if (label == null)
                    Text(
                      'Указать дату',
                      style: TextStyle(
                          color: context.colors.secondaryText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                ],
              ),
            ),
          ),
          if (label != null)
            Positioned(
              right: 8,
              top: 8,
              bottom: 8,
              child: GestureDetector(
                  onTap: () {
                    onReset();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: context.colors.contrast),
                    child: SizedBox(
                      height: 28,
                      width: 28,
                      child:
                          Icon(Icons.remove, color: context.theme.canvasColor),
                    ),
                  )),
            )
        ],
      ),
    );
  }
}
