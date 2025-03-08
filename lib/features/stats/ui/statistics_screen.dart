import 'package:auto_size_text/auto_size_text.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:budget/features/home/domain/calculator.dart';
import 'package:budget/features/stats/ui/bloc/states.dart';
import 'package:budget/features/stats/ui/bloc/stats_bloc.dart';
import 'package:budget/features/stats/ui/widgets/segmented_picker.dart';
import 'package:budget/features/stats/ui/widgets/categories_totals_list.dart';
import 'package:budget/features/stats/ui/widgets/chart.dart';
import 'package:budget/core/misc/utils.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final viewController = CustomSegmentedController<TransactionType>(
      value: TransactionType.incomes);
  TransactionType currentView = TransactionType.incomes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Статистика'),
        scrolledUnderElevation: 0,
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedPicker(
                controller: viewController,
                onValueChanged: (view) => setState(() {
                      currentView = view;
                    }),
                segments: [
                  PickerSegment(
                      enumerator: TransactionType.incomes, title: 'Доходы'),
                  PickerSegment(
                      enumerator: TransactionType.expenses, title: 'Расходы'),
                ]),
          ),
          BlocBuilder<StatsBloc, StatsState>(
            builder: (context, state) {
              if (state is StatsLoading) return const SizedBox.shrink();
              if (state is StatsError) {
                return Center(child: Text(state.reasonUI));
              }
              if (state is StatsLoaded) {
                final valueKopecks = state.sumForTransactionType(currentView);
                final valueFormatted =
                    AppFormatters.formatRublesWithSeparatorsAndDecimalPart(
                        valueKopecks / 100,
                        decimalDigits: 2);
                if (valueKopecks == 0) {
                  return Expanded(child: NoDataPlaceholder());
                }
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16)
                        .copyWith(top: 12),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Center(
                            child: AutoSizeText(
                              valueFormatted,
                              maxFontSize: 32,
                              minFontSize: 20,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(child: const SizedBox(height: 16)),
                        SliverToBoxAdapter(
                          child: Chart(
                              isIncome: currentView.isIncome,
                              segments: state.getChartSegments(currentView),
                              totalValue:
                                  state.sumForTransactionType(currentView)),
                        ),
                        SliverToBoxAdapter(child: const SizedBox(height: 8)),
                        CategoriesTotalsList(transactionType: currentView),
                        SliverToBoxAdapter(child: const SizedBox(height: 16)),
                      ],
                    ),
                  ),
                );
              }
              throw UnimplementedError();
            },
          )
        ],
      ),
    );
  }
}

class NoDataPlaceholder extends StatelessWidget {
  const NoDataPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: context.window.width * 0.7,
        child: Text(
          'Недостаточно данных для анализа. Добавьте транзакции.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
