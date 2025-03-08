import 'package:budget/core/misc/extensions.dart';
import 'package:budget/features/transaction/ui/bloc/value_controller.dart';
import 'package:flutter/material.dart' hide KeyEvent;

class ValueNumpad extends StatelessWidget {
  const ValueNumpad({super.key, required this.controller});
  final ValueController controller;
  Sink<KeyEvent> get sink => controller.addEvent;
  @override
  Widget build(BuildContext context) {
    final window = context.window;
    final horizontalSpacing = window.width * 0.05;
    final verticalSpacing = window.height * 0.02;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NumpadKey.num(1, sink),
            SizedBox(width: horizontalSpacing),
            NumpadKey.num(2, sink),
            SizedBox(width: horizontalSpacing),
            NumpadKey.num(3, sink),
          ],
        ),
        SizedBox(height: verticalSpacing),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NumpadKey.num(4, sink),
            SizedBox(width: horizontalSpacing),
            NumpadKey.num(5, sink),
            SizedBox(width: horizontalSpacing),
            NumpadKey.num(6, sink),
          ],
        ),
        SizedBox(height: verticalSpacing),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NumpadKey.num(7, sink),
            SizedBox(width: horizontalSpacing),
            NumpadKey.num(8, sink),
            SizedBox(width: horizontalSpacing),
            NumpadKey.num(9, sink),
          ],
        ),
        SizedBox(height: verticalSpacing),
        Row(mainAxisSize: MainAxisSize.min, children: [
          NumpadKey.decimal(sink),
          SizedBox(width: horizontalSpacing),
          NumpadKey.num(0, sink),
          SizedBox(width: horizontalSpacing),
          NumpadKey.backspace(sink,
              Icon(Icons.backspace_outlined, color: context.colors.delete))
        ])
      ],
    );
  }
}

class NumpadKey extends StatelessWidget {
  const NumpadKey({
    super.key,
    required this.symbol,
    required this.sink,
    required this.onTap,
    this.icon,
  });
  final Sink<KeyEvent> sink;
  final String symbol;
  final VoidCallback onTap;
  final Icon? icon;
  factory NumpadKey.num(int num, Sink<KeyEvent> sink) {
    return NumpadKey(
        symbol: num.toString(),
        sink: sink,
        onTap: () => sink.add(NumericKeyEvent(num)));
  }

  factory NumpadKey.decimal(Sink<KeyEvent> sink) {
    return NumpadKey(
        symbol: ',', sink: sink, onTap: () => sink.add(DecimalKeyEvent()));
  }

  factory NumpadKey.backspace(Sink<KeyEvent> sink, Icon icon) {
    return NumpadKey(
        symbol: '',
        sink: sink,
        onTap: () => sink.add(BackspaceKeyEvent()),
        icon: icon);
  }

  @override
  Widget build(BuildContext context) {
    final window = context.window;
    final side = window.width * 0.1;
    const fontRatio = 0.9;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.colors.border),
        color: Colors.transparent,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(1000),
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SizedBox(
              height: side,
              width: side,
              child: Center(
                child: icon ??
                    Text(
                      symbol,
                      style: TextStyle(
                          fontSize: fontRatio * side,
                          fontWeight: FontWeight.w700,
                          height: 0.8),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
