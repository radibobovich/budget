import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  const LongButton(
      {super.key,
      required this.onTap,
      required this.gradient,
      required this.text,
      this.icon,
      this.borderColor});
  final VoidCallback onTap;
  final Gradient gradient;
  final Color? borderColor;
  final String text;
  final Icon? icon;
  factory LongButton.confirm(
      {required VoidCallback onTap, required Gradient gradient}) {
    return LongButton(
        onTap: onTap, gradient: gradient, text: 'Ввод', icon: Icon(Icons.done));
  }

  factory LongButton.skip(
      {required VoidCallback onTap, required Color borderColor}) {
    return LongButton(
      onTap: onTap,
      text: 'Пропустить',
      borderColor: borderColor,
      gradient: LinearGradient(colors: [
        Colors.transparent,
        Colors.transparent,
      ]),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(100),
        border: borderColor != null ? Border.all(color: borderColor!) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () => onTap(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) icon!,
                if (icon != null) const SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                if (icon != null) const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
