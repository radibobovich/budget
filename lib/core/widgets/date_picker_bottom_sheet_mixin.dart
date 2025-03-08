import 'package:budget/core/misc/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin DatePickerBottomSheetMixin {
  Future<void> showDatePicker({
    required BuildContext context,
    required DateTime initial,
    required Function(DateTime) onDateTimeChanged,
    required VoidCallback onSet,
    required VoidCallback onCancel,
    required CupertinoDatePickerMode mode,
    DateTime? minimumDate,
    DateTime? maximumDate,
  }) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (modalContext) {
        return Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                TextButton(
                    onPressed: () => onCancel(),
                    child: Text('Отмена',
                        style: TextStyle(
                            color: context.colors.textColor, fontSize: 17))),
                const Spacer(),
                TextButton(
                    onPressed: () => onSet(),
                    child: Text('Готово',
                        style: TextStyle(
                            color: context.colors.textColor, fontSize: 17))),
              ],
            ),
          ),
          SizedBox(
              height: context.window.height * 0.3,
              child: CupertinoDatePicker(
                initialDateTime: initial,
                onDateTimeChanged: onDateTimeChanged,
                use24hFormat: true,
                mode: mode,
                minimumDate: minimumDate ?? DateTime(1900),
                maximumDate: maximumDate ?? DateTime(2100),
              ))
        ]);
      },
    );
  }
}
