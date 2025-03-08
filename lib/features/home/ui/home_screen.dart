import 'package:budget/core/misc/extensions.dart';
import 'package:budget/features/home/ui/bloc/home_bloc.dart';
import 'package:budget/features/home/ui/bloc/states.dart';
import 'package:budget/features/home/ui/filter/filter_bottom_sheet.dart';
import 'package:budget/features/home/ui/widgets/list_shimmer.dart';
import 'package:budget/features/home/ui/widgets/placeholders.dart';
import 'package:budget/features/home/ui/widgets/summary.dart';
import 'package:budget/features/home/ui/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Сводка'),
          actions: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is! HomeLoaded) return const SizedBox.shrink();
                if (!state.hasFilters) return const SizedBox.shrink();
                return Text(
                  '(${state.filtersCount})',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                );
              },
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is! HomeLoaded) return const SizedBox.shrink();
                return IconButton(
                    iconSize: 32,
                    onPressed: () => _showFilterBottomSheet(context),
                    icon: state.hasFilters
                        ? Icon(Icons.filter_alt, color: context.colors.contrast)
                        : const Icon(Icons.filter_alt_outlined));
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is! HomeLoaded) return SummaryBlock.loading();
                  return SummaryBlock.loaded(
                      state.totalIncomes, state.totalExpenses);
                },
              )),
              SliverToBoxAdapter(child: Divider(height: 32, thickness: 2)),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return SliverToBoxAdapter(child: ListShimmer());
                  }
                  if (state is HomeError) {
                    return SliverToBoxAdapter(
                        child: Center(child: Text(state.reasonUI)));
                  }
                  if (state is! HomeLoaded) return const SizedBox.shrink();
                  if (state.transactionsWithCategory.isEmpty) {
                    return SliverFillRemaining(
                        hasScrollBody: false,
                        child: NoTransactionsPlaceholder());
                  }
                  if (state.filtered.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: TransactionsNotFoundPlaceholder(),
                    );
                  }
                  return SliverPadding(
                    padding: EdgeInsets.only(bottom: 16),
                    sliver: TransactionsList(
                      transactions: state.filtered,
                      calculator: state.calculator,
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (modalContext) {
          return BlocProvider.value(
              value: context.read<HomeBloc>(),
              child: SafeArea(child: FilterBottomSheet()));
        });
  }
}
