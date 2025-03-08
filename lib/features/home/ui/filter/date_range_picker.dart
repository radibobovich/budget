import 'package:auto_route/auto_route.dart';
import 'package:budget/core/widgets/date_picker_bottom_sheet_mixin.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:budget/features/home/ui/filter/date_chip.dart';
import 'package:budget/features/home/ui/bloc/events.dart';
import 'package:budget/features/home/ui/bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DateRangePicker extends StatefulWidget {
  const DateRangePicker(
      {super.key,
      required this.initialStartDate,
      required this.initialEndDate});
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker>
    with DatePickerBottomSheetMixin {
  DateTime? start;
  DateTime? end;

  @override
  void initState() {
    start = widget.initialStartDate;
    end = widget.initialEndDate;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DateRangePicker oldWidget) {
    start = widget.initialStartDate;
    end = widget.initialEndDate;
    super.didUpdateWidget(oldWidget);
  }

  String? maybeFormattedDate(DateTime? date) {
    if (date == null) return null;
    final formatter = DateFormat('dd.MM.yyyy', 'ru_RU');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DateChip(
          isStart: true,
          label: maybeFormattedDate(start),
          onTap: () {
            final todayStart = DateTime.now().roundToDayStart;
            showDatePicker(
              context: context,
              initial: start ?? _pickMin(end ?? todayStart, todayStart),
              mode: CupertinoDatePickerMode.date,
              maximumDate: end,
              onDateTimeChanged: (date) {
                start = date.roundToDayStart;
              },
              onSet: () {
                start ??= DateTime.now().roundToDayStart;
                final bloc = context.read<HomeBloc>();
                bloc.add(HomeDateFilterSet(() => start, null));
                context.router.pop();
              },
              onCancel: () {
                start = widget.initialStartDate;
                context.router.pop();
              },
            );
          },
          onReset: () {
            final bloc = context.read<HomeBloc>();
            bloc.add(HomeDateFilterSet(() => null, null));
          },
        ),
        const SizedBox(height: 8),
        DateChip(
          isStart: false,
          label: maybeFormattedDate(end),
          onTap: () {
            final todayEnd = DateTime.now().roundToDayEnd;
            showDatePicker(
              context: context,
              initial: end ?? _pickMax(start ?? todayEnd, todayEnd),
              mode: CupertinoDatePickerMode.date,
              minimumDate: start,
              onDateTimeChanged: (date) {
                end = date.roundToDayEnd;
              },
              onSet: () {
                end ??= DateTime.now().roundToDayEnd;

                final bloc = context.read<HomeBloc>();
                bloc.add(HomeDateFilterSet(null, () => end));
                context.router.pop();
              },
              onCancel: () {
                end = widget.initialEndDate;
                context.router.pop();
              },
            );
          },
          onReset: () {
            final bloc = context.read<HomeBloc>();
            bloc.add(HomeDateFilterSet(null, () => null));
          },
        )
      ],
    );
  }

  DateTime _pickMax(DateTime d1, DateTime d2) {
    if (d1.millisecondsSinceEpoch >= d2.millisecondsSinceEpoch) {
      return d1;
    }
    return d2;
  }

  DateTime _pickMin(DateTime d1, DateTime d2) {
    if (d1.millisecondsSinceEpoch < d2.millisecondsSinceEpoch) {
      return d1;
    }
    return d2;
  }
}
