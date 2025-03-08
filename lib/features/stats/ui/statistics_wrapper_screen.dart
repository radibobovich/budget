import 'package:auto_route/auto_route.dart';
import 'package:budget/core/data/categories_repository.dart';
import 'package:budget/core/data/transactions_repository.dart';
import 'package:budget/features/stats/ui/bloc/events.dart';
import 'package:budget/features/stats/ui/bloc/stats_bloc.dart';
import 'package:budget/features/stats/ui/statistics_screen.dart';
import 'package:budget/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class StatsWrapperScreen extends StatelessWidget implements AutoRouteWrapper {
  const StatsWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StatsScreen();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => StatsBloc(getIt.get<TransactionsRepository>(),
          getIt.get<CategoriesRepository>())
        ..add(StatsSubscribed()),
      child: this,
    );
  }
}
