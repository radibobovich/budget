import 'package:auto_size_text/auto_size_text.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:budget/features/home/domain/calculator.dart';
import 'package:budget/features/stats/domain/chart_segment.dart';
import 'package:budget/features/stats/ui/bloc/states.dart';
import 'package:budget/features/stats/ui/bloc/stats_bloc.dart';
import 'package:budget/core/misc/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTotalsList extends StatelessWidget {
  const CategoriesTotalsList({super.key, required this.transactionType});
  final TransactionType transactionType;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is! StatsLoaded) {
          return SliverToBoxAdapter();
        }

        final segments = state.getChartSegments(transactionType);
        final total = state.sumForTransactionType(transactionType);
        return SliverList.separated(
          itemCount: segments.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return CategoryTotalTile(segment: segments[index], total: total);
          },
        );
      },
    );
  }
}

class CategoryTotalTile extends StatelessWidget {
  const CategoryTotalTile(
      {super.key, required this.segment, required this.total});
  final ChartSegment segment;
  final int total;
  String get percentage {
    if (segment.valueKopecks == 0) return '0%';
    final percents = (segment.valueKopecks / total) * 100;
    return '${percents.toStringAsFixed(2)}%';
  }

  @override
  Widget build(BuildContext context) {
    final valueFormatted =
        AppFormatters.formatRublesWithSeparatorsAndDecimalPart(
            segment.valueKopecks / 100,
            decimalDigits: 2);
    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: segment.color,
                border: segment.categoryId == null
                    ? Border.all(
                        color: context.colors.secondaryText, width: 1.5)
                    : null,
              ),
              child: SizedBox(
                height: 40,
                width: 40,
                child: segment.categoryId == null
                    ? Icon(Icons.question_mark,
                        color: context.colors.secondaryText)
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      segment.label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    AutoSizeText(
                      valueFormatted,
                      maxLines: 1,
                      maxFontSize: 20,
                      minFontSize: 10,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                  ]),
            ),
            Text(
              percentage,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
