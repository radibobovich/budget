import 'package:auto_route/auto_route.dart';
import 'package:budget/core/widgets/date_picker_bottom_sheet_mixin.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:budget/features/transaction/ui/bloc/events.dart';
import 'package:budget/features/transaction/ui/bloc/transaction_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide showDatePicker;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, required this.date});
  final DateTime date;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker>
    with DatePickerBottomSheetMixin {
  late DateTime pickerDate;

  String get formattedDate {
    final formatter = DateFormat('dd.MM.yyyy HH:mm', 'ru_RU');
    return formatter.format(widget.date);
  }

  @override
  void initState() {
    pickerDate = widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallDisplay = context.window.width < 380;
    return Container(
      decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(16)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            showDatePicker(
                context: context,
                initial: widget.date,
                mode: CupertinoDatePickerMode.dateAndTime,
                onDateTimeChanged: (date) {
                  setState(() => pickerDate = date);
                },
                onSet: () {
                  final bloc = context.read<TransactionBloc>();
                  bloc.add(TransactionDateSet(pickerDate));
                  context.router.pop();
                },
                onCancel: () {
                  setState(() => pickerDate = widget.date);
                  context.router.pop();
                });
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 32),
                SizedBox(width: 12),
                Text(
                  isSmallDisplay ? 'Дата' : 'Добавлен',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: context.colors.secondaryText,
                  ),
                ),
                const Spacer(),
                Text(formattedDate,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
