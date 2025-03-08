import 'package:budget/core/misc/extensions.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';

class SegmentedPicker<T extends Enum> extends StatelessWidget {
  SegmentedPicker({
    super.key,
    this.controller,
    required this.segments,
    T? initialValue,
    this.padding = 12,
    this.isStretch = true,
    this.onValueChanged,
  }) : initialValue = initialValue ?? segments.first.enumerator;
  final CustomSegmentedController<T>? controller;

  final List<PickerSegment<T>> segments;
  final T initialValue;
  final double padding;
  final bool isStretch;
  final Function(T)? onValueChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: CustomSlidingSegmentedControl<T>(
        controller: controller,
        onValueChanged: (value) => onValueChanged?.call(value),
        isStretch: isStretch,
        innerPadding: EdgeInsets.zero,
        padding: padding,
        initialValue: initialValue,
        customSegmentSettings: CustomSegmentSettings(),
        decoration: BoxDecoration(
            color: context.theme.canvasColor,
            borderRadius: BorderRadius.circular(100)),
        thumbDecoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(100)),
        children: {
          for (final s in segments)
            s.enumerator:
                _PickerSegmentInteral(title: s.title, enumerator: s.enumerator)
        },
      ),
    );
  }
}

class PickerSegment<T> {
  final T enumerator;
  final String title;
  PickerSegment({required this.enumerator, required this.title});
}

class _PickerSegmentInteral<T> extends StatelessWidget {
  const _PickerSegmentInteral(
      {super.key,
      required this.title,
      required this.enumerator,
      this.horizontalMargin = 24});
  final T enumerator;
  final String title;
  final double horizontalMargin;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 8),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: context.colors.contrast,
          ),
        ));
  }
}
