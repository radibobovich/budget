import 'package:auto_route/auto_route.dart';
import 'package:budget/core/widgets/close_button.dart';
import 'package:budget/features/home/ui/filter/categories_carousel.dart';
import 'package:budget/features/home/ui/filter/date_range_picker.dart';
import 'package:budget/features/home/ui/bloc/events.dart';
import 'package:budget/features/home/ui/bloc/home_bloc.dart';
import 'package:budget/features/home/ui/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Фильтры',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    const Spacer(),
                    CloseBackButton(onTap: () {
                      context.router.pop();
                    })
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'По категориям',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is! HomeLoaded) return const SizedBox.shrink();
              return CategoriesCarousel(
                categories: state.categories,
                selectedIds: state.categoriesIdFilter,
                onTap: (category) {
                  final bloc = context.read<HomeBloc>();
                  bloc.add(HomeCategoryFilterAdded(category.id));
                },
                onDeselect: (category) {
                  final bloc = context.read<HomeBloc>();
                  bloc.add(HomeCategoryFilterRemoved(category.id));
                },
              );
            },
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'По дате',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 8),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is! HomeLoaded) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DateRangePicker(
                    initialStartDate: state.startDateFilter,
                    initialEndDate: state.endDateFilter),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
